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

        with WebGPU.Commands;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (WebGPU.Commands);





package WebGPU.Queues is



	-- Use clauses
	use WebGPU.Commands;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU queues. Performs automatic reference counting.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Queue is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the queue has been initialised (is not null), otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Queue) return Boolean
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Helper function to set the queue's raw pointer. For internal use only.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Queue;
			Raw  : in     T_WGPUQueue
		) with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Submits a command buffer to the queue's device for execution.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding procedure Submit (
			This    : in out T_Queue;
			Command : in     T_Command_Buffer
		) with Inline;



private



	-- Types
	type T_Queue is new Ada.Finalization.Controlled with record
		m_Queue : T_WGPUQueue;
	end record;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Queue)
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Queue)
		with Inline;



end WebGPU.Queues;
