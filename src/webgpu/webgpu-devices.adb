pragma License (Unrestricted);





with WebGPU.Exceptions;



pragma Elaborate_All (WebGPU.Exceptions);





package body WebGPU.Devices is



	-- Use clauses
	use WebGPU.Exceptions;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Device
	--------------------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Device) return Boolean is
	begin

		return This.m_Device /= null;

	end Is_Initialised;

	--------------------------------------------------------------------------------------------------------------------------------
	not overriding function Get_Limits (This : in T_Device) return T_Device_Limits is

		Result : T_Status;
		Data   : aliased T_WGPUSupportedLimits;

	begin

		if This.m_Device = null then
			raise EX_DEVICE_NOT_INITIALISED;
		end if;

		Result := wgpuDeviceGetLimits (This.m_Device, Data'Access);

		if Result /= E_Success then
			raise EX_REQUEST_ERROR;
		end if;

		return Data.limits;

	end Get_Limits;

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
		This.m_Device := null;

	end Finalize;



end WebGPU.Devices;
