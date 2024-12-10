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





with Cre8or_WebGPU.API;
with Cre8or_WebGPU.Exceptions;



pragma Elaborate_All (Cre8or_WebGPU.API);
pragma Elaborate_All (Cre8or_WebGPU.Exceptions);





package body Cre8or_WebGPU.Devices is



	-- Use clauses
	use Cre8or_WebGPU.API;
	use Cre8or_WebGPU.Exceptions;



	-- Types
	---------------------------------------------------------------------------------------------------------------------
	-- T_Device
	---------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Device) return Boolean is
	begin

		return This.m_Device /= null;

	end Is_Initialised;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Get_Raw_Internal (This : in T_Device) return T_WGPUDevice is
	begin

		return This.m_Device;

	end Get_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This : in out T_Device;
		Raw  : in     T_WGPUDevice
	) is
	begin

		This.Finalize;
		This.m_Device := Raw;
		This.Adjust;

	end Set_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Get_Limits (This : in T_Device) return T_Device_Limits is

		Result : T_Status;
		Data   : aliased T_WGPUSupportedLimits;

	begin

		if This.m_Device = null then
			raise EX_DEVICE_NOT_INITIALISED;
		end if;

		Result := wgpuDeviceGetLimits (This.m_Device, Data'Access);

		if Result /= E_Success then
			raise EX_REQUEST_ERROR;
		end if;

		return Data.limits;

	end Get_Limits;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Get_Queue (This : in out T_Device) return T_Queue is

		Queue          : T_Queue;
		Queue_Internal : T_WGPUQueue;

	begin

		if This.m_Device = null then
			raise EX_DEVICE_NOT_INITIALISED;
		end if;

		Queue_Internal := wgpuDeviceGetQueue (This.m_Device);
		Queue.Set_Raw_Internal (Queue_Internal);

		return Queue;

	end Get_Queue;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Create_Command_Encoder (
		This  : in out T_Device;
		Label : in     String := ""
	) return T_Command_Encoder is

		Encoder          : T_Command_Encoder;
		Encoder_Internal : T_WGPUCommandEncoder;
		Descriptor       : aliased T_WGPUCommandEncoderDescriptor;

		String_View : T_WGPUStringView;
		Label_C     : aliased T_Char_Array := To_C (Label);

	begin

		if This.m_Device = null then
			raise EX_DEVICE_NOT_INITIALISED;
		end if;

		-- Handle the label, if it is set
		if Label /= "" then
			String_View.data   := To_Chars_Ptr (Label_C'Unchecked_Access);
			String_View.length := Label_C'Length;

			Descriptor.label := String_View;
		end if;

		Encoder_Internal := wgpuDeviceCreateCommandEncoder (This.m_Device, Descriptor'Access);
		Encoder.Set_Raw_Internal (Encoder_Internal);

		return Encoder;

	end Create_Command_Encoder;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Poll (This : in out T_Device) is
	begin

		if This.m_Device = null then
			raise EX_DEVICE_NOT_INITIALISED;
		end if;

		wgpuDeviceTick (This.m_Device);

	end Poll;



-- PRIVATE



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Device
	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Device) is
	begin

		if This.m_Device = null then
			return;
		end if;

		wgpuDeviceAddRef (This.m_Device);

	end Adjust;

	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Device) is
	begin

		if This.m_Device = null then
			return;
		end if;

		wgpuDeviceRelease (This.m_Device);
		This.m_Device := null;

	end Finalize;



end Cre8or_WebGPU.Devices;
