pragma License (Unrestricted);





private with Ada.Finalization;



pragma Elaborate_All (Ada.Finalization);





-- TODO: Rename to WebGPU.Commands
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
	-- Wrapper handle for WebGPU command encoders.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Command_Encoder is tagged private;



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
