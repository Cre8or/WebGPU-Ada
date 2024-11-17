pragma License (Unrestricted);





with Interfaces.C.Strings;
with System;

with WebGPU.Types;



pragma Elaborate_All (Interfaces.C.Strings);
pragma Elaborate_All (System);

pragma Elaborate_All (WebGPU.Types);





private package WebGPU.API is



	-- Use clauses
	use WebGPU.Types;



	-- Basic types
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

	type T_Size         is new Interfaces.C.size_t;
	subtype T_Chars_Ptr is Interfaces.C.Strings.chars_ptr;
	subtype T_Address   is System.Address;

	type T_WGPUBool is new Boolean
	with Convention => C, Size => 32;

	type T_WGPUSType is new T_UInt; -- TODO: Convert into an enum?



	-- Constants
	C_Null_Address : constant T_Address := System.Null_Address;



	-- Base Structs
	type T_WGPUChainedStruct;
	type T_WGPUChainedStruct is record
		next  : access constant T_WGPUChainedStruct;
		sType : aliased T_WGPUSType := 0;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUChainedStructOut;
	type T_WGPUChainedStructOut is record
		next  : access T_WGPUChainedStructOut;
		sType : aliased T_WGPUSType := 0;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUStringView is record
		data   : T_Chars_Ptr;
		length : aliased T_Size := 0;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUQueueDescriptor is record
		nextInChain : access constant T_WGPUChainedStruct;
		label       : aliased T_WGPUStringView;
	end record
	with Convention => C_Pass_By_Copy;



	-- Callback accessors
	type T_WGPURequestAdapterCallback is access procedure (
		status   : in T_Request_Adapter_Status;
		adapter  : in T_WGPUAdapter;
		message  : in T_WGPUStringView;
		userdata : in T_Address := C_Null_Address
	) with Convention => C;

	type T_WGPURequestDeviceCallback is access procedure (
		status   : in T_Request_Device_Status;
		device   : in T_WGPUDevice;
		message  : in T_WGPUStringView;
		userdata : in T_Address := C_Null_Address
	) with Convention => C;

   	type T_WGPUDeviceLostCallback is access procedure (
		device   : in T_WGPUDevice;
		reason   : in T_Device_Lost_Reason;
		message  : in T_WGPUStringView;
		userdata : in T_Device_Lost_Callback
   	) with Convention => C;

   	type T_WGPUDeviceLostCallback2 is access procedure (
		device    : in T_WGPUDevice;
		reason    : in T_Device_Lost_Reason;
		message   : in T_WGPUStringView;
		userdata1 : in T_Address := C_Null_Address;
		userdata2 : in T_Address := C_Null_Address
   	) with Convention => C;

	type T_WGPUErrorCallback is access procedure (
		kind     : in T_Error_Kind;
		message  : in T_WGPUStringView;
		userdata : in T_Address := C_Null_Address
	) with Convention => C;

	type T_WGPUUncapturedErrorCallback is access procedure (
		device    : in T_WGPUDevice;
		kind      : in T_Error_Kind;
		message   : in T_WGPUStringView;
		userdata1 : in T_Address := C_Null_Address;
		userdata2 : in T_Address := C_Null_Address
	) with Convention => C;



	-- Request structs
	type T_WGPUDeviceLostCallbackInfo is record
		nextInChain : access constant T_WGPUChainedStruct;
		mode        : aliased T_Callback_Mode := E_Wait_Any_Only;
		callback    : T_WGPUDeviceLostCallback;
		userdata    : T_Device_Lost_Callback;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUDeviceLostCallbackInfo2 is record
		nextInChain : access constant T_WGPUChainedStruct;
		mode        : aliased T_Callback_Mode := E_Wait_Any_Only;
		callback    : T_WGPUDeviceLostCallback2;
		userdata1   : T_Address := C_Null_Address;
		userdata2   : T_Address := C_Null_Address;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUUncapturedErrorCallbackInfo is record
		nextInChain : access constant T_WGPUChainedStruct;
		callback    : T_WGPUErrorCallback;
		userdata    : T_Address := C_Null_Address;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUUncapturedErrorCallbackInfo2 is record
		nextInChain : access constant T_WGPUChainedStruct;
		callback    : T_WGPUUncapturedErrorCallback;
		userdata1   : T_Address := C_Null_Address;
		userdata2   : T_Address := C_Null_Address;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPURequestAdapterOptions is record
		nextInChain          : access constant T_WGPUChainedStruct;
		compatibleSurface    : T_WGPUSurface;
		powerPreference      : aliased T_Power_Preference := E_Undefined;
		backendType          : aliased T_Backend_Type     := E_Undefined;
		forceFallbackAdapter : aliased T_WGPUBool         := false;
		compatibilityMode    : aliased T_WGPUBool         := false;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPURequiredLimits is record
		nextInChain : access constant T_WGPUChainedStruct;
		limits      : aliased T_Device_Limits;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUSupportedLimits is record
		nextInChain : access T_WGPUChainedStructOut;
		limits      : aliased T_Device_Limits;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUDeviceDescriptor is record
		nextInChain                  : access constant T_WGPUChainedStruct;
		label                        : aliased T_WGPUStringView;
		requiredFeatureCount         : aliased T_Size;
		requiredFeatures             : access T_Feature_Name;
		requiredLimits               : access constant T_WGPURequiredLimits;
		defaultQueue                 : aliased T_WGPUQueueDescriptor;
		deviceLostCallback           : T_Address := C_Null_Address; -- DEPRECATED (see Device.cpp) - use deviceLostCallbackInfo instead
		deviceLostUserdata           : T_Address := C_Null_Address; -- DEPRECATED (see Device.cpp) - use deviceLostCallbackInfo instead
		deviceLostCallbackInfo       : aliased T_WGPUDeviceLostCallbackInfo;
		uncapturedErrorCallbackInfo  : aliased T_WGPUUncapturedErrorCallbackInfo;
		deviceLostCallbackInfo2      : aliased T_WGPUDeviceLostCallbackInfo2; -- Use this when passing 2 userdata pointers
		uncapturedErrorCallbackInfo2 : aliased T_WGPUUncapturedErrorCallbackInfo2; -- Use this when passing 2 userdata pointers
	end record
	with Convention => C_Pass_By_Copy;



end WebGPU.API;
