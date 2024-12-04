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

with Cre8or_WebGPU.Types;



pragma Elaborate_All (Interfaces.C.Strings);
pragma Elaborate_All (System);

pragma Elaborate_All (Cre8or_WebGPU.Types);





private package Cre8or_WebGPU.API is



	-- Use clauses
	use Cre8or_WebGPU.Types;



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

	type T_WGPUSType is (
		E_Default_Value,
		E_Shader_Source_SPIRV,
		E_Shader_Source_WGSL,
		E_Render_Pass_Max_Draw_Count,
		E_Surface_Source_Metal_Layer,
		E_Surface_Source_Windows_HWND,
		E_Surface_Source_Xlib_Window,
		E_Surface_Source_Wayland_Surface,
		E_Surface_Source_Android_Native_Window,
		E_Surface_Source_XCB_Window,
		E_Texture_Binding_View_Dimension_Descriptor,
		E_Surface_Source_Canvas_HTMLSelector_Emscripten,
		E_Surface_Descriptor_From_Windows_Core_Window,
		E_External_Texture_Binding_Entry,
		E_External_Texture_Binding_Layout,
		E_Surface_Descriptor_From_Windows_Swap_Chain_Panel,
		E_Dawn_Texture_Internal_Usage_Descriptor,
		E_Dawn_Encoder_Internal_Usage_Descriptor,
		E_Dawn_Instance_Descriptor,
		E_Dawn_Cache_Device_Descriptor,
		E_Dawn_Adapter_Properties_Power_Preference,
		E_Dawn_Buffer_Descriptor_Error_Info_From_Wire_Client,
		E_Dawn_Toggles_Descriptor,
		E_Dawn_Shader_Module_SPIRVOptions_Descriptor,
		E_Request_Adapter_Options_LUID,
		E_Request_Adapter_Options_Get_GLProc,
		E_Request_Adapter_Options_D3_D11_Device,
		E_Dawn_Render_Pass_Color_Attachment_Render_To_Single_Sampled,
		E_Render_Pass_Pixel_Local_Storage,
		E_Pipeline_Layout_Pixel_Local_Storage,
		E_Buffer_Host_Mapped_Pointer,
		E_Dawn_Experimental_Subgroup_Limits,
		E_Adapter_Properties_Memory_Heaps,
		E_Adapter_Properties_D3_D,
		E_Adapter_Properties_Vk,
		E_Dawn_Compute_Pipeline_Full_Subgroups,
		E_Dawn_Wire_WGSLControl,
		E_Dawn_WGSLBlocklist,
		E_Drm_Format_Capabilities,
		E_Shader_Module_Compilation_Options,
		E_Color_Target_State_Expand_Resolve_Texture_Dawn,
		E_Render_Pass_Descriptor_Expand_Resolve_Rect,
		E_Shared_Texture_Memory_Vk_Dedicated_Allocation_Descriptor,
		E_Shared_Texture_Memory_AHardware_Buffer_Descriptor,
		E_Shared_Texture_Memory_Dma_Buf_Descriptor,
		E_Shared_Texture_Memory_Opaque_FDDescriptor,
		E_Shared_Texture_Memory_Zircon_Handle_Descriptor,
		E_Shared_Texture_Memory_DXGIShared_Handle_Descriptor,
		E_Shared_Texture_Memory_D3_D11_Texture2_DDescriptor,
		E_Shared_Texture_Memory_IOSurface_Descriptor,
		E_Shared_Texture_Memory_EGLImage_Descriptor,
		E_Shared_Texture_Memory_Initialized_Begin_State,
		E_Shared_Texture_Memory_Initialized_End_State,
		E_Shared_Texture_Memory_Vk_Image_Layout_Begin_State,
		E_Shared_Texture_Memory_Vk_Image_Layout_End_State,
		E_Shared_Texture_Memory_D3_DSwapchain_Begin_State,
		E_Shared_Fence_Vk_Semaphore_Opaque_FDDescriptor,
		E_Shared_Fence_Vk_Semaphore_Opaque_FDExport_Info,
		E_Shared_Fence_Sync_FDDescriptor,
		E_Shared_Fence_Sync_FDExport_Info,
		E_Shared_Fence_Vk_Semaphore_Zircon_Handle_Descriptor,
		E_Shared_Fence_Vk_Semaphore_Zircon_Handle_Export_Info,
		E_Shared_Fence_DXGIShared_Handle_Descriptor,
		E_Shared_Fence_DXGIShared_Handle_Export_Info,
		E_Shared_Fence_MTLShared_Event_Descriptor,
		E_Shared_Fence_MTLShared_Event_Export_Info,
		E_Shared_Buffer_Memory_D3_D12_Resource_Descriptor,
		E_Static_Sampler_Binding_Layout,
		E_YCb_Cr_Vk_Descriptor,
		E_Shared_Texture_Memory_AHardware_Buffer_Properties,
		E_AHardware_Buffer_Properties,
		E_Dawn_Experimental_Immediate_Data_Limits
	) with Convention => C, Size => 32;

	for T_WGPUSType use (
		E_Default_Value                                              => 0,
		E_Shader_Source_SPIRV                                        => 16#00000001#,
		E_Shader_Source_WGSL                                         => 16#00000002#,
		E_Render_Pass_Max_Draw_Count                                 => 16#00000003#,
		E_Surface_Source_Metal_Layer                                 => 16#00000004#,
		E_Surface_Source_Windows_HWND                                => 16#00000005#,
		E_Surface_Source_Xlib_Window                                 => 16#00000006#,
		E_Surface_Source_Wayland_Surface                             => 16#00000007#,
		E_Surface_Source_Android_Native_Window                       => 16#00000008#,
		E_Surface_Source_XCB_Window                                  => 16#00000009#,
		E_Texture_Binding_View_Dimension_Descriptor                  => 16#00020000#,
		E_Surface_Source_Canvas_HTMLSelector_Emscripten              => 16#00040000#,
		E_Surface_Descriptor_From_Windows_Core_Window                => 16#00050000#,
		E_External_Texture_Binding_Entry                             => 16#00050001#,
		E_External_Texture_Binding_Layout                            => 16#00050002#,
		E_Surface_Descriptor_From_Windows_Swap_Chain_Panel           => 16#00050003#,
		E_Dawn_Texture_Internal_Usage_Descriptor                     => 16#00050004#,
		E_Dawn_Encoder_Internal_Usage_Descriptor                     => 16#00050005#,
		E_Dawn_Instance_Descriptor                                   => 16#00050006#,
		E_Dawn_Cache_Device_Descriptor                               => 16#00050007#,
		E_Dawn_Adapter_Properties_Power_Preference                   => 16#00050008#,
		E_Dawn_Buffer_Descriptor_Error_Info_From_Wire_Client         => 16#00050009#,
		E_Dawn_Toggles_Descriptor                                    => 16#0005000A#,
		E_Dawn_Shader_Module_SPIRVOptions_Descriptor                 => 16#0005000B#,
		E_Request_Adapter_Options_LUID                               => 16#0005000C#,
		E_Request_Adapter_Options_Get_GLProc                         => 16#0005000D#,
		E_Request_Adapter_Options_D3_D11_Device                      => 16#0005000E#,
		E_Dawn_Render_Pass_Color_Attachment_Render_To_Single_Sampled => 16#0005000F#,
		E_Render_Pass_Pixel_Local_Storage                            => 16#00050010#,
		E_Pipeline_Layout_Pixel_Local_Storage                        => 16#00050011#,
		E_Buffer_Host_Mapped_Pointer                                 => 16#00050012#,
		E_Dawn_Experimental_Subgroup_Limits                          => 16#00050013#,
		E_Adapter_Properties_Memory_Heaps                            => 16#00050014#,
		E_Adapter_Properties_D3_D                                    => 16#00050015#,
		E_Adapter_Properties_Vk                                      => 16#00050016#,
		E_Dawn_Compute_Pipeline_Full_Subgroups                       => 16#00050017#,
		E_Dawn_Wire_WGSLControl                                      => 16#00050018#,
		E_Dawn_WGSLBlocklist                                         => 16#00050019#,
		E_Drm_Format_Capabilities                                    => 16#0005001A#,
		E_Shader_Module_Compilation_Options                          => 16#0005001B#,
		E_Color_Target_State_Expand_Resolve_Texture_Dawn             => 16#0005001C#,
		E_Render_Pass_Descriptor_Expand_Resolve_Rect                 => 16#0005001D#,
		E_Shared_Texture_Memory_Vk_Dedicated_Allocation_Descriptor   => 16#0005001E#,
		E_Shared_Texture_Memory_AHardware_Buffer_Descriptor          => 16#0005001F#,
		E_Shared_Texture_Memory_Dma_Buf_Descriptor                   => 16#00050020#,
		E_Shared_Texture_Memory_Opaque_FDDescriptor                  => 16#00050021#,
		E_Shared_Texture_Memory_Zircon_Handle_Descriptor             => 16#00050022#,
		E_Shared_Texture_Memory_DXGIShared_Handle_Descriptor         => 16#00050023#,
		E_Shared_Texture_Memory_D3_D11_Texture2_DDescriptor          => 16#00050024#,
		E_Shared_Texture_Memory_IOSurface_Descriptor                 => 16#00050025#,
		E_Shared_Texture_Memory_EGLImage_Descriptor                  => 16#00050026#,
		E_Shared_Texture_Memory_Initialized_Begin_State              => 16#00050027#,
		E_Shared_Texture_Memory_Initialized_End_State                => 16#00050028#,
		E_Shared_Texture_Memory_Vk_Image_Layout_Begin_State          => 16#00050029#,
		E_Shared_Texture_Memory_Vk_Image_Layout_End_State            => 16#0005002A#,
		E_Shared_Texture_Memory_D3_DSwapchain_Begin_State            => 16#0005002B#,
		E_Shared_Fence_Vk_Semaphore_Opaque_FDDescriptor              => 16#0005002C#,
		E_Shared_Fence_Vk_Semaphore_Opaque_FDExport_Info             => 16#0005002D#,
		E_Shared_Fence_Sync_FDDescriptor                             => 16#0005002E#,
		E_Shared_Fence_Sync_FDExport_Info                            => 16#0005002F#,
		E_Shared_Fence_Vk_Semaphore_Zircon_Handle_Descriptor         => 16#00050030#,
		E_Shared_Fence_Vk_Semaphore_Zircon_Handle_Export_Info        => 16#00050031#,
		E_Shared_Fence_DXGIShared_Handle_Descriptor                  => 16#00050032#,
		E_Shared_Fence_DXGIShared_Handle_Export_Info                 => 16#00050033#,
		E_Shared_Fence_MTLShared_Event_Descriptor                    => 16#00050034#,
		E_Shared_Fence_MTLShared_Event_Export_Info                   => 16#00050035#,
		E_Shared_Buffer_Memory_D3_D12_Resource_Descriptor            => 16#00050036#,
		E_Static_Sampler_Binding_Layout                              => 16#00050037#,
		E_YCb_Cr_Vk_Descriptor                                       => 16#00050038#,
		E_Shared_Texture_Memory_AHardware_Buffer_Properties          => 16#00050039#,
		E_AHardware_Buffer_Properties                                => 16#0005003A#,
		E_Dawn_Experimental_Immediate_Data_Limits                    => 16#0005003B#
	);



	-- Constants
	C_Null_Address : constant T_Address := System.Null_Address;



	-- Base Structs
	type T_WGPUChainedStruct;
	type T_WGPUChainedStruct is record
		next  : access constant T_WGPUChainedStruct;
		sType : aliased T_WGPUSType := E_Default_Value;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUChainedStructOut;
	type T_WGPUChainedStructOut is record
		next  : access T_WGPUChainedStructOut;
		sType : aliased T_WGPUSType := E_Default_Value;
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

	-- Surface descriptors, one set for each windowing system
	-- AppKit (Cocoa)
	type T_WGPUSurfaceSourceMetalLayer is record
		chain : aliased T_WGPUChainedStruct;
		layer : T_Address;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUSurfaceDescriptor_AppKit is record
		nextInChain : access constant T_WGPUSurfaceSourceMetalLayer;
		label       : aliased T_WGPUStringView;
	end record
	with Convention => C_Pass_By_Copy;

	-- Windows (Win32)
	type T_WGPUSurfaceSourceWindowsHWND is record
		chain     : aliased T_WGPUChainedStruct;
		hinstance : T_Address;
		hwnd      : T_Address;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUSurfaceDescriptor_Windows is record
		nextInChain : access constant T_WGPUSurfaceSourceWindowsHWND;
		label       : aliased T_WGPUStringView;
	end record
	with Convention => C_Pass_By_Copy;

	-- Xlib (X11)
	type T_WGPUSurfaceSourceXlibWindow is record
		chain   : aliased T_WGPUChainedStruct;
		display : T_Address;
		window  : aliased T_UInt64;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUSurfaceDescriptor_Xlib is record
		nextInChain : access constant T_WGPUSurfaceSourceXlibWindow;
		label       : aliased T_WGPUStringView;
	end record
	with Convention => C_Pass_By_Copy;

	-- Xcb
	type T_WGPUSurfaceSourceXCBWindow is record
		chain      : aliased T_WGPUChainedStruct;
		connection : T_Address;
		window     : aliased T_UInt32;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUSurfaceDescriptor_Xcb is record
		nextInChain : access constant T_WGPUSurfaceSourceXCBWindow;
		label       : aliased T_WGPUStringView;
	end record
	with Convention => C_Pass_By_Copy;

	-- Wayland
	type T_WGPUSurfaceSourceWaylandSurface is record
		chain   : aliased T_WGPUChainedStruct;
		display : T_Address;
		surface : T_Address;
	end record
	with Convention => C_Pass_By_Copy;

	type T_WGPUSurfaceDescriptor_Wayland is record
		nextInChain : access constant T_WGPUSurfaceSourceWaylandSurface;
		label       : aliased T_WGPUStringView;
	end record
	with Convention => C_Pass_By_Copy;



	-- Renames
	function To_C (
		Item       : in String;
		Append_Nul : in Boolean := True
	) return T_Char_Array renames Interfaces.C.To_C;

	---------------------------------------------------------------------------------------------------------------------
	function To_Chars_Ptr (
		Item      : in T_Char_Array_Ref;
		Nul_Check : in Boolean := false
	) return T_Chars_Ptr renames Interfaces.C.Strings.To_Chars_Ptr;



	-- Imports
	---------------------------------------------------------------------------------------------------------------------
	-- Instances
	---------------------------------------------------------------------------------------------------------------------
   	procedure wgpuInstanceRequestAdapter (
		instance : in T_WGPUInstance;
		options  : access constant T_WGPURequestAdapterOptions;
		callback : in T_WGPURequestAdapterCallback;
		userdata : in T_Address := C_Null_Address
	) with Import, Convention => C, External_Name => "wgpuInstanceRequestAdapter";

	---------------------------------------------------------------------------------------------------------------------
	function wgpuCreateInstance (descriptor : in T_Address := C_Null_Address) return T_WGPUInstance
	with Import, Convention => C, External_Name => "wgpuCreateInstance";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuInstanceAddRef (instance : in T_WGPUInstance)
	with Import, Convention => C, External_Name => "wgpuInstanceAddRef"; -- wgpuInstanceReference

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuInstanceRelease (instance : in T_WGPUInstance)
	with Import, Convention => C, External_Name => "wgpuInstanceRelease";

	---------------------------------------------------------------------------------------------------------------------
	-- Adapters
	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterRequestDevice (
		adapter    : in T_WGPUAdapter;
		descriptor : access constant T_WGPUDeviceDescriptor;
		callback   : in T_WGPURequestDeviceCallback;
		userdata   : in T_Address := C_Null_Address
	) with Import, Convention => C, External_Name => "wgpuAdapterRequestDevice";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterAddRef (adapter : in T_WGPUAdapter)
	with Import, Convention => C, External_Name => "wgpuAdapterAddRef";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuAdapterRelease (adapter : in T_WGPUAdapter)
	with Import, Convention => C, External_Name => "wgpuAdapterRelease";

	---------------------------------------------------------------------------------------------------------------------
	-- Devices
	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuDeviceAddRef (device : in T_WGPUDevice)
	with Import, Convention => C, External_Name => "wgpuDeviceAddRef";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuDeviceRelease (device : in T_WGPUDevice)
	with Import, Convention => C, External_Name => "wgpuDeviceRelease";

	---------------------------------------------------------------------------------------------------------------------
   function wgpuDeviceEnumerateFeatures (
		device   : in T_WGPUDevice;
		features : access T_Feature_Name
	) return T_Size
	with Import, Convention => C, External_Name => "wgpuDeviceEnumerateFeatures";

	---------------------------------------------------------------------------------------------------------------------
   function wgpuDeviceGetLimits (
		device : in T_WGPUDevice;
		limits : access T_WGPUSupportedLimits
	) return T_Status
	with Import, Convention => C, External_Name => "wgpuDeviceGetLimits";

	---------------------------------------------------------------------------------------------------------------------
   function wgpuDeviceGetQueue (device : in T_WGPUDevice) return T_WGPUQueue
	with Import, Convention => C, External_Name => "wgpuDeviceGetQueue";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuDeviceTick (device : in T_WGPUDevice)
	with Import, Convention => C, External_Name => "wgpuDeviceTick";

	---------------------------------------------------------------------------------------------------------------------
	-- Queues
	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuQueueAddRef (queue : in T_WGPUQueue)
	with Import, Convention => C, External_Name => "wgpuQueueAddRef";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuQueueRelease (queue : in T_WGPUQueue)
	with Import, Convention => C, External_Name => "wgpuQueueRelease";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuQueueSubmit (
		queue        : in T_WGPUQueue;
		commandCount : in T_Size;
		commands     : in T_Address
	) with Import, Convention => C, External_Name => "wgpuQueueSubmit";

	---------------------------------------------------------------------------------------------------------------------
	-- Command buffers
	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandBufferAddRef (commandBuffer : in T_WGPUCommandBuffer)
	with Import, Convention => C, External_Name => "wgpuCommandBufferAddRef";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandBufferRelease (commandBuffer : in T_WGPUCommandBuffer)
	with Import, Convention => C, External_Name => "wgpuCommandBufferRelease";

	---------------------------------------------------------------------------------------------------------------------
	-- Command encoders
	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandEncoderAddRef (commandEncoder : in T_WGPUCommandEncoder)
	with Import, Convention => C, External_Name => "wgpuCommandEncoderAddRef";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandEncoderRelease (commandEncoder : in T_WGPUCommandEncoder)
	with Import, Convention => C, External_Name => "wgpuCommandEncoderRelease";

	---------------------------------------------------------------------------------------------------------------------
	function wgpuDeviceCreateCommandEncoder (
		device     : in T_WGPUDevice;
		descriptor : access constant T_WGPUCommandEncoderDescriptor
	) return T_WGPUCommandEncoder
	with Import, Convention => C, External_Name => "wgpuDeviceCreateCommandEncoder";

	---------------------------------------------------------------------------------------------------------------------
	function wgpuCommandEncoderFinish (
		commandEncoder : in T_WGPUCommandEncoder;
		descriptor     : access constant T_WGPUCommandBufferDescriptor
	) return T_WGPUCommandBuffer
	with Import, Convention => C, External_Name => "wgpuCommandEncoderFinish";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuCommandEncoderInsertDebugMarker (
		commandEncoder : in T_WGPUCommandEncoder;
		markerLabel    : in T_WGPUStringView
	) with Import, Convention => C, External_Name => "wgpuCommandEncoderInsertDebugMarker";

	---------------------------------------------------------------------------------------------------------------------
	-- Surfaces
	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuSurfaceAddRef (surface : in T_WGPUSurface)
	with Import, Convention => C, External_Name => "wgpuSurfaceAddRef";

	---------------------------------------------------------------------------------------------------------------------
	procedure wgpuSurfaceRelease (surface : in T_WGPUSurface)
	with Import, Convention => C, External_Name => "wgpuSurfaceRelease";

	---------------------------------------------------------------------------------------------------------------------
	function wgpuInstanceCreateSurface_AppKit (
		instance   : in T_WGPUInstance;
		descriptor : access constant T_WGPUSurfaceDescriptor_AppKit
	) return T_WGPUSurface
	with Import, Convention => C, External_Name => "wgpuInstanceCreateSurface";

	---------------------------------------------------------------------------------------------------------------------
	function wgpuInstanceCreateSurface_Windows (
		instance   : in T_WGPUInstance;
		descriptor : access constant T_WGPUSurfaceDescriptor_Windows
	) return T_WGPUSurface
	with Import, Convention => C, External_Name => "wgpuInstanceCreateSurface";

	---------------------------------------------------------------------------------------------------------------------
	function wgpuInstanceCreateSurface_Xlib (
		instance   : in T_WGPUInstance;
		descriptor : access constant T_WGPUSurfaceDescriptor_Xlib
	) return T_WGPUSurface
	with Import, Convention => C, External_Name => "wgpuInstanceCreateSurface";

	---------------------------------------------------------------------------------------------------------------------
	function wgpuInstanceCreateSurface_Xcb (
		instance   : in T_WGPUInstance;
		descriptor : access constant T_WGPUSurfaceDescriptor_Xcb
	) return T_WGPUSurface
	with Import, Convention => C, External_Name => "wgpuInstanceCreateSurface";

	---------------------------------------------------------------------------------------------------------------------
	function wgpuInstanceCreateSurface_Wayland (
		instance   : in T_WGPUInstance;
		descriptor : access constant T_WGPUSurfaceDescriptor_Wayland
	) return T_WGPUSurface
	with Import, Convention => C, External_Name => "wgpuInstanceCreateSurface";



end Cre8or_WebGPU.API;
