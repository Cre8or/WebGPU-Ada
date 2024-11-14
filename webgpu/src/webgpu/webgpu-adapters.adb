pragma License (Unrestricted);





package body WebGPU.Adapters is



	-- Primitives
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Adapter
	--------------------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Adapter) return Boolean is
	begin

		return This.m_Adapter /= null;

	end Is_Initialised;

	--------------------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This : in out T_Adapter;
		Raw  : in     T_WGPUAdapter
	) is
	begin

		This.m_Adapter := Raw;

	end Set_Raw_Internal;



-- PRIVATE



	-- Primitives
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Adapter
	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Adapter) is
	begin

		if This.m_Adapter = null then
			return;
		end if;

		wgpuAdapterAddRef (This.m_Adapter);

	end Adjust;

	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Adapter) is
	begin

		if This.m_Adapter = null then
			return;
		end if;

		wgpuAdapterRelease (This.m_Adapter);

	end Finalize;



end WebGPU.Adapters;
