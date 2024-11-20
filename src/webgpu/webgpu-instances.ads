pragma License (Unrestricted);




private with Ada.Finalization;

        with WebGPU.Adapters;
private with WebGPU.API;
        with WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (WebGPU.Adapters);
pragma Elaborate_All (WebGPU.API);
pragma Elaborate_All (WebGPU.Types);





package WebGPU.Instances is



	-- Use clauses
	use WebGPU.Adapters;
	use WebGPU.Types;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU instances. Performs automatic reference counting.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Instance is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the instance has been initialised (is not null), otherwise false.
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
		-- Compatibility_Mode allows backends that aren't 100% compliant to be used (in particular OpenGL/OpenGLES).
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Request_Adapter (
			This                   : in T_Instance;
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



	-- Use clauses
	use WebGPU.API;



	-- Types
	type T_Request_Userdata is record
		Adapter       : T_WGPUAdapter;
		Request_Ended : Boolean := false;
	end record
	with Convention => C_Pass_By_Copy;

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
	procedure Request_Instance_Callback (
		status   : T_Request_Adapter_Status;
		adapter  : T_WGPUAdapter;
		message  : T_WGPUStringView;
		userdata : T_Address := C_Null_Address
	) with Convention => C;



end WebGPU.Instances;
