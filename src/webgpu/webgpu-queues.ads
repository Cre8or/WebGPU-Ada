pragma License (Unrestricted);





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
			This    : in T_Queue;
			Command : in T_Command_Buffer
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
