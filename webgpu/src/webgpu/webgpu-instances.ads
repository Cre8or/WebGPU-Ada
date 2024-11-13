pragma License (Unrestricted);





private with Ada.Finalization;

        with WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (WebGPU.Types);





package WebGPU.Instances is



	-- Use clauses
	use WebGPU.Types;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU instances. Performs automatic reference counting.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_WGPU_Instance is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the WebGPU instance has been initialised, otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_WGPU_Instance) return Boolean
		with Inline;



	-- Structures used to extend descriptors.
	type T_WGPUChainedStruct;
	type T_WGPUChainedStruct is record
		next  : access constant T_WGPUChainedStruct;  -- webgpu.h:1269
		sType : aliased T_WGPUSType := 0;  -- webgpu.h:1270
	end record
	with Convention => C_Pass_By_Copy;  -- webgpu.h:1268

	type T_WGPUChainedStructOut;
	type T_WGPUChainedStructOut is record
		next  : access T_WGPUChainedStructOut;  -- webgpu.h:1274
		sType : aliased T_WGPUSType := 0;  -- webgpu.h:1275
	end record
	with Convention => C_Pass_By_Copy;  -- webgpu.h:1273

	-- This struct chain is used as mutable in some places and immutable in others.
	type T_WGPUInstanceCapabilities is record
		nextInChain          : access T_WGPUChainedStructOut;  -- webgpu.h:1522
		timedWaitAnyEnable   : aliased T_WGPUBool := 0;  -- webgpu.h:1526
		timedWaitAnyMaxCount : aliased T_Size     := 0;  -- webgpu.h:1530
	end record
	with Convention => C_Pass_By_Copy;  -- webgpu.h:1520

	type T_WGPUInstanceDescriptor is record
		nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2063
		features    : aliased T_WGPUInstanceCapabilities;  -- webgpu.h:2067
	end record
	with Convention => C_Pass_By_Copy;  -- webgpu.h:2062



	-- Specifications
	--------------------------------------------------------------------------------------------------------------------------------
	-- Creates a new WebGPU instance. Assumes default values for the instance descriptor.
	--------------------------------------------------------------------------------------------------------------------------------
	function Create_Instance return T_WGPU_Instance
	with Inline;

	--------------------------------------------------------------------------------------------------------------------------------
	-- Creates a new WebGPU instance using the specified descriptor.
	--------------------------------------------------------------------------------------------------------------------------------
	function Create_Instance (Descriptor : in T_WGPUInstanceDescriptor) return T_WGPU_Instance
	with Inline;



private



	-- Types
	type T_WGPUInstanceImpl is null record;   -- incomplete struct
	type T_WGPUInstance is access all T_WGPUInstanceImpl;  -- webgpu.h:154

	type T_WGPU_Instance is new Ada.Finalization.Controlled with record
		m_Instance : T_WGPUInstance;
	end record;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_WGPU_Instance)
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_WGPU_Instance)
		with Inline;



	-- Specifications
	--------------------------------------------------------------------------------------------------------------------------------
	function wgpuCreateInstance (descriptor : access constant T_WGPUInstanceDescriptor) return T_WGPUInstance
	with Import, Convention => C, External_Name => "wgpuCreateInstance";

	--------------------------------------------------------------------------------------------------------------------------------
   procedure wgpuInstanceAddRef (instance : in T_WGPUInstance)  -- webgpu.h:3549
   with Import, Convention => C, External_Name => "wgpuInstanceAddRef";

	--------------------------------------------------------------------------------------------------------------------------------
   procedure wgpuInstanceRelease (instance : in T_WGPUInstance)  -- webgpu.h:3550
   with Import, Convention => C, External_Name => "wgpuInstanceRelease";



end WebGPU.Instances;
