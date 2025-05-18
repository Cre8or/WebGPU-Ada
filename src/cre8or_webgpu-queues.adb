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





package body Cre8or_WebGPU.Queues is



	-- Use clauses
	use Cre8or_WebGPU.API;
	use Cre8or_WebGPU.Exceptions;



	-- Types
	---------------------------------------------------------------------------------------------------------------------
	-- T_Queue
	---------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Queue) return Boolean is
	begin

		return This.m_Queue /= null;

	end Is_Initialised;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This : in out T_Queue;
		Raw  : in     T_WGPUQueue
	) is
	begin

		if Raw = null then
			raise EX_QUEUE_NOT_INITIALISED;
		end if;

		This.Finalize;
		This.m_Queue := Raw;
		This.Adjust;

	end Set_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Submit (
		This    : in out T_Queue;
		Command : in T_Command_Buffer
	) is

		Command_Internal : aliased T_WGPUCommandBuffer;

	begin

		if This.m_Queue = null then
			raise EX_QUEUE_NOT_INITIALISED;
		end if;

		if not Command.Is_Initialised then
			return;
		end if;

		Command_Internal := Command.Get_Raw_Internal;
		wgpuQueueSubmit (This.m_Queue, 1, Command_Internal'Address);

	end Submit;



-- PRIVATE



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Queue
	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Queue) is
	begin

		if This.m_Queue /= null then
			wgpuQueueAddRef (This.m_Queue);
		end if;

	end Adjust;

	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Queue) is
	begin

		if This.m_Queue /= null then
			wgpuQueueRelease (This.m_Queue);
		end if;

		This.m_Queue := null;

	end Finalize;



end Cre8or_WebGPU.Queues;
