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





package body Cre8or_WebGPU.Commands is



	-- Use clauses
	use Cre8or_WebGPU.API;
	use Cre8or_WebGPU.Exceptions;



	-- Types
	---------------------------------------------------------------------------------------------------------------------
	-- T_Command_Buffer
	---------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Command_Buffer) return Boolean is
	begin

		return This.m_Buffer /= null;

	end Is_Initialised;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This : in out T_Command_Buffer;
		Raw  : in     T_WGPUCommandBuffer
	) is
	begin

		This.Finalize;
		This.m_Buffer := Raw;
		This.Adjust;

	end Set_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Get_Raw_Internal (This : in T_Command_Buffer) return T_WGPUCommandBuffer is
	begin

		return This.m_Buffer;

	end Get_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	-- T_Command_Encoder
	---------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Command_Encoder) return Boolean is
	begin

		return This.m_Encoder /= null;

	end Is_Initialised;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This : in out T_Command_Encoder;
		Raw  : in     T_WGPUCommandEncoder
	) is
	begin

		This.Finalize;
		This.m_Encoder := Raw;
		This.Adjust;

	end Set_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Insert_Debug_Marker (
		This  : in out T_Command_Encoder;
		Label : in     String
	) is

		String_View : T_WGPUStringView;
		Label_C     : aliased T_Char_Array := To_C (Label);

	begin

		if This.m_Encoder = null then
			raise EX_COMMAND_ENCODER_NOT_INITIALISED;
		end if;

		-- Handle the label, if there is one
		if Label /= "" then
			String_View.data   := To_Chars_Ptr (Label_C'Unchecked_Access);
			String_View.length := Label_C'Length;
		end if;

		wgpuCommandEncoderInsertDebugMarker (This.m_Encoder, String_View);

	end Insert_Debug_Marker;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Finish (
		This  : in out T_Command_Encoder'Class;
		Label : in     String := ""
	) return T_Command_Buffer is

		Command_Buffer          : T_Command_Buffer;
		Command_Buffer_Internal : T_WGPUCommandBuffer;
		Descriptor              : aliased T_WGPUCommandBufferDescriptor;

		String_View : T_WGPUStringView;
		Label_C     : aliased T_Char_Array := To_C (Label);

	begin

		if This.m_Encoder = null then
			raise EX_COMMAND_ENCODER_NOT_INITIALISED;
		end if;

		-- Handle the label, if there is one
		if Label /= "" then
			String_View.data   := To_Chars_Ptr (Label_C'Unchecked_Access);
			String_View.length := Label_C'Length;

			Descriptor.label := String_View;
		end if;

		Command_Buffer_Internal := wgpuCommandEncoderFinish (This.m_Encoder, Descriptor'Access);
		Command_Buffer.Set_Raw_Internal (Command_Buffer_Internal);

		return Command_Buffer;

	end Finish;



	-- Bodies



-- PRIVATE



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Command_Buffer
	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Command_Buffer) is
	begin

		if This.m_Buffer = null then
			return;
		end if;

		wgpuCommandBufferAddRef (This.m_Buffer);

	end Adjust;

	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Command_Buffer) is
	begin

		if This.m_Buffer = null then
			return;
		end if;

		wgpuCommandBufferRelease (This.m_Buffer);
		This.m_Buffer := null;

	end Finalize;

	---------------------------------------------------------------------------------------------------------------------
	-- T_Command_Encoder
	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Command_Encoder) is
	begin

		if This.m_Encoder = null then
			return;
		end if;

		wgpuCommandEncoderAddRef (This.m_Encoder);

	end Adjust;

	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Command_Encoder) is
	begin

		if This.m_Encoder = null then
			return;
		end if;

		wgpuCommandEncoderRelease (This.m_Encoder);
		This.m_Encoder := null;

	end Finalize;




end Cre8or_WebGPU.Commands;
