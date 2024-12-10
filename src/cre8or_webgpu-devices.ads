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

        with Cre8or_WebGPU.Commands;
        with Cre8or_WebGPU.Queues;
        with Cre8or_WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (Cre8or_WebGPU.Commands);
pragma Elaborate_All (Cre8or_WebGPU.Queues);
pragma Elaborate_All (Cre8or_WebGPU.Types);





package Cre8or_WebGPU.Devices is



	-- Use clauses
	use Cre8or_WebGPU.Commands;
	use Cre8or_WebGPU.Queues;
	use Cre8or_WebGPU.Types;



	-- Types
	---------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU devices. Performs automatic reference counting.
	-- To create a device, refer to WebGPU.Adapters.
	---------------------------------------------------------------------------------------------------------------------
	type T_Device is tagged private;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		-- Returns true if the device has been initialised (is not null), otherwise false.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Device) return Boolean
		with Inline;

		-----------------------------------------------------------------------------------------------------------------
		-- Helper function to retrieve the device's raw pointer. For internal use only.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Get_Raw_Internal (This : in T_Device) return T_WGPUDevice
		with Inline;

		-----------------------------------------------------------------------------------------------------------------
		-- Helper function to set the devices's raw pointer. For internal use only.
		-----------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Device;
			Raw  : in     T_WGPUDevice
		);

		-----------------------------------------------------------------------------------------------------------------
		-- Returns the device's limits. The device must be initialised.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Get_Limits (This : in T_Device) return T_Device_Limits;

		-----------------------------------------------------------------------------------------------------------------
		-- Returns the device's default queue. The device must be initialised.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Get_Queue (This : in out T_Device) return T_Queue;

		-----------------------------------------------------------------------------------------------------------------
		-- Creates and returns a command encoder for the device. The device must be initialised.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Create_Command_Encoder (
			This  : in out T_Device;
			Label : in     String := ""
		) return T_Command_Encoder;

		-----------------------------------------------------------------------------------------------------------------
		-- Polls the device. The device must be initialised.
		-----------------------------------------------------------------------------------------------------------------
		not overriding procedure Poll (This : in out T_Device);



private



	-- Types
	type T_Device is new Ada.Finalization.Controlled with record
		m_Device : T_WGPUDevice;
	end record;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Device);

		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Device);



end Cre8or_WebGPU.Devices;
