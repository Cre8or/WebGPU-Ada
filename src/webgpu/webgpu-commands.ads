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



pragma Elaborate_All (Ada.Finalization);





package WebGPU.Commands is



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU command buffers. Performs automatic reference counting.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Command_Buffer is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the command buffer has been initialised (is not null), otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Command_Buffer) return Boolean
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Helper function to set the command buffers's raw pointer. For internal use only.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Command_Buffer;
			Raw  : in     T_WGPUCommandBuffer
		) with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Helper function to fetch the command buffer's raw pointer. For internal use only.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Get_Raw_Internal (This : in T_Command_Buffer) return T_WGPUCommandBuffer
		with Inline;

	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU command encoders. Performs automatic reference counting.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Command_Encoder is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the command encoder has been initialised (is not null), otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Command_Encoder) return Boolean
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Helper function to set the command encoder's raw pointer. For internal use only.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Command_Encoder;
			Raw  : in     T_WGPUCommandEncoder
		) with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Inserts a debug marker into the command encoder with the specified label. For development purposes. The command encoder must
		-- be initialised.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding procedure Insert_Debug_Marker (
			This  : in out T_Command_Encoder;
			Label : in     String
		) with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Signals that the command encoder is done receiving commands. Optionally assigns a label to the returned command buffer. The
		-- command encoder must be initialised.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Finish (
			This  : in out T_Command_Encoder'Class;
			Label : in     String := ""
		) return T_Command_Buffer
		with Inline;



private



	-- Types
	type T_Command_Buffer is new Ada.Finalization.Controlled with record
		m_Buffer : T_WGPUCommandBuffer;
	end record;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Command_Buffer)
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Command_Buffer)
		with Inline;

	type T_Command_Encoder is new Ada.Finalization.Controlled with record
		m_Encoder : T_WGPUCommandEncoder;
	end record;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Command_Encoder)
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Command_Encoder)
		with Inline;



end WebGPU.Commands;
