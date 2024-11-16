pragma License (Unrestricted);





package body WebGPU.Devices is



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Device
	--------------------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Device) return Boolean is
	begin

		return This.m_Device /= null;

	end Is_Initialised;

	--------------------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This : in out T_Device;
		Raw  : in     T_WGPUDevice
	) is
	begin

		This.m_Device := Raw;

	end Set_Raw_Internal;




-- PRIVATE



	-- Primitives
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Device
	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Device) is
	begin

		if This.m_Device = null then
			return;
		end if;

		wgpuDeviceAddRef (This.m_Device);

	end Adjust;

	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Device) is
	begin

		if This.m_Device = null then
			return;
		end if;

		wgpuDeviceRelease (This.m_Device);

	end Finalize;



end WebGPU.Devices;
