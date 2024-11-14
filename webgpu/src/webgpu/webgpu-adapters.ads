pragma License (Unrestricted);





private with Ada.Finalization;



pragma Elaborate_All (Ada.Finalization);





package WebGPU.Adapters is



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU adapters. Performs automatic reference counting.
	-- To create an adapter, refer to WebGPU.Instances.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Adapter is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the WebGPU adapter has been initialised (is not null), otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Adapter) return Boolean
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Helper function to set the adapter's raw pointer. For internal use only.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Adapter;
			Raw  : in     T_WGPUAdapter
		) with Inline;



private



	-- Types
	type T_Adapter is new Ada.Finalization.Controlled with record
		m_Adapter : T_WGPUAdapter;
	end record;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Adapter)
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Adapter)
		with Inline;



	-- Imports
	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterAddRef (adapter : in T_WGPUAdapter)
	with Import, Convention => C, External_Name => "wgpuAdapterAddRef"; -- wgpuAdapterReference

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterRelease (adapter : in T_WGPUAdapter)
	with Import, Convention => C, External_Name => "wgpuAdapterRelease";



end WebGPU.Adapters;
