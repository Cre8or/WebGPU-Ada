pragma License (Unrestricted);





private with Ada.Finalization;

private with WebGPU.API;
        with WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (WebGPU.API);
pragma Elaborate_All (WebGPU.Types);





package WebGPU.Devices is



	-- Use clauses
	use WebGPU.Types;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU devices. Performs automatic reference counting.
	-- To create a device, refer to WebGPU.Adapters.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Device is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the WebGPU device has been initialised (is not null), otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Device) return Boolean
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns the device's limits. The device must be initialised.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Get_Limits (This : in T_Device) return T_Device_Limits
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Helper function to set the devices's raw pointer. For internal use only.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Device;
			Raw  : in     T_WGPUDevice
		) with Inline;



private



	-- Use clauses
	use WebGPU.API;



	-- Types
	type T_Device is new Ada.Finalization.Controlled with record
		m_Device : T_WGPUDevice;
	end record;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Device)
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Device)
		with Inline;



	-- Imports
	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuDeviceAddRef (device : in T_WGPUDevice)
	with Import, Convention => C, External_Name => "wgpuDeviceAddRef";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuDeviceRelease (device : in T_WGPUDevice)
	with Import, Convention => C, External_Name => "wgpuDeviceRelease";

	--------------------------------------------------------------------------------------------------------------------------------
   function wgpuDeviceEnumerateFeatures (
		device   : in T_WGPUDevice;
		features : access T_Feature_Name
	) return T_Size
	with Import, Convention => C, External_Name => "wgpuDeviceEnumerateFeatures";

	--------------------------------------------------------------------------------------------------------------------------------
   function wgpuDeviceGetLimits (
		device : in T_WGPUDevice;
		limits : access T_WGPUSupportedLimits
	) return T_Status
	with Import, Convention => C, External_Name => "wgpuDeviceGetLimits";



end WebGPU.Devices;
