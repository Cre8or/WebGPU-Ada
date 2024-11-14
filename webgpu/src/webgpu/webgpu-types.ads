pragma License (Unrestricted);




with Interfaces.C.Strings;



pragma Elaborate_All (Interfaces.C.Strings);





package WebGPU.Types is



	-- Types
	type T_Byte   is new Interfaces.C.char;
	type T_UByte  is new Interfaces.C.unsigned_char;
	type T_Short  is new Interfaces.C.short;
	type T_UShort is new Interfaces.C.unsigned_short;
	type T_Int    is new Interfaces.C.int;
	type T_UInt   is new Interfaces.C.unsigned;
	type T_Long   is new Interfaces.C.long;
	type T_ULong  is new Interfaces.C.unsigned_long;

	type T_Float  is new Interfaces.C.C_float;
	type T_Double is new Interfaces.C.double;

	type T_Size   is new Interfaces.C.size_t;

	subtype T_Chars_Ptr is Interfaces.C.Strings.chars_ptr;

	type T_WGPUBool is new Boolean
	with Convention => C, Size => 32;

	type T_WGPUSType                is new T_UInt;
	type T_WGPUCallbackMode         is new T_UInt;
	type T_WGPURequestAdapterStatus is new T_UInt;

	type T_Power_Preference is (
		E_Undefined, -- No preference
		E_Low_Power,
		E_High_Performance
	) with Convention => C, Size => T_UInt'Size;

	for T_Power_Preference use (
		E_Undefined        => 0,
		E_Low_Power        => 1,
		E_High_Performance => 2
	);

	type T_Backend_Type is (
		E_Undefined, -- Indicates no value
		E_Null,
		E_WebGPU,
		E_D3D11,
		E_D3D12,
		E_Metal,
		E_Vulkan,
		E_OpenGL,
		E_OpenGLES
	) with Convention => C;

	for T_Backend_Type'Size use T_UInt'Size;
	for T_Backend_Type use (
		E_Undefined => 0,
		E_Null      => 1,
		E_WebGPU    => 2,
		E_D3D11     => 3,
		E_D3D12     => 4,
		E_Metal     => 5,
		E_Vulkan    => 6,
		E_OpenGL    => 7,
		E_OpenGLES  => 8
	);





	-- Constants
   C_SType_ShaderSourceSPIRV                : constant T_WGPUSType := 1;
   C_SType_ShaderSourceWGSL                 : constant T_WGPUSType := 2;
   C_SType_RenderPassMaxDrawCount           : constant T_WGPUSType := 3;
   C_SType_SurfaceSourceMetalLayer          : constant T_WGPUSType := 4;
   C_SType_SurfaceSourceWindowsHWND         : constant T_WGPUSType := 5;
   C_SType_SurfaceSourceXlibWindow          : constant T_WGPUSType := 6;
   C_SType_SurfaceSourceWaylandSurface      : constant T_WGPUSType := 7;
   C_SType_SurfaceSourceAndroidNativeWindow : constant T_WGPUSType := 8;
   C_SType_SurfaceSourceXCBWindow           : constant T_WGPUSType := 9;

	-- The callback mode controls how a callback for an asynchronous operation may be fired. See @ref Asynchronous-Operations
	-- for how these are used.
	C_CallbackMode_WaitAnyOnly        : constant T_WGPUCallbackMode := 1;
	C_CallbackMode_AllowProcessEvents : constant T_WGPUCallbackMode := 2;
	C_CallbackMode_AllowSpontaneous   : constant T_WGPUCallbackMode := 3;

	C_RequestAdapterStatus_Success         : constant T_WGPURequestAdapterStatus := 1;
	C_RequestAdapterStatus_InstanceDropped : constant T_WGPURequestAdapterStatus := 2;
	C_RequestAdapterStatus_Unavailable     : constant T_WGPURequestAdapterStatus := 3;
	C_RequestAdapterStatus_Error           : constant T_WGPURequestAdapterStatus := 4;
	C_RequestAdapterStatus_Unknown         : constant T_WGPURequestAdapterStatus := 5;



end WebGPU.Types;
