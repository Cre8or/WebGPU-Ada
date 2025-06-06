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





package Cre8or_WebGPU.Types is



	-- Pragmas
	pragma Preelaborate;



	-- Types to be overriden by external packages (generics)
	subtype T_Natural is Natural;
	subtype T_Positive is T_Natural range 1 .. T_Natural'Last_Valid;



	-- API base types
	type T_UInt32 is mod 2**32
	with Convention => C;

	type T_UInt64 is mod 2**64
	with Convention => C;



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

	type T_Feature_Level is (
		E_Undefined,
		E_Compatibility,
		E_Core
	) with Convention => C, Size => 32;

	for T_Feature_Level use (
		E_Undefined     => 0,
		E_Compatibility => 1,
		E_Core          => 2
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
		E_Callback_Cancelled,
		E_Unavailable,
		E_Error
	) with Convention => C, Size => 32;

	for T_Request_Adapter_Status use (
		E_Success            => 1,
		E_Callback_Cancelled => 2,
		E_Unavailable        => 3,
		E_Error              => 4
	);

	type T_Request_Device_Status is (
		E_Success,
		E_Callback_Cancelled,
		E_Error
	) with Convention => C, Size => 32;

	for T_Request_Device_Status use (
		E_Success            => 1,
		E_Callback_Cancelled => 2,
		E_Error              => 3
	);

	type T_Device_Lost_Reason is (
		E_Unknown,
		E_Destroyed,
		E_Callback_Cancelled,
		E_Failed_Creation
	) with Convention => C, Size => 32;

	for T_Device_Lost_Reason use (
		E_Unknown            => 1,
		E_Destroyed          => 2,
		E_Callback_Cancelled => 3,
		E_Failed_Creation    => 4
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

	type T_Status is (
		E_Success,
		E_Error
	) with Convention => C, Size => 32;

	for T_Status use (
		E_Success => 1,
		E_Error   => 2
	);

	type T_Present_Mode is (
		E_Fifo, -- VSync?
		E_Fifo_Relaxed,
		E_Immediate,
		E_Mailbox
	) with Convention => C, Size => 32;

	for T_Present_Mode use (
		E_Fifo         => 1,
		E_Fifo_Relaxed => 2,
		E_Immediate    => 3,
		E_Mailbox      => 4
	);

	type T_Present_Mode_Arr is array (T_Positive range <>) of aliased T_Present_Mode;

	type T_Texture_Usage is new T_UInt64;

	type T_Texture_Format is (
		E_Undefined,
		E_R8_Unorm,
		E_R8_Snorm,
		E_R8_Uint,
		E_R8_Sint,
		E_R16_Uint,
		E_R16_Sint,
		E_R16_Float,
		E_RG8_Unorm,
		E_RG8_Snorm,
		E_RG8_Uint,
		E_RG8_Sint,
		E_R32_Float,
		E_R32_Uint,
		E_R32_Sint,
		E_RG16_Uint,
		E_RG16_Sint,
		E_RG16_Float,
		E_RGBA8_Unorm,
		E_RGBA8_Unorm_Srgb,
		E_RGBA8_Snorm,
		E_RGBA8_Uint,
		E_RGBA8_Sint,
		E_BGRA8_Unorm,
		E_BGRA8_Unorm_Srgb,
		E_RGB10A2_Uint,
		E_RGB10A2_Unorm,
		E_RG11B10_Ufloat,
		E_RGB9E5_Ufloat,
		E_RG32_Float,
		E_RG32_Uint,
		E_RG32_Sint,
		E_RGBA16_Uint,
		E_RGBA16_Sint,
		E_RGBA16_Float,
		E_RGBA32_Float,
		E_RGBA32_Uint,
		E_RGBA32_Sint,
		E_Stencil_8,
		E_Depth16_Unorm,
		E_Depth24_Plus,
		E_Depth24_Plus_Stencil_8,
		E_Depth32_Float,
		E_Depth32_Float_Stencil_8,
		E_BC1RGBA_Unorm,
		E_BC1RGBA_Unorm_Srgb,
		E_BC2RGBA_Unorm,
		E_BC2RGBA_Unorm_Srgb,
		E_BC3RGBA_Unorm,
		E_BC3RGBA_Unorm_Srgb,
		E_BC4R_Unorm,
		E_BC4R_Snorm,
		E_BC5RG_Unorm,
		E_BC5RG_Snorm,
		E_BC6HRGB_Ufloat,
		E_BC6HRGB_Float,
		E_BC7RGBA_Unorm,
		E_BC7RGBA_Unorm_Srgb,
		E_ETC2RGB8_Unorm,
		E_ETC2RGB8_Unorm_Srgb,
		E_ETC2RGB8A1_Unorm,
		E_ETC2RGB8A1_Unorm_Srgb,
		E_ETC2RGBA8_Unorm,
		E_ETC2RGBA8_Unorm_Srgb,
		E_EACR11_Unorm,
		E_EACR11_Snorm,
		E_EACRG11_Unorm,
		E_EACRG11_Snorm,
		E_ASTC4x4_Unorm,
		E_ASTC4x4_Unorm_Srgb,
		E_ASTC5x4_Unorm,
		E_ASTC5x4_Unorm_Srgb,
		E_ASTC5x5_Unorm,
		E_ASTC5x5_Unorm_Srgb,
		E_ASTC6x5_Unorm,
		E_ASTC6x5_Unorm_Srgb,
		E_ASTC6x6_Unorm,
		E_ASTC6x6_Unorm_Srgb,
		E_ASTC8x5_Unorm,
		E_ASTC8x5_Unorm_Srgb,
		E_ASTC8x6_Unorm,
		E_ASTC8x6_Unorm_Srgb,
		E_ASTC8x8_Unorm,
		E_ASTC8x8_Unorm_Srgb,
		E_ASTC10x5_Unorm,
		E_ASTC10x5_Unorm_Srgb,
		E_ASTC10x6_Unorm,
		E_ASTC10x6_Unorm_Srgb,
		E_ASTC10x8_Unorm,
		E_ASTC10x8_Unorm_Srgb,
		E_ASTC10x10_Unorm,
		E_ASTC10x10_Unorm_Srgb,
		E_ASTC12x10_Unorm,
		E_ASTC12x10_Unorm_Srgb,
		E_ASTC12x12_Unorm,
		E_ASTC12x12_Unorm_Srgb,
		E_R16_Unorm,
		E_RG16_Unorm,
		E_RGBA16_Unorm,
		E_R16_Snorm,
		E_RG16_Snorm,
		E_RGBA16_Snorm,
		E_R8BG8_Biplanar_420_Unorm,
		E_R10X6BG10X6_Biplanar_420_Unorm,
		E_R8BG8A8_Triplanar_420_Unorm,
		E_R8BG8_Biplanar_422_Unorm,
		E_R8BG8_Biplanar_444_Unorm,
		E_R10X6BG10X6_Biplanar_422_Unorm,
		E_R10X6BG10X6_Biplanar_444_Unorm,
		E_External
	) with Convention => C, Size => 32;

	for T_Texture_Format use (
		E_Undefined                      => 0,
		E_R8_Unorm                       => 1,
		E_R8_Snorm                       => 2,
		E_R8_Uint                        => 3,
		E_R8_Sint                        => 4,
		E_R16_Uint                       => 5,
		E_R16_Sint                       => 6,
		E_R16_Float                      => 7,
		E_RG8_Unorm                      => 8,
		E_RG8_Snorm                      => 9,
		E_RG8_Uint                       => 10,
		E_RG8_Sint                       => 11,
		E_R32_Float                      => 12,
		E_R32_Uint                       => 13,
		E_R32_Sint                       => 14,
		E_RG16_Uint                      => 15,
		E_RG16_Sint                      => 16,
		E_RG16_Float                     => 17,
		E_RGBA8_Unorm                    => 18,
		E_RGBA8_Unorm_Srgb               => 19,
		E_RGBA8_Snorm                    => 20,
		E_RGBA8_Uint                     => 21,
		E_RGBA8_Sint                     => 22,
		E_BGRA8_Unorm                    => 23,
		E_BGRA8_Unorm_Srgb               => 24,
		E_RGB10A2_Uint                   => 25,
		E_RGB10A2_Unorm                  => 26,
		E_RG11B10_Ufloat                 => 27,
		E_RGB9E5_Ufloat                  => 28,
		E_RG32_Float                     => 29,
		E_RG32_Uint                      => 30,
		E_RG32_Sint                      => 31,
		E_RGBA16_Uint                    => 32,
		E_RGBA16_Sint                    => 33,
		E_RGBA16_Float                   => 34,
		E_RGBA32_Float                   => 35,
		E_RGBA32_Uint                    => 36,
		E_RGBA32_Sint                    => 37,
		E_Stencil_8                      => 38,
		E_Depth16_Unorm                  => 39,
		E_Depth24_Plus                   => 40,
		E_Depth24_Plus_Stencil_8         => 41,
		E_Depth32_Float                  => 42,
		E_Depth32_Float_Stencil_8        => 43,
		E_BC1RGBA_Unorm                  => 44,
		E_BC1RGBA_Unorm_Srgb             => 45,
		E_BC2RGBA_Unorm                  => 46,
		E_BC2RGBA_Unorm_Srgb             => 47,
		E_BC3RGBA_Unorm                  => 48,
		E_BC3RGBA_Unorm_Srgb             => 49,
		E_BC4R_Unorm                     => 50,
		E_BC4R_Snorm                     => 51,
		E_BC5RG_Unorm                    => 52,
		E_BC5RG_Snorm                    => 53,
		E_BC6HRGB_Ufloat                 => 54,
		E_BC6HRGB_Float                  => 55,
		E_BC7RGBA_Unorm                  => 56,
		E_BC7RGBA_Unorm_Srgb             => 57,
		E_ETC2RGB8_Unorm                 => 58,
		E_ETC2RGB8_Unorm_Srgb            => 59,
		E_ETC2RGB8A1_Unorm               => 60,
		E_ETC2RGB8A1_Unorm_Srgb          => 61,
		E_ETC2RGBA8_Unorm                => 62,
		E_ETC2RGBA8_Unorm_Srgb           => 63,
		E_EACR11_Unorm                   => 64,
		E_EACR11_Snorm                   => 65,
		E_EACRG11_Unorm                  => 66,
		E_EACRG11_Snorm                  => 67,
		E_ASTC4x4_Unorm                  => 68,
		E_ASTC4x4_Unorm_Srgb             => 69,
		E_ASTC5x4_Unorm                  => 70,
		E_ASTC5x4_Unorm_Srgb             => 71,
		E_ASTC5x5_Unorm                  => 72,
		E_ASTC5x5_Unorm_Srgb             => 73,
		E_ASTC6x5_Unorm                  => 74,
		E_ASTC6x5_Unorm_Srgb             => 75,
		E_ASTC6x6_Unorm                  => 76,
		E_ASTC6x6_Unorm_Srgb             => 77,
		E_ASTC8x5_Unorm                  => 78,
		E_ASTC8x5_Unorm_Srgb             => 79,
		E_ASTC8x6_Unorm                  => 80,
		E_ASTC8x6_Unorm_Srgb             => 81,
		E_ASTC8x8_Unorm                  => 82,
		E_ASTC8x8_Unorm_Srgb             => 83,
		E_ASTC10x5_Unorm                 => 84,
		E_ASTC10x5_Unorm_Srgb            => 85,
		E_ASTC10x6_Unorm                 => 86,
		E_ASTC10x6_Unorm_Srgb            => 87,
		E_ASTC10x8_Unorm                 => 88,
		E_ASTC10x8_Unorm_Srgb            => 89,
		E_ASTC10x10_Unorm                => 90,
		E_ASTC10x10_Unorm_Srgb           => 91,
		E_ASTC12x10_Unorm                => 92,
		E_ASTC12x10_Unorm_Srgb           => 93,
		E_ASTC12x12_Unorm                => 94,
		E_ASTC12x12_Unorm_Srgb           => 95,
		E_R16_Unorm                      => 327680,
		E_RG16_Unorm                     => 327681,
		E_RGBA16_Unorm                   => 327682,
		E_R16_Snorm                      => 327683,
		E_RG16_Snorm                     => 327684,
		E_RGBA16_Snorm                   => 327685,
		E_R8BG8_Biplanar_420_Unorm       => 327686,
		E_R10X6BG10X6_Biplanar_420_Unorm => 327687,
		E_R8BG8A8_Triplanar_420_Unorm    => 327688,
		E_R8BG8_Biplanar_422_Unorm       => 327689,
		E_R8BG8_Biplanar_444_Unorm       => 327690,
		E_R10X6BG10X6_Biplanar_422_Unorm => 327691,
		E_R10X6BG10X6_Biplanar_444_Unorm => 327692,
		E_External                       => 327693
	);

	type T_Texture_Format_Arr is array (T_Positive range <>) of aliased T_Texture_Format;

	type T_Composite_Alpha_Mode is (
		E_Auto,
		E_Opaque,
		E_Premultiplied,
		E_Unpremultiplied,
		E_Inherit
	) with Convention => C, Size => 32;

	for T_Composite_Alpha_Mode use (
		E_Auto            => 0,
		E_Opaque          => 1,
		E_Premultiplied   => 2,
		E_Unpremultiplied => 3,
		E_Inherit         => 4
	);

	type T_Composite_Alpha_Mode_Arr is array (T_Positive range <>) of aliased T_Composite_Alpha_Mode;




	-- Data records
	type T_Device_Limits is record
		Max_Texture_Dimension1D                         : aliased T_UInt32 := 0;
		Max_Texture_Dimension2D                         : aliased T_UInt32 := 0;
		Max_Texture_Dimension3D                         : aliased T_UInt32 := 0;
		Max_Texture_Array_Layers                        : aliased T_UInt32 := 0;
		Max_Bind_Groups                                 : aliased T_UInt32 := 0;
		Max_Bind_Groups_Plus_Vertex_Buffers             : aliased T_UInt32 := 0;
		Max_Bindings_Per_Bind_Group                     : aliased T_UInt32 := 0;
		Max_Dynamic_Uniform_Buffers_Per_Pipeline_Layout : aliased T_UInt32 := 0;
		Max_Dynamic_Storage_Buffers_Per_Pipeline_Layout : aliased T_UInt32 := 0;
		Max_Sampled_Textures_Per_Shader_Stage           : aliased T_UInt32 := 0;
		Max_Samplers_Per_Shader_Stage                   : aliased T_UInt32 := 0;
		Max_Storage_Buffers_Per_Shader_Stage            : aliased T_UInt32 := 0;
		Max_Storage_Textures_Per_Shader_Stage           : aliased T_UInt32 := 0;
		Max_Uniform_Buffers_Per_Shader_Stage            : aliased T_UInt32 := 0;
		Max_Uniform_Buffer_Binding_Size                 : aliased T_UInt64 := 0;
		Max_Storage_Buffer_Binding_Size                 : aliased T_UInt64 := 0;
		Min_Uniform_Buffer_Offset_Alignment             : aliased T_UInt32 := 0;
		Min_Storage_Buffer_Offset_Alignment             : aliased T_UInt32 := 0;
		Max_Vertex_Buffers                              : aliased T_UInt32 := 0;
		Max_Buffer_Size                                 : aliased T_UInt64 := 0;
		Max_Vertex_Attributes                           : aliased T_UInt32 := 0;
		Max_Vertex_Buffer_Array_Stride                  : aliased T_UInt32 := 0;
		Max_Inter_Stage_Shader_Variables                : aliased T_UInt32 := 0;
		Max_Color_Attachments                           : aliased T_UInt32 := 0;
		Max_Color_Attachment_Bytes_Per_Sample           : aliased T_UInt32 := 0;
		Max_Compute_Workgroup_Storage_Size              : aliased T_UInt32 := 0;
		Max_Compute_Invocations_Per_Workgroup           : aliased T_UInt32 := 0;
		Max_Compute_Workgroup_Size_X                    : aliased T_UInt32 := 0;
		Max_Compute_Workgroup_Size_Y                    : aliased T_UInt32 := 0;
		Max_Compute_Workgroup_Size_Z                    : aliased T_UInt32 := 0;
		Max_Compute_Workgroups_Per_Dimension            : aliased T_UInt32 := 0;
		Max_Immediate_Size                              : aliased T_UInt32 := 0;
		Max_Storage_Buffers_In_Vertex_Stage             : aliased T_UInt32 := 0;
		Max_Storage_Textures_In_Vertex_Stage            : aliased T_UInt32 := 0;
		Max_Storage_Buffers_In_Fragment_Stage           : aliased T_UInt32 := 0;
		Max_Storage_Textures_In_Fragment_Stage          : aliased T_UInt32 := 0;
	end record
	with Convention => C_Pass_By_Copy;

	C_Max_Capability_Array_Length : constant T_Natural := 256; -- Arbitrary

	type T_Surface_Capabilities is record
		Usages             : T_Texture_Usage := 0;
		Formats            : T_Texture_Format_Arr (1 .. C_Max_Capability_Array_Length);
		Present_Modes      : T_Present_Mode_Arr (1 .. C_Max_Capability_Array_Length);
		Alpha_Modes        : T_Composite_Alpha_Mode_Arr (1 .. C_Max_Capability_Array_Length);
		Formats_Last       : T_Natural := 0;
		Present_Modes_Last : T_Natural := 0;
		Alpha_Modes_Last   : T_Natural := 0;
	end record;



	-- Callbacks
	type T_Device_Lost_Callback is access procedure (
		Device_Raw : in T_WGPUDevice;
		Reason     : in T_Device_Lost_Reason
	);

	type T_Uncaptured_Error_Callback is access procedure (
		Device_Raw : in T_WGPUDevice;
		Error      : in T_Error_Kind
	);



	-- Constants
	C_Texture_Usage_Undefined         : constant T_Texture_Usage := 0;
	C_Texture_Usage_Copy_Src          : constant T_Texture_Usage := 2 ** 0; -- 1
	C_Texture_Usage_Copy_Dst          : constant T_Texture_Usage := 2 ** 1; -- 2
	C_Texture_Usage_Texture_Binding   : constant T_Texture_Usage := 2 ** 2; -- 4
	C_Texture_Usage_Storage_Binding   : constant T_Texture_Usage := 2 ** 3; -- 8
	C_Texture_Usage_Render_Attachment : constant T_Texture_Usage := 2 ** 4; -- 16



end Cre8or_WebGPU.Types;
