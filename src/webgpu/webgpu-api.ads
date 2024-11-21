------------------------------------------------------------------------------------------------------------------------
--  Copyright 2024 Cre8or                                                                                             --
--                                                                                                                    --
--  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance    --
--  with the License. You may obtain a copy of the License at                                                         --
--                                                                                                                    --
--     http://www.apache.org/licenses/LICENSE-2.0                                                                     --
--                                                                                                                    --
--  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed  --
--  on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                     --
--  See the License for the specific language governing permissions and limitations under the License.                --
------------------------------------------------------------------------------------------------------------------------





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

	type T_Size       is new Interfaces.C.size_t;
	subtype T_Address is System.Address;

	subtype T_Char_Array     is Interfaces.C.char_array;
	subtype T_Chars_Ptr      is Interfaces.C.Strings.chars_ptr;
	subtype T_Char_Array_Ref is Interfaces.C.Strings.char_array_access;

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

	type T_WGPUCommandBufferDescriptor is record
		nextInChain : access constant T_WGPUChainedStruct;
		label       : aliased T_WGPUStringView;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUCommandEncoderDescriptor is record
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




	-- Renames
	function To_C (
		Item       : in String;
		Append_Nul : in Boolean := True
	) return T_Char_Array renames Interfaces.C.To_C;

	--------------------------------------------------------------------------------------------------------------------------------
	function To_Chars_Ptr (
		Item      : in T_Char_Array_Ref;
		Nul_Check : in Boolean := false
	) return T_Chars_Ptr renames Interfaces.C.Strings.To_Chars_Ptr;



	-- Imports
	--------------------------------------------------------------------------------------------------------------------------------
	-- Instances
	--------------------------------------------------------------------------------------------------------------------------------
   	procedure wgpuInstanceRequestAdapter (
		instance : in T_WGPUInstance;
		options  : access constant T_WGPURequestAdapterOptions;
		callback : in T_WGPURequestAdapterCallback;
		userdata : in T_Address := C_Null_Address
	) with Import, Convention => C, External_Name => "wgpuInstanceRequestAdapter";

	--------------------------------------------------------------------------------------------------------------------------------
	function wgpuCreateInstance (descriptor : in T_Address := C_Null_Address) return T_WGPUInstance
	with Import, Convention => C, External_Name => "wgpuCreateInstance";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuInstanceAddRef (instance : in T_WGPUInstance)
	with Import, Convention => C, External_Name => "wgpuInstanceAddRef"; -- wgpuInstanceReference

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuInstanceRelease (instance : in T_WGPUInstance)
	with Import, Convention => C, External_Name => "wgpuInstanceRelease";

	--------------------------------------------------------------------------------------------------------------------------------
	-- Adapters
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

	--------------------------------------------------------------------------------------------------------------------------------
	-- Devices
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

	--------------------------------------------------------------------------------------------------------------------------------
   function wgpuDeviceGetQueue (device : in T_WGPUDevice) return T_WGPUQueue
	with Import, Convention => C, External_Name => "wgpuDeviceGetQueue";

	--------------------------------------------------------------------------------------------------------------------------------
	-- Queues
	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuQueueAddRef (queue : in T_WGPUQueue)
	with Import, Convention => C, External_Name => "wgpuQueueAddRef";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuQueueRelease (queue : in T_WGPUQueue)
	with Import, Convention => C, External_Name => "wgpuQueueRelease";

	--------------------------------------------------------------------------------------------------------------------------------
	-- Command buffers
	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandBufferAddRef (commandBuffer : in T_WGPUCommandBuffer)
	with Import, Convention => C, External_Name => "wgpuCommandBufferAddRef";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandBufferRelease (commandBuffer : in T_WGPUCommandBuffer)
	with Import, Convention => C, External_Name => "wgpuCommandBufferRelease";

	--------------------------------------------------------------------------------------------------------------------------------
	-- Command encoders
	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandEncoderAddRef (commandEncoder : in T_WGPUCommandEncoder)
	with Import, Convention => C, External_Name => "wgpuCommandEncoderAddRef";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandEncoderRelease (commandEncoder : in T_WGPUCommandEncoder)
	with Import, Convention => C, External_Name => "wgpuCommandEncoderRelease";

	--------------------------------------------------------------------------------------------------------------------------------
	function wgpuDeviceCreateCommandEncoder (
		device     : in T_WGPUDevice;
		descriptor : access constant T_WGPUCommandEncoderDescriptor
	) return T_WGPUCommandEncoder
	with Import, Convention => C, External_Name => "wgpuDeviceCreateCommandEncoder";

	--------------------------------------------------------------------------------------------------------------------------------
	function wgpuCommandEncoderFinish (
		commandEncoder : in T_WGPUCommandEncoder;
		descriptor     : access constant T_WGPUCommandBufferDescriptor
	) return T_WGPUCommandBuffer
	with Import, Convention => C, External_Name => "wgpuCommandEncoderFinish";

	--------------------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandEncoderInsertDebugMarker (
		commandEncoder : in T_WGPUCommandEncoder;
		markerLabel    : in T_WGPUStringView
	) with Import, Convention => C, External_Name => "wgpuCommandEncoderInsertDebugMarker";



end WebGPU.API;
