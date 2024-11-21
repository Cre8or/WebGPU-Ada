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





with WebGPU.API;
with WebGPU.Exceptions;



pragma Elaborate_All (WebGPU.API);
pragma Elaborate_All (WebGPU.Exceptions);





package body WebGPU.Queues is



	-- Use clauses
	use WebGPU.API;
	use WebGPU.Exceptions;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Queue
	--------------------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Queue) return Boolean is
	begin

		return This.m_Queue /= null;

	end Is_Initialised;

	--------------------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This : in out T_Queue;
		Raw  : in     T_WGPUQueue
	) is
	begin

		This.Finalize;
		This.m_Queue := Raw;
		This.Adjust;

	end Set_Raw_Internal;

	--------------------------------------------------------------------------------------------------------------------------------
	not overriding procedure Submit (
		This    : in T_Queue;
		Command : in T_Command_Buffer
	) is
	begin

		if This.m_Queue = null then
			raise EX_QUEUE_NOT_INITIALISED;
		end if;

		--wgpuQueueSubmit (This.m_queue, 1, Command.m_Buffer);

	end Submit;



-- PRIVATE



	-- Primitives
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Queue
	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Queue) is
	begin

		if This.m_Queue = null then
			return;
		end if;

		wgpuQueueAddRef (This.m_Queue);

	end Adjust;

	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Queue) is
	begin

		if This.m_Queue = null then
			return;
		end if;

		wgpuQueueRelease (This.m_Queue);
		This.m_Queue := null;

	end Finalize;



end WebGPU.Queues;
