pragma License (Unrestricted);





with WebGPU.Exceptions;



pragma Elaborate_All (WebGPU.Exceptions);





package body WebGPU.Instances is



	-- Use clauses
	use WebGPU.Exceptions;



	-- Primitives
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Instance
	--------------------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Instance) return Boolean is
	begin

		return This.m_Instance /= null;

	end Is_Initialised;

	--------------------------------------------------------------------------------------------------------------------------------
	not overriding function Request_Adapter (
		This                   : in T_Instance;
		Power_Preference       : in T_Power_Preference := E_Undefined;
		Backend_Type           : in T_Backend_Type     := E_Undefined;
		Force_Fallback_Adapter : in Boolean            := false;
		Compatibility_Mode     : in Boolean            := false
	) return T_Adapter is

		Adapter   : T_Adapter;
		Options   : aliased T_WGPURequestAdapterOptions;
		User_Data : aliased T_Request_Userdata;

	begin

		if This.m_Instance = null then
			raise EX_INSTANCE_NOT_INITIALISED;
		end if;

		Options := (
			powerPreference      => Power_Preference,
			backendType          => Backend_Type,
			forceFallbackAdapter => T_WGPUBool (Force_Fallback_Adapter),
			compatibilityMode    => T_WGPUBool (Compatibility_Mode),
			others               => <>
		);

		wgpuInstanceRequestAdapter (
			instance => This.m_Instance,
			options  => Options'Access,
			callback => Request_Callback'Access,
			userdata => User_Data'Address
		);

		-- Safeguard against potential Dawn issues (this should never happen, so we need to know about it)
		if not User_Data.Request_Ended then
			raise EX_REQUEST_ERROR with "wgpuInstanceRequestAdapter callback failed";
		end if;

		Adapter.Set_Raw_Internal (User_Data.Adapter);

		return Adapter;

	end Request_Adapter;



	-- Bodies
	--------------------------------------------------------------------------------------------------------------------------------
	function Create_Instance return T_Instance is
	begin

		return (Ada.Finalization.Controlled with
			m_Instance => wgpuCreateInstance (C_Null_Address)
		);

	end Create_Instance;



-- PRIVATE



	-- Primitives
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Instance
	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Instance) is
	begin

		if This.m_Instance = null then
			return;
		end if;

		wgpuInstanceAddRef (This.m_Instance);

	end Adjust;

	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Instance) is
	begin

		if This.m_Instance = null then
			return;
		end if;

		wgpuInstanceRelease (This.m_Instance);

	end Finalize;



	-- Bodies
	--------------------------------------------------------------------------------------------------------------------------------
	procedure Request_Callback (
		status   : T_Request_Adapter_Status;
		adapter  : T_WGPUAdapter;
		message  : T_WGPUStringView;
		userdata : T_Address := C_Null_Address
	) is

		pragma Unreferenced (status);
		pragma Unreferenced (message);

		User_Data : aliased T_Request_Userdata
		with Import, Address => userdata;

	begin

		User_Data.Adapter       := adapter;
		User_Data.Request_Ended := true;

	end Request_Callback;



end WebGPU.Instances;
