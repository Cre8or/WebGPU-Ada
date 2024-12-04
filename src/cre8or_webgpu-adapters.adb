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
	not overriding procedure Set_Raw_Internal (
		This : in out T_Adapter;
		Raw  : in     T_WGPUAdapter
	) is
	begin

		This.Finalize;
		This.m_Adapter := Raw;
		This.Adjust;

	end Set_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Request_Device (
		This                 : in T_Adapter;
		Features             : in T_Feature_Name_Arr     := (1 .. 0 => <>);
		Device_Lost_Callback : in T_Device_Lost_Callback := null
	) return T_Device is

		Device                    : T_Device;
		Descriptor                : aliased T_WGPUDeviceDescriptor;
		User_Data                 : aliased T_Request_Userdata;
		Device_Lost_Callback_Info : T_WGPUDeviceLostCallbackInfo;

	begin

		if This.m_Adapter = null then
			raise EX_ADAPTER_NOT_INITIALISED;
		end if;

		Device_Lost_Callback_Info.callback := Internal_Device_Lost_Callback'Access;
		Device_Lost_Callback_Info.userdata := Device_Lost_Callback;

		Descriptor := (
			requiredFeatureCount   => Features'Length,
			requiredFeatures       => (if Features'Length > 0 then Features (Features'First)'Unrestricted_Access else null),
			deviceLostCallbackInfo => Device_Lost_Callback_Info,
			others                 => <>
		);

		wgpuAdapterRequestDevice (
			adapter    => This.m_Adapter,
			descriptor => Descriptor'Access,
			callback   => Request_Device_Callback'Access,
			userdata   => User_Data'Address
		);

		-- Safeguard against potential Dawn issues (this should never happen, so we need to know about it)
		if not User_Data.Request_Ended then
			raise EX_REQUEST_ERROR with "wgpuAdapterRequestDevice callback failed";
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

		if This.m_Adapter = null then
			return;
		end if;

		wgpuAdapterAddRef (This.m_Adapter);

	end Adjust;

	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Adapter) is
	begin

		if This.m_Adapter = null then
			return;
		end if;

		wgpuAdapterRelease (This.m_Adapter);
		This.m_Adapter := null;

	end Finalize;



	-- Bodies
	---------------------------------------------------------------------------------------------------------------------
	procedure Request_Device_Callback (
		status   : T_Request_Device_Status;
		device   : T_WGPUDevice;
		message  : T_WGPUStringView;
		userdata : T_Address := C_Null_Address
	) is

		pragma Unreferenced (status);
		pragma Unreferenced (message);

		User_Data : aliased T_Request_Userdata
		with Import, Address => userdata;

	begin

		User_Data.Device        := device;
		User_Data.Request_Ended := true;

	end Request_Device_Callback;

	---------------------------------------------------------------------------------------------------------------------
	procedure Internal_Device_Lost_Callback (
		device   : in T_WGPUDevice;
		reason   : in T_Device_Lost_Reason;
		message  : in T_WGPUStringView;
		userdata : in T_Device_Lost_Callback := null
	) is

		pragma Unreferenced (device);
		pragma Unreferenced (message);

	begin

		if userdata /= null then
			userdata.all (reason, "test"); -- DEBUG
		end if;

	end Internal_Device_Lost_Callback;



end Cre8or_WebGPU.Adapters;
