pragma License (Unrestricted);





private with Ada.Finalization;

        with WebGPU.Queues;
        with WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (WebGPU.Queues);
pragma Elaborate_All (WebGPU.Types);





package WebGPU.Devices is



	-- Use clauses
	use WebGPU.Queues;
	use WebGPU.Types;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU devices. Performs automatic reference counting.
	-- To create a device, refer to WebGPU.Adapters.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Device is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the device has been initialised (is not null), otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Device) return Boolean
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Helper function to set the devices's raw pointer. For internal use only.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Device;
			Raw  : in     T_WGPUDevice
		) with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns the device's limits. The device must be initialised.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Get_Limits (This : in T_Device) return T_Device_Limits
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns the device's default queue. The device must be initialised.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Get_Queue (This : in out T_Device) return T_Queue
		with Inline;



private



	-- Types
	type T_Device is new Ada.Finalization.Controlled with record
		m_Device : T_WGPUDevice;

		m_Queue : T_Queue;
	end record;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Device)
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Device)
		with Inline;



end WebGPU.Devices;
