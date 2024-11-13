pragma License (Unrestricted);





package body WebGPU.Instances is



	-- Primitives
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_WGPU_Instance
	--------------------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_WGPU_Instance) return Boolean is
	begin

		return This.m_Instance /= null;

	end Is_Initialised;



	-- Bodies
	--------------------------------------------------------------------------------------------------------------------------------
	function Create_Instance return T_WGPU_Instance is

		Dummy : T_WGPUInstanceDescriptor with Unmodified;

	begin

		return Create_Instance (Dummy);

	end Create_Instance;

	--------------------------------------------------------------------------------------------------------------------------------
	function Create_Instance (Descriptor : in T_WGPUInstanceDescriptor) return T_WGPU_Instance is
	begin

		return (Ada.Finalization.Controlled with
			m_Instance => wgpuCreateInstance (Descriptor'Unrestricted_Access)
		);

	end Create_Instance;



-- PRIVATE



	-- Primitives
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_WGPU_Instance
	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_WGPU_Instance) is
	begin

		if This.m_Instance = null then
			return;
		end if;

		wgpuInstanceAddRef (This.m_Instance);

	end Adjust;

	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_WGPU_Instance) is
	begin

		if This.m_Instance = null then
			return;
		end if;

		wgpuInstanceRelease (This.m_Instance);

	end Finalize;



end WebGPU.Instances;
