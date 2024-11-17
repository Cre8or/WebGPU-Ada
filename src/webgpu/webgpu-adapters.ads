pragma License (Unrestricted);





private with Ada.Finalization;

        with WebGPU.Devices;
private with WebGPU.API;
        with WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (WebGPU.Devices);
pragma Elaborate_All (WebGPU.Types);
pragma Elaborate_All (WebGPU.API);




package WebGPU.Adapters is



	-- Use clauses
	use WebGPU.Devices;
	use WebGPU.Types;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU adapters. Performs automatic reference counting.
	-- To create an adapter, refer to WebGPU.Instances.
	--------------------------------------------------------------------------------------------------------------------------------
	type T_Adapter is tagged private;

		-- Primitives
		--------------------------------------------------------------------------------------------------------------------------------
		-- Returns true if the WebGPU adapter has been initialised (is not null), otherwise false.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Adapter) return Boolean
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Requests a WebGPU device from the adapter. The adapter must be initialised.
		--
		-- This function optionally accepts a list of features that the returned device should have.
		-- Device_Lost_Callback, if set, should point to a callback procedure for when the device becomes unuseable. Care must be taken
		-- to pevent concurrency issues when the procedure is called!
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding function Request_Device (
			This                 : in T_Adapter;
			Features             : in T_Feature_Name_Arr     := (1 .. 0 => <>);
			Device_Lost_Callback : in T_Device_Lost_Callback := null
		) return T_Device
		with Inline;

		--------------------------------------------------------------------------------------------------------------------------------
		-- Helper function to set the adapter's raw pointer. For internal use only.
		--------------------------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Adapter;
			Raw  : in     T_WGPUAdapter
		) with Inline;



private



	-- Use clauses
	use WebGPU.API;



	-- Types
	type T_Request_Userdata is record
		Device        : T_WGPUDevice;
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



	-- Specifications
	--------------------------------------------------------------------------------------------------------------------------------
	procedure Request_Device_Callback (
		status   : T_Request_Device_Status;
		device   : T_WGPUDevice;
		message  : T_WGPUStringView;
		userdata : T_Address := C_Null_Address
	) with Convention => C;

	--------------------------------------------------------------------------------------------------------------------------------
	procedure Internal_Device_Lost_Callback (
		device   : in T_WGPUDevice;
		reason   : in T_Device_Lost_Reason;
		message  : in T_WGPUStringView;
		userdata : in T_Device_Lost_Callback := null
	) with Convention => C;



	-- Imports
	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterRequestDevice (
		adapter    : in T_WGPUAdapter;
		descriptor : access constant T_WGPUDeviceDescriptor;
		callback   : in T_WGPURequestDeviceCallback;
		userdata   : in T_Address := C_Null_Address
	) with Import, Convention => C, External_Name => "wgpuAdapterRequestDevice";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterAddRef (adapter : in T_WGPUAdapter)
	with Import, Convention => C, External_Name => "wgpuAdapterAddRef";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterRelease (adapter : in T_WGPUAdapter)
	with Import, Convention => C, External_Name => "wgpuAdapterRelease";



end WebGPU.Adapters;
