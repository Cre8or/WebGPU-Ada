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





private with Ada.Finalization;

private with Cre8or_WebGPU.API;
        with Cre8or_WebGPU.Devices;
        with Cre8or_WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (Cre8or_WebGPU.API);
pragma Elaborate_All (Cre8or_WebGPU.Devices);
pragma Elaborate_All (Cre8or_WebGPU.Types);





package Cre8or_WebGPU.Adapters is



	-- Use clauses
	use Cre8or_WebGPU.Devices;
	use Cre8or_WebGPU.Types;



	-- Types
	---------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU adapters. Performs automatic reference counting.
	-- To create an adapter, refer to WebGPU.Instances.
	---------------------------------------------------------------------------------------------------------------------
	type T_Adapter is tagged private;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		-- Returns true if the adapter has been initialised (is not null), otherwise false.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Adapter) return Boolean
		with Inline;

		-----------------------------------------------------------------------------------------------------------------
		-- Helper function to retrieve the adapter's raw pointer. For internal use only.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Get_Raw_Internal (This : in T_Adapter) return T_WGPUAdapter
		with Inline;

		-----------------------------------------------------------------------------------------------------------------
		-- Helper function to set the adapter's raw pointers. For internal use only.
		-----------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This         : in out T_Adapter;
			Raw_Instance : in     T_WGPUInstance;
			Raw_Adapter  : in     T_WGPUAdapter
		);

		-----------------------------------------------------------------------------------------------------------------
		-- Requests a WebGPU device from the adapter. The adapter must be initialised.
		--
		-- This function optionally accepts a list of features that the returned device should have.
		-- Device_Lost_Callback, if set, should point to a callback procedure for when the device becomes unuseable.
		-- Uncaptured_Error_Callback, if set, should point to a callback procedure that handles additional errors which
		-- have not yet been captured on any higher levels.
		-- Care must be taken to pevent concurrency issues when the callback procedures are called!
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Request_Device (
			This                      : in T_Adapter;
			Features                  : in T_Feature_Name_Arr          := (1 .. 0 => <>);
			Device_Lost_Callback      : in T_Device_Lost_Callback      := null;
			Uncaptured_Error_Callback : in T_Uncaptured_Error_Callback := null
		) return T_Device;



private



	-- Use clauses
	use Cre8or_WebGPU.API;



	-- Types
	type T_Request_Device_User_Data is record
		Device        : T_WGPUDevice;
		Request_Ended : Boolean := false;
		Status        : T_Request_Device_Status;
	end record
	with Convention => C_Pass_By_Copy;

	type T_Adapter is new Ada.Finalization.Controlled with record
		m_Instance : T_WGPUInstance;
		m_Adapter  : T_WGPUAdapter;
	end record;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Adapter);

		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Adapter);



	-- Specifications
	---------------------------------------------------------------------------------------------------------------------
	procedure Internal_Request_Device_Callback ( -- Matches T_WGPURequestDeviceCallback
		status    : in T_Request_Device_Status;
		device    : in T_WGPUDevice;
		message   : in T_WGPUStringView;
		userdata1 : in T_Address := C_Null_Address;
		userdata2 : in T_Address := C_Null_Address
	) with Convention => C;

	-- TODO: Move the following ṕrocedures into Cre8or_WebGPU.Devices?
	---------------------------------------------------------------------------------------------------------------------
	procedure Internal_Device_Lost_Callback ( -- Matches T_WGPUDeviceLostCallback
		device    : in T_WGPUDevice;
		kind      : in T_Device_Lost_Reason;
		message   : in T_WGPUStringView;
		userdata1 : in T_Device_Lost_Callback;
		userdata2 : in T_Address := C_Null_Address
	) with Convention => C;

	---------------------------------------------------------------------------------------------------------------------
	procedure Internal_Uncaptured_Error_Callback ( -- Matches T_WGPUUncapturedErrorCallback
		device    : in T_WGPUDevice;
		kind      : in T_Error_Kind;
		message   : in T_WGPUStringView;
		userdata1 : in T_Uncaptured_Error_Callback;
		userdata2 : in T_Address := C_Null_Address
	) with Convention => C;



end Cre8or_WebGPU.Adapters;
