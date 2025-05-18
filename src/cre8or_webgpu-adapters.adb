------------------------------------------------------------------------------------------------------------------------
--  Copyright 2024 Cre8or                                                                                             --
--                                                                                                                    --
--  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance    --
--  with the License. You may obtain a copy of the License at                                                         --
--                                                                                                                    --
--     http://www.apache.org/licenses/LICENSE-2.0                                                                     --
--                                                                                                                    --
--  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed  --
--  on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                     --
--  See the License for the specific language governing permissions and limitations under the License.                --
------------------------------------------------------------------------------------------------------------------------





with Cre8or_WebGPU.Exceptions;



pragma Elaborate_All (Cre8or_WebGPU.Exceptions);





package body Cre8or_WebGPU.Adapters is



	-- Use clauses
	use Cre8or_WebGPU.Exceptions;



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Adapter
	---------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Adapter) return Boolean is
	begin

		return This.m_Adapter /= null;

	end Is_Initialised;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Get_Raw_Internal (This : in T_Adapter) return T_WGPUAdapter is
	begin

		return This.m_Adapter;

	end Get_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This         : in out T_Adapter;
		Raw_Instance : in     T_WGPUInstance;
		Raw_Adapter  : in     T_WGPUAdapter
	) is
	begin

		if Raw_Instance = null then
			raise EX_INSTANCE_NOT_INITIALISED;
		end if;

		if Raw_Adapter = null then
			raise EX_ADAPTER_NOT_INITIALISED;
		end if;

		This.Finalize;
		This.m_Instance := Raw_Instance;
		This.m_Adapter  := Raw_Adapter;
		This.Adjust;

	end Set_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Request_Device (
		This                      : in T_Adapter;
		Features                  : in T_Feature_Name_Arr          := (1 .. 0 => <>);
		Device_Lost_Callback      : in T_Device_Lost_Callback      := null;
		Uncaptured_Error_Callback : in T_Uncaptured_Error_Callback := null
	) return T_Device is

		Device    : T_Device;
		Options   : aliased T_WGPUDeviceDescriptor;
		User_Data : aliased T_Request_Device_User_Data;

		Device_Lost_Callback_Info      : aliased T_WGPUDeviceLostCallbackInfo;
		Uncaptured_Error_Callback_Info : aliased T_WGPUUncapturedErrorCallbackInfo;
		Request_Device_Callback_Info   : aliased T_WGPURequestDeviceCallbackInfo;

	begin

		if This.m_Adapter = null then
			raise EX_ADAPTER_NOT_INITIALISED;
		end if;

		Device_Lost_Callback_Info := (
			callback  => Internal_Device_Lost_Callback'Access,
			userdata1 => Device_Lost_Callback,
			others    => <>
		);

		Uncaptured_Error_Callback_Info := (
			callback  => Internal_Uncaptured_Error_Callback'Access,
			userdata1 => Uncaptured_Error_Callback,
			others    => <>
		);

		Options := (
			requiredFeatureCount        => Features'Length,
			requiredFeatures            => (if Features'Length > 0 then Features (Features'First)'Unrestricted_Access else null),
			deviceLostCallbackInfo      => Device_Lost_Callback_Info,
			uncapturedErrorCallbackInfo => Uncaptured_Error_Callback_Info,
			others                      => <>
		);

		Request_Device_Callback_Info := (
			callback  => Internal_Request_Device_Callback'Access,
			userdata1 => User_Data'Address,
			others    => <>
		);

		wgpuAdapterRequestDevice (
			adapter      => This.m_Adapter,
			options      => Options'Access,
			callbackInfo => Request_Device_Callback_Info
		);

		-- Spin-lock until we get a response
		Loop_Await_Device :
		for I in 1 .. 100 loop
			wgpuInstanceProcessEvents (This.m_Instance);

			if User_Data.Request_Ended then
				exit Loop_Await_Device;
			end if;

			delay 0.01;
		end loop Loop_Await_Device;

		-- Handle time-out
		if not User_Data.Request_Ended then
			raise EX_REQUEST_ERROR with "wgpuAdapterRequestDevice timed out";
		end if;

		-- Handle error status
		if User_Data.Status /= E_Success then
			raise EX_REQUEST_ERROR with "wgpuAdapterRequestDevice returned status " & User_Data.Status'Img;
		end if;

		Device.Set_Raw_Internal (User_Data.Device);

		return Device;

	end Request_Device;



-- PRIVATE



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Adapter
	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Adapter) is
	begin

		if This.m_Instance /= null then
			wgpuInstanceAddRef (This.m_Instance);
		end if;

		if This.m_Adapter /= null then
			wgpuAdapterAddRef (This.m_Adapter);
		end if;

	end Adjust;

	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Adapter) is
	begin

		if This.m_Instance /= null then
			wgpuInstanceRelease (This.m_Instance);
		end if;

		if This.m_Adapter /= null then
			wgpuAdapterRelease (This.m_Adapter);
		end if;

		This.m_Instance := null;
		This.m_Adapter := null;

	end Finalize;



	-- Bodies
	---------------------------------------------------------------------------------------------------------------------
	procedure Internal_Request_Device_Callback (
		status    : in T_Request_Device_Status;
		device    : in T_WGPUDevice;
		message   : in T_WGPUStringView;
		userdata1 : in T_Address := C_Null_Address;
		userdata2 : in T_Address := C_Null_Address
	) is

		pragma Unreferenced (message);
		pragma Unreferenced (userdata2);

		User_Data : aliased T_Request_Device_User_Data
		with Import, Address => userdata1;

	begin

		User_Data.Device        := device;
		User_Data.Request_Ended := true;
		User_Data.Status        := status;

	end Internal_Request_Device_Callback;

	---------------------------------------------------------------------------------------------------------------------
	procedure Internal_Device_Lost_Callback (
		device    : in T_WGPUDevice;
		kind      : in T_Device_Lost_Reason;
		message   : in T_WGPUStringView;
		userdata1 : in T_Device_Lost_Callback;
		userdata2 : in T_Address := C_Null_Address
	) is

		pragma Unreferenced (message);
		pragma Unreferenced (userdata2);

	begin

		if userdata1 /= null then
			userdata1.all (device, kind);
		end if;

	end Internal_Device_Lost_Callback;

	---------------------------------------------------------------------------------------------------------------------
	procedure Internal_Uncaptured_Error_Callback (
		device    : in T_WGPUDevice;
		kind      : in T_Error_Kind;
		message   : in T_WGPUStringView;
		userdata1 : in T_Uncaptured_Error_Callback;
		userdata2 : in T_Address := C_Null_Address
	) is

		pragma Unreferenced (message);
		pragma Unreferenced (userdata2);

	begin

		if userdata1 /= null then
			userdata1.all (device, kind);
		end if;

	end Internal_Uncaptured_Error_Callback;



end Cre8or_WebGPU.Adapters;
