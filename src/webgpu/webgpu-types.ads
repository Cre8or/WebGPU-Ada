pragma License (Unrestricted);





package WebGPU.Types is



	-- Pragmas
	pragma Preelaborate;



	-- Types to be overriden by external packages (generics)
	subtype T_Positive is Positive;



	-- Types
	type T_Power_Preference is (
		E_Undefined, -- No preference
		E_Low_Power,
		E_High_Performance
	) with Convention => C, Size => 32;

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
	) with Convention => C, Size => 32;

	for T_Backend_Type use (
		E_Undefined => 0, -- No preference
		E_Null      => 1,
		E_WebGPU    => 2,
		E_D3D11     => 3,
		E_D3D12     => 4,
		E_Metal     => 5,
		E_Vulkan    => 6,
		E_OpenGL    => 7,
		E_OpenGLES  => 8
	);

	type T_Feature_Name is (
		E_Depth_Clip_Control,
		E_Depth32_Float_Stencil8,
		E_Timestamp_Query,
		E_Texture_Compression_BC,
		E_Texture_Compression_ETC2,
		E_Texture_Compression_ASTC,
		E_Indirect_First_Instance,
		E_Shader_F16,
		E_RG11B10_Ufloat_Renderable,
		E_BGRA8_Unorm_Storage,
		E_Float32_Filterable,
		E_Float32_Blendable,
		E_Subgroups,
		E_Subgroups_F16,
		E_Dawn_Internal_Usages,
		E_Dawn_Multi_Planar_Formats,
		E_Dawn_Native,
		E_Chromium_Experimental_Timestamp_Query_Inside_Passes,
		E_Implicit_Device_Synchronization,
		E_Chromium_Experimental_Immediate_Data,
		E_Transient_Attachments,
		E_MSAA_Render_To_Single_Sampled,
		E_Dual_Source_Blending,
		E_D3D11_Multithread_Protected,
		E_ANGLE_Texture_Sharing,
		E_Chromium_Experimental_Subgroups,
		E_Chromium_Experimental_Subgroup_Uniform_Control_Flow,
		E_Pixel_Local_Storage_Coherent,
		E_Pixel_Local_Storage_Non_Coherent,
		E_UNorm16_Texture_Formats,
		E_SNorm16_Texture_Formats,
		E_Multi_Planar_Format_Extended_Usages,
		E_Multi_Planar_Format_P010,
		E_Host_Mapped_Pointer,
		E_Multi_Planar_Render_Targets,
		E_Multi_Planar_Format_Nv12a,
		E_Framebuffer_Fetch,
		E_Buffer_Map_Extended_Usages,
		E_Adapter_Properties_Memory_Heaps,
		E_Adapter_Properties_D3D,
		E_Adapter_Properties_Vk,
		E_R8_Unorm_Storage,
		E_Format_Capabilities,
		E_Drm_Format_Capabilities,
		E_Norm16_Texture_Formats,
		E_Multi_Planar_Format_Nv16,
		E_Multi_Planar_Format_Nv24,
		E_Multi_Planar_FormatP210,
		E_Multi_Planar_FormatP410,
		E_Shared_Texture_Memory_Vk_Dedicated_Allocation,
		E_Shared_Texture_Memory_A_Hardware_Buffer,
		E_Shared_Texture_Memory_DMA_Buffer,
		E_Shared_Texture_Memory_Opaque_FD,
		E_Shared_Texture_Memory_Zircon_Handle,
		E_Shared_Texture_Memory_DXGI_Shared_Handle,
		E_Shared_Texture_Memory_D3D11_Texture2D,
		E_Shared_Texture_Memory_IO_Surface,
		E_Shared_Texture_Memory_EGL_Image,
		E_Shared_Fence_Vk_Semaphore_Opaque_FD,
		E_Shared_Fence_Sync_FD,
		E_Shared_Fence_Vk_Semaphore_Zircon_Handle,
		E_Shared_Fence_DXGI_Shared_Handle,
		E_Shared_Fence_MTL_Shared_Event,
		E_Shared_Buffer_Memory_D3D12_Resource,
		E_Static_Samplers,
		E_YCbCr_Vulkan_Samplers,
		E_Shader_Module_Compilation_Options,
		E_Dawn_Load_Resolve_Texture,
		E_Dawn_Partial_Load_Resolve_Texture,
		E_Multi_Draw_Indirect,
		E_Clip_Distances,
		E_Shared_Fence_Vk_Semaphore_Sync_FD
	) with Convention => C, Size => 32;

	for T_Feature_Name use (
		E_Depth_Clip_Control                                  => 16#00000001#,
		E_Depth32_Float_Stencil8                              => 16#00000002#,
		E_Timestamp_Query                                     => 16#00000003#,
		E_Texture_Compression_BC                              => 16#00000004#,
		E_Texture_Compression_ETC2                            => 16#00000005#,
		E_Texture_Compression_ASTC                            => 16#00000006#,
		E_Indirect_First_Instance                             => 16#00000007#,
		E_Shader_F16                                          => 16#00000008#,
		E_RG11B10_Ufloat_Renderable                           => 16#00000009#,
		E_BGRA8_Unorm_Storage                                 => 16#0000000A#,
		E_Float32_Filterable                                  => 16#0000000B#,
		E_Float32_Blendable                                   => 16#0000000C#,
		E_Subgroups                                           => 16#0000000D#,
		E_Subgroups_F16                                       => 16#0000000E#,
		E_Dawn_Internal_Usages                                => 16#00050000#,
		E_Dawn_Multi_Planar_Formats                           => 16#00050001#,
		E_Dawn_Native                                         => 16#00050002#,
		E_Chromium_Experimental_Timestamp_Query_Inside_Passes => 16#00050003#,
		E_Implicit_Device_Synchronization                     => 16#00050004#,
		E_Chromium_Experimental_Immediate_Data                => 16#00050005#,
		E_Transient_Attachments                               => 16#00050006#,
		E_MSAA_Render_To_Single_Sampled                       => 16#00050007#,
		E_Dual_Source_Blending                                => 16#00050008#,
		E_D3D11_Multithread_Protected                         => 16#00050009#,
		E_ANGLE_Texture_Sharing                               => 16#0005000A#,
		E_Chromium_Experimental_Subgroups                     => 16#0005000B#,
		E_Chromium_Experimental_Subgroup_Uniform_Control_Flow => 16#0005000C#,
		E_Pixel_Local_Storage_Coherent                        => 16#0005000D#,
		E_Pixel_Local_Storage_Non_Coherent                    => 16#0005000E#,
		E_UNorm16_Texture_Formats                             => 16#0005000F#,
		E_SNorm16_Texture_Formats                             => 16#00050010#,
		E_Multi_Planar_Format_Extended_Usages                 => 16#00050011#,
		E_Multi_Planar_Format_P010                            => 16#00050012#,
		E_Host_Mapped_Pointer                                 => 16#00050013#,
		E_Multi_Planar_Render_Targets                         => 16#00050014#,
		E_Multi_Planar_Format_Nv12a                           => 16#00050015#,
		E_Framebuffer_Fetch                                   => 16#00050016#,
		E_Buffer_Map_Extended_Usages                          => 16#00050017#,
		E_Adapter_Properties_Memory_Heaps                     => 16#00050018#,
		E_Adapter_Properties_D3D                              => 16#00050019#,
		E_Adapter_Properties_Vk                               => 16#0005001A#,
		E_R8_Unorm_Storage                                    => 16#0005001B#,
		E_Format_Capabilities                                 => 16#0005001C#,
		E_Drm_Format_Capabilities                             => 16#0005001D#,
		E_Norm16_Texture_Formats                              => 16#0005001E#,
		E_Multi_Planar_Format_Nv16                            => 16#0005001F#,
		E_Multi_Planar_Format_Nv24                            => 16#00050020#,
		E_Multi_Planar_FormatP210                             => 16#00050021#,
		E_Multi_Planar_FormatP410                             => 16#00050022#,
		E_Shared_Texture_Memory_Vk_Dedicated_Allocation       => 16#00050023#,
		E_Shared_Texture_Memory_A_Hardware_Buffer             => 16#00050024#,
		E_Shared_Texture_Memory_DMA_Buffer                    => 16#00050025#,
		E_Shared_Texture_Memory_Opaque_FD                     => 16#00050026#,
		E_Shared_Texture_Memory_Zircon_Handle                 => 16#00050027#,
		E_Shared_Texture_Memory_DXGI_Shared_Handle            => 16#00050028#,
		E_Shared_Texture_Memory_D3D11_Texture2D               => 16#00050029#,
		E_Shared_Texture_Memory_IO_Surface                    => 16#0005002A#,
		E_Shared_Texture_Memory_EGL_Image                     => 16#0005002B#,
		E_Shared_Fence_Vk_Semaphore_Opaque_FD                 => 16#0005002C#,
		E_Shared_Fence_Sync_FD                                => 16#0005002D#,
		E_Shared_Fence_Vk_Semaphore_Zircon_Handle             => 16#0005002E#,
		E_Shared_Fence_DXGI_Shared_Handle                     => 16#0005002F#,
		E_Shared_Fence_MTL_Shared_Event                       => 16#00050030#,
		E_Shared_Buffer_Memory_D3D12_Resource                 => 16#00050031#,
		E_Static_Samplers                                     => 16#00050032#,
		E_YCbCr_Vulkan_Samplers                               => 16#00050033#,
		E_Shader_Module_Compilation_Options                   => 16#00050034#,
		E_Dawn_Load_Resolve_Texture                           => 16#00050035#,
		E_Dawn_Partial_Load_Resolve_Texture                   => 16#00050036#,
		E_Multi_Draw_Indirect                                 => 16#00050037#,
		E_Clip_Distances                                      => 16#00050038#,
		E_Shared_Fence_Vk_Semaphore_Sync_FD                   => 16#00050039#
	);

	type T_Feature_Name_Arr is array (T_Positive range <>) of aliased T_Feature_Name;

	type T_Request_Adapter_Status is (
		E_Success,
		E_Instance_Dropped,
		E_Unavailable,
		E_Error,
		E_Unknown
	) with Convention => C, Size => 32;

	for T_Request_Adapter_Status use (
		E_Success          => 1,
		E_Instance_Dropped => 2,
		E_Unavailable      => 3,
		E_Error            => 4,
		E_Unknown          => 5
	);

	type T_Request_Device_Status is (
		E_Success,
		E_Instance_Dropped,
		E_Error,
		E_Unknown
	) with Convention => C, Size => 32;

	for T_Request_Device_Status use (
		E_Success          => 1,
		E_Instance_Dropped => 2,
		E_Error            => 3,
		E_Unknown          => 4
	);

	type T_Device_Lost_Reason is (
		E_Unknown,
		E_Destroyed,
		E_Instance_Dropped,
		E_Failed_Creation
	) with Convention => C, Size => 32;

	for T_Device_Lost_Reason use (
		E_Unknown          => 1,
		E_Destroyed        => 2,
		E_Instance_Dropped => 3,
		E_Failed_Creation  => 4
	);

	-- The callback mode controls how a callback for an asynchronous operation may be fired.
	-- See @ref Asynchronous-Operations for how these are used.
	type T_Callback_Mode is (
		E_Wait_Any_Only,
		E_Allow_Process_Events,
		E_Allow_Spontaneous
	) with Convention => C, Size => 32;

	for T_Callback_Mode use (
		E_Wait_Any_Only        => 1,
		E_Allow_Process_Events => 2,
		E_Allow_Spontaneous    => 3
	);

	type T_Error_Kind is (
		E_No_Error,
		E_Validation,
		E_Out_Of_Memory,
		E_Internal,
		E_Unknown,
		E_Device_Lost
	) with Convention => C, Size => 32;

	for T_Error_Kind use (
		E_No_Error      => 1,
		E_Validation    => 2,
		E_Out_Of_Memory => 3,
		E_Internal      => 4,
		E_Unknown       => 5,
		E_Device_Lost   => 6
	);



end WebGPU.Types;
