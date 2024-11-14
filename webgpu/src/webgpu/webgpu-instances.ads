pragma License (Unrestricted);




private with Ada.Finalization;
private with System;

        with WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);
pragma Elaborate_All (System);

pragma Elaborate_All (WebGPU.Types);





package WebGPU.Instances is



	-- Use clauses
	use WebGPU.Types;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU adapters. Performs automatic reference counting.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Adapter is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the WebGPU adapter has been initialised (is not null), otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Adapter) return Boolean
		with Inline;

	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU instances. Performs automatic reference counting.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Instance is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the WebGPU instance has been initialised (is not null), otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Instance) return Boolean
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Requests and returns an adapter for use with this instance.
		-- If the instance isn't initialised, the exception EX_INSTANCE_NOT_INITIALISED is raised.
		-- Arguments:
		-- Power_Preference sets which to choose, if multiple adapters are present, based on their power profile. High-performance
		-- often correponds to a discrete GPU, while low-power often corresponds to an integrated GPU.
		-- Backend_Type sets the particular backend the adapter should use. If this is not possible, an empty handle is returned.
		-- If Force_Fallback_Adapter is true, requires the adapter to have a particular backend type. If this is not possible, an empty
		-- handle is returned.
		-- Compatibility_Mode: TODO
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Request_Adapter (
			This                   : in T_Instance'Class;
			Power_Preference       : in T_Power_Preference := E_Undefined;
			Backend_Type           : in T_Backend_Type     := E_Undefined;
			Force_Fallback_Adapter : in Boolean            := false;
			Compatibility_Mode     : in Boolean            := false
		) return T_Adapter
		with Inline;



	-- Specifications
	--------------------------------------------------------------------------------------------------------------------------------
	-- Creates a new WebGPU instance.
	--------------------------------------------------------------------------------------------------------------------------------
	function Create_Instance return T_Instance
	with Inline;



private



	-- Types
	type T_WGPUInstanceImpl is null record;   -- incomplete struct
	type T_WGPUInstance is access all T_WGPUInstanceImpl;  -- webgpu.h:154

	type T_WGPUAdapterImpl is null record;   -- incomplete struct
	type T_WGPUAdapter is access all T_WGPUAdapterImpl;  -- webgpu.h:145

	type T_WGPUSurfaceImpl is null record;   -- incomplete struct
	type T_WGPUSurface is access all T_WGPUSurfaceImpl;  -- webgpu.h:167

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

	type T_WGPUStringView is record
		data   : T_Chars_Ptr;  -- webgpu.h:121
		length : aliased T_Size := 0;  -- webgpu.h:122
	end record
	with Convention => C_Pass_By_Copy;  -- webgpu.h:120

	type T_WGPURequestAdapterCallback is access procedure (
		status   : T_WGPURequestAdapterStatus;
		adapter  : T_WGPUAdapter;
		message  : T_WGPUStringView;
		userdata : System.Address := System.Null_Address
	) with Convention => C;  -- webgpu.h:1242

	type T_WGPURequestAdapterOptions is record
		nextInChain          : access constant T_WGPUChainedStruct;
		compatibleSurface    : T_WGPUSurface;
		powerPreference      : aliased T_Power_Preference := E_Undefined;
		backendType          : aliased T_Backend_Type     := E_Undefined;
		forceFallbackAdapter : aliased T_WGPUBool         := false;
		compatibilityMode    : aliased T_WGPUBool         := false;
	end record
	with Convention => C_Pass_By_Copy;

	-- Custom userdata type
	type T_WGPUAdapter_Request_Userdata is record
		Adapter       : T_WGPUAdapter;
		Request_Ended : Boolean := false;
	end record
	with Convention => C_Pass_By_Copy;

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


	type T_Instance is new Ada.Finalization.Controlled with record
		m_Instance : T_WGPUInstance;
	end record;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Instance)
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Instance)
		with Inline;



	-- Specifications
	--------------------------------------------------------------------------------------------------------------------------------
	procedure Request_Callback (
		status   : T_WGPURequestAdapterStatus;
		adapter  : T_WGPUAdapter;
		message  : T_WGPUStringView;
		userdata : System.Address := System.Null_Address
	) with Inline, Convention => C;



	-- Imports
	--------------------------------------------------------------------------------------------------------------------------------
   procedure wgpuInstanceRequestAdapter (
		instance : in T_WGPUInstance;
		options  : access constant T_WGPURequestAdapterOptions;
		callback : in T_WGPURequestAdapterCallback;
		userdata : in System.Address
	) with Import, Convention => C, External_Name => "wgpuInstanceRequestAdapter";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterAddRef (adapter : in T_WGPUAdapter)
	with Import, Convention => C, External_Name => "wgpuAdapterAddRef"; -- wgpuAdapterReference

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterRelease (adapter : in T_WGPUAdapter)
	with Import, Convention => C, External_Name => "wgpuAdapterRelease";

	--------------------------------------------------------------------------------------------------------------------------------
	function wgpuCreateInstance (descriptor : in System.Address) return T_WGPUInstance
	with Import, Convention => C, External_Name => "wgpuCreateInstance";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuInstanceAddRef (instance : in T_WGPUInstance)
	with Import, Convention => C, External_Name => "wgpuInstanceAddRef"; -- wgpuInstanceReference

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuInstanceRelease (instance : in T_WGPUInstance)
	with Import, Convention => C, External_Name => "wgpuInstanceRelease";



end WebGPU.Instances;
