pragma License (Unrestricted);





package WebGPU is



	-- Pragmas
	pragma Preelaborate;



	-- Types
	-- Internal types. Do not use.
	type T_WGPUInstanceImpl is private;
	type T_WGPUInstance is access all T_WGPUInstanceImpl;

	type T_WGPUAdapterImpl is private;
	type T_WGPUAdapter is access all T_WGPUAdapterImpl;

	type T_WGPUSurfaceImpl is private;
	type T_WGPUSurface is access all T_WGPUSurfaceImpl;

	type T_WGPUDeviceImpl is private;
	type T_WGPUDevice is access all T_WGPUDeviceImpl;



private



	-- Types
	type T_WGPUInstanceImpl is null record;

	type T_WGPUAdapterImpl is null record;

	type T_WGPUSurfaceImpl is null record;

	type T_WGPUDeviceImpl is null record;



end WebGPU;
