pragma License (Unrestricted);





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

		This.m_Queue := Raw;

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
