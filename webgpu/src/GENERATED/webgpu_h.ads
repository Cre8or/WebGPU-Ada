pragma Ada_2012;

pragma Style_Checks (Off);
pragma Warnings (Off, "-gnatwu");

with Interfaces.C; use Interfaces.C;
with bits_stdint_uintn_h;
with Interfaces.C.Strings;
with stddef_h;
with System;
with bits_stdint_intn_h;

package webgpu_h is

   --  unsupported macro: WGPU_ARRAY_LAYER_COUNT_UNDEFINED (UINT32_MAX)
   --  unsupported macro: WGPU_COPY_STRIDE_UNDEFINED (UINT32_MAX)
   --  unsupported macro: WGPU_DEPTH_SLICE_UNDEFINED (UINT32_MAX)
   --  unsupported macro: WGPU_LIMIT_U32_UNDEFINED (UINT32_MAX)
   --  unsupported macro: WGPU_LIMIT_U64_UNDEFINED (UINT64_MAX)
   --  unsupported macro: WGPU_MIP_LEVEL_COUNT_UNDEFINED (UINT32_MAX)
   --  unsupported macro: WGPU_QUERY_SET_INDEX_UNDEFINED (UINT32_MAX)
   --  unsupported macro: WGPU_WHOLE_MAP_SIZE (SIZE_MAX)
   --  unsupported macro: WGPU_WHOLE_SIZE (UINT64_MAX)
   --  unsupported macro: WGPU_STRLEN SIZE_MAX
   --  unsupported macro: WGPU_STRING_VIEW_INIT _wgpu_MAKE_INIT_STRUCT(WGPUStringView, { NULL _wgpu_COMMA WGPU_STRLEN _wgpu_COMMA })
  --*
  -- * Copyright 2019-2023 WebGPU-Native developers
  -- *
  -- * SPDX-License-Identifier: BSD-3-Clause
  --

  --* @file
  --*
  -- * \mainpage
  -- *
  -- * **Important:** *This documentation is a Work In Progress.*
  -- *
  -- * This is the home of WebGPU C API specification. We define here the standard
  -- * `webgpu.h` header that all implementations should provide.
  --

  --*
  -- * \defgroup Constants
  -- * \brief Constants.
  -- *
  -- * @{
  --

  --* @}
  --*
  -- * \defgroup UtilityTypes Utility Types
  -- *
  -- * @{
  --

   subtype WGPUFlags is bits_stdint_uintn_h.uint64_t;  -- webgpu.h:96

   subtype T_WGPUBool is bits_stdint_uintn_h.uint32_t;  -- webgpu.h:97

	type T_Size   is new Interfaces.C.size_t;

  --*
  -- * Nullable value defining a pointer+length view into a UTF-8 encoded string.
  -- *
  -- * Values passed into the API may use the special length value @ref WGPU_STRLEN
  -- * to indicate a null-terminated string.
  -- * Non-null values passed out of the API (for example as callback arguments)
  -- * always provide an explicit length and **may or may not be null-terminated**.
  -- *
  -- * Some inputs to the API accept null values. Those which do not accept null
  -- * values "default" to the empty string when null values are passed.
  -- *
  -- * Values are encoded as follows:
  -- * - `{NULL, WGPU_STRLEN}`: the null value.
  -- * - `{non_null_pointer, WGPU_STRLEN}`: a null-terminated string view.
  -- * - `{any, 0}`: the empty string.
  -- * - `{NULL, non_zero_length}`: not allowed (null dereference).
  -- * - `{non_null_pointer, non_zero_length}`: an explictly-sized string view with
  -- *   size `non_zero_length` (in bytes).
  -- *
  -- * For info on how this is used in various places, see \ref Strings.
  --

   type WGPUStringView is record
      data : Interfaces.C.Strings.chars_ptr;  -- webgpu.h:121
      length : aliased T_Size;  -- webgpu.h:122
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:120

  --*
  -- * Sentinel value used in @ref WGPUStringView to indicate that the pointer
  -- * is to a null-terminated string, rather than an explicitly-sized string.
  --

  --* @}
  --*
  -- * \defgroup Objects
  -- * \brief Opaque, non-dispatchable handles to WebGPU objects.
  -- *
  -- * @{
  --

   type WGPUAdapterImpl is null record;   -- incomplete struct

   type WGPUAdapter is access all WGPUAdapterImpl;  -- webgpu.h:145

   type WGPUBindGroupImpl is null record;   -- incomplete struct

   type WGPUBindGroup is access all WGPUBindGroupImpl;  -- webgpu.h:146

   type WGPUBindGroupLayoutImpl is null record;   -- incomplete struct

   type WGPUBindGroupLayout is access all WGPUBindGroupLayoutImpl;  -- webgpu.h:147

   type WGPUBufferImpl is null record;   -- incomplete struct

   type WGPUBuffer is access all WGPUBufferImpl;  -- webgpu.h:148

   type WGPUCommandBufferImpl is null record;   -- incomplete struct

   type WGPUCommandBuffer is access all WGPUCommandBufferImpl;  -- webgpu.h:149

   type WGPUCommandEncoderImpl is null record;   -- incomplete struct

   type WGPUCommandEncoder is access all WGPUCommandEncoderImpl;  -- webgpu.h:150

   type WGPUComputePassEncoderImpl is null record;   -- incomplete struct

   type WGPUComputePassEncoder is access all WGPUComputePassEncoderImpl;  -- webgpu.h:151

   type WGPUComputePipelineImpl is null record;   -- incomplete struct

   type WGPUComputePipeline is access all WGPUComputePipelineImpl;  -- webgpu.h:152

   type WGPUDeviceImpl is null record;   -- incomplete struct

   type WGPUDevice is access all WGPUDeviceImpl;  -- webgpu.h:153

   type T_WGPUInstanceImpl is null record;   -- incomplete struct

   type T_WGPUInstance is access all T_WGPUInstanceImpl;  -- webgpu.h:154

   type WGPUPipelineLayoutImpl is null record;   -- incomplete struct

   type WGPUPipelineLayout is access all WGPUPipelineLayoutImpl;  -- webgpu.h:155

   type WGPUQuerySetImpl is null record;   -- incomplete struct

   type WGPUQuerySet is access all WGPUQuerySetImpl;  -- webgpu.h:156

   type WGPUQueueImpl is null record;   -- incomplete struct

   type WGPUQueue is access all WGPUQueueImpl;  -- webgpu.h:157

   type WGPURenderBundleImpl is null record;   -- incomplete struct

   type WGPURenderBundle is access all WGPURenderBundleImpl;  -- webgpu.h:158

   type WGPURenderBundleEncoderImpl is null record;   -- incomplete struct

   type WGPURenderBundleEncoder is access all WGPURenderBundleEncoderImpl;  -- webgpu.h:159

   type WGPURenderPassEncoderImpl is null record;   -- incomplete struct

   type WGPURenderPassEncoder is access all WGPURenderPassEncoderImpl;  -- webgpu.h:160

   type WGPURenderPipelineImpl is null record;   -- incomplete struct

   type WGPURenderPipeline is access all WGPURenderPipelineImpl;  -- webgpu.h:161

   type WGPUSamplerImpl is null record;   -- incomplete struct

   type WGPUSampler is access all WGPUSamplerImpl;  -- webgpu.h:162

   type WGPUShaderModuleImpl is null record;   -- incomplete struct

   type WGPUShaderModule is access all WGPUShaderModuleImpl;  -- webgpu.h:163

  --*
  -- * An object used to continuously present image data to the user, see @ref Surfaces for more details.
  --

   type WGPUSurfaceImpl is null record;   -- incomplete struct

   type WGPUSurface is access all WGPUSurfaceImpl;  -- webgpu.h:167

   type WGPUTextureImpl is null record;   -- incomplete struct

   type WGPUTexture is access all WGPUTextureImpl;  -- webgpu.h:168

   type WGPUTextureViewImpl is null record;   -- incomplete struct

   type WGPUTextureView is access all WGPUTextureViewImpl;  -- webgpu.h:169

  --* @}
  -- Structure forward declarations
  -- Callback info structure forward declarations
  --*
  -- * \defgroup Enumerations
  -- * \brief Enums.
  -- *
  -- * @{
  --

   subtype WGPUAdapterType is unsigned;
   WGPUAdapterType_WGPUAdapterType_DiscreteGPU : constant WGPUAdapterType := 1;
   WGPUAdapterType_WGPUAdapterType_IntegratedGPU : constant WGPUAdapterType := 2;
   WGPUAdapterType_WGPUAdapterType_CPU : constant WGPUAdapterType := 3;
   WGPUAdapterType_WGPUAdapterType_Unknown : constant WGPUAdapterType := 4;
   WGPUAdapterType_WGPUAdapterType_Force32 : constant WGPUAdapterType := 2147483647;  -- webgpu.h:266

   subtype WGPUAddressMode is unsigned;
   WGPUAddressMode_WGPUAddressMode_Undefined : constant WGPUAddressMode := 0;
   WGPUAddressMode_WGPUAddressMode_ClampToEdge : constant WGPUAddressMode := 1;
   WGPUAddressMode_WGPUAddressMode_Repeat : constant WGPUAddressMode := 2;
   WGPUAddressMode_WGPUAddressMode_MirrorRepeat : constant WGPUAddressMode := 3;
   WGPUAddressMode_WGPUAddressMode_Force32 : constant WGPUAddressMode := 2147483647;  -- webgpu.h:274

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUBackendType is unsigned;
   WGPUBackendType_WGPUBackendType_Undefined : constant WGPUBackendType := 0;
   WGPUBackendType_WGPUBackendType_Null : constant WGPUBackendType := 1;
   WGPUBackendType_WGPUBackendType_WebGPU : constant WGPUBackendType := 2;
   WGPUBackendType_WGPUBackendType_D3D11 : constant WGPUBackendType := 3;
   WGPUBackendType_WGPUBackendType_D3D12 : constant WGPUBackendType := 4;
   WGPUBackendType_WGPUBackendType_Metal : constant WGPUBackendType := 5;
   WGPUBackendType_WGPUBackendType_Vulkan : constant WGPUBackendType := 6;
   WGPUBackendType_WGPUBackendType_OpenGL : constant WGPUBackendType := 7;
   WGPUBackendType_WGPUBackendType_OpenGLES : constant WGPUBackendType := 8;
   WGPUBackendType_WGPUBackendType_Force32 : constant WGPUBackendType := 2147483647;  -- webgpu.h:286

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUBlendFactor is unsigned;
   WGPUBlendFactor_WGPUBlendFactor_Undefined : constant WGPUBlendFactor := 0;
   WGPUBlendFactor_WGPUBlendFactor_Zero : constant WGPUBlendFactor := 1;
   WGPUBlendFactor_WGPUBlendFactor_One : constant WGPUBlendFactor := 2;
   WGPUBlendFactor_WGPUBlendFactor_Src : constant WGPUBlendFactor := 3;
   WGPUBlendFactor_WGPUBlendFactor_OneMinusSrc : constant WGPUBlendFactor := 4;
   WGPUBlendFactor_WGPUBlendFactor_SrcAlpha : constant WGPUBlendFactor := 5;
   WGPUBlendFactor_WGPUBlendFactor_OneMinusSrcAlpha : constant WGPUBlendFactor := 6;
   WGPUBlendFactor_WGPUBlendFactor_Dst : constant WGPUBlendFactor := 7;
   WGPUBlendFactor_WGPUBlendFactor_OneMinusDst : constant WGPUBlendFactor := 8;
   WGPUBlendFactor_WGPUBlendFactor_DstAlpha : constant WGPUBlendFactor := 9;
   WGPUBlendFactor_WGPUBlendFactor_OneMinusDstAlpha : constant WGPUBlendFactor := 10;
   WGPUBlendFactor_WGPUBlendFactor_SrcAlphaSaturated : constant WGPUBlendFactor := 11;
   WGPUBlendFactor_WGPUBlendFactor_Constant : constant WGPUBlendFactor := 12;
   WGPUBlendFactor_WGPUBlendFactor_OneMinusConstant : constant WGPUBlendFactor := 13;
   WGPUBlendFactor_WGPUBlendFactor_Src1 : constant WGPUBlendFactor := 14;
   WGPUBlendFactor_WGPUBlendFactor_OneMinusSrc1 : constant WGPUBlendFactor := 15;
   WGPUBlendFactor_WGPUBlendFactor_Src1Alpha : constant WGPUBlendFactor := 16;
   WGPUBlendFactor_WGPUBlendFactor_OneMinusSrc1Alpha : constant WGPUBlendFactor := 17;
   WGPUBlendFactor_WGPUBlendFactor_Force32 : constant WGPUBlendFactor := 2147483647;  -- webgpu.h:303

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUBlendOperation is unsigned;
   WGPUBlendOperation_WGPUBlendOperation_Undefined : constant WGPUBlendOperation := 0;
   WGPUBlendOperation_WGPUBlendOperation_Add : constant WGPUBlendOperation := 1;
   WGPUBlendOperation_WGPUBlendOperation_Subtract : constant WGPUBlendOperation := 2;
   WGPUBlendOperation_WGPUBlendOperation_ReverseSubtract : constant WGPUBlendOperation := 3;
   WGPUBlendOperation_WGPUBlendOperation_Min : constant WGPUBlendOperation := 4;
   WGPUBlendOperation_WGPUBlendOperation_Max : constant WGPUBlendOperation := 5;
   WGPUBlendOperation_WGPUBlendOperation_Force32 : constant WGPUBlendOperation := 2147483647;  -- webgpu.h:329

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUBufferBindingType is unsigned;
   WGPUBufferBindingType_WGPUBufferBindingType_BindingNotUsed : constant WGPUBufferBindingType := 0;
   WGPUBufferBindingType_WGPUBufferBindingType_Undefined : constant WGPUBufferBindingType := 1;
   WGPUBufferBindingType_WGPUBufferBindingType_Uniform : constant WGPUBufferBindingType := 2;
   WGPUBufferBindingType_WGPUBufferBindingType_Storage : constant WGPUBufferBindingType := 3;
   WGPUBufferBindingType_WGPUBufferBindingType_ReadOnlyStorage : constant WGPUBufferBindingType := 4;
   WGPUBufferBindingType_WGPUBufferBindingType_Force32 : constant WGPUBufferBindingType := 2147483647;  -- webgpu.h:343

  --*
  --     * `0x00000000`.
  --     * Indicates that this @ref WGPUBufferBindingLayout member of
  --     * its parent @ref WGPUBindGroupLayoutEntry is not used.
  --     * (See also @ref SentinelValues.)
  --

  --*
  --     * `0x00000001`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUBufferMapState is unsigned;
   WGPUBufferMapState_WGPUBufferMapState_Unmapped : constant WGPUBufferMapState := 1;
   WGPUBufferMapState_WGPUBufferMapState_Pending : constant WGPUBufferMapState := 2;
   WGPUBufferMapState_WGPUBufferMapState_Mapped : constant WGPUBufferMapState := 3;
   WGPUBufferMapState_WGPUBufferMapState_Force32 : constant WGPUBufferMapState := 2147483647;  -- webgpu.h:362

  --*
  -- * The callback mode controls how a callback for an asynchronous operation may be fired. See @ref Asynchronous-Operations for how these are used.
  --

   subtype WGPUCallbackMode is unsigned;
   WGPUCallbackMode_WGPUCallbackMode_WaitAnyOnly : constant WGPUCallbackMode := 1;
   WGPUCallbackMode_WGPUCallbackMode_AllowProcessEvents : constant WGPUCallbackMode := 2;
   WGPUCallbackMode_WGPUCallbackMode_AllowSpontaneous : constant WGPUCallbackMode := 3;
   WGPUCallbackMode_WGPUCallbackMode_Force32 : constant WGPUCallbackMode := 2147483647;  -- webgpu.h:372

  --*
  --     * `0x00000001`.
  --     * Callbacks created with `WGPUCallbackMode_WaitAnyOnly`:
  --     * - fire when the asynchronous operation's future is passed to a call to `::wgpuInstanceWaitAny`
  --     *   AND the operation has already completed or it completes inside the call to `::wgpuInstanceWaitAny`.
  --

  --*
  --     * `0x00000002`.
  --     * Callbacks created with `WGPUCallbackMode_AllowProcessEvents`:
  --     * - fire for the same reasons as callbacks created with `WGPUCallbackMode_WaitAnyOnly`
  --     * - fire inside a call to `::wgpuInstanceProcessEvents` if the asynchronous operation is complete.
  --

  --*
  --     * `0x00000003`.
  --     * Callbacks created with `WGPUCallbackMode_AllowSpontaneous`:
  --     * - fire for the same reasons as callbacks created with `WGPUCallbackMode_AllowProcessEvents`
  --     * - **may** fire spontaneously on an arbitrary or application thread, when the WebGPU implementations discovers that the asynchronous operation is complete.
  --     *
  --     *   Implementations _should_ fire spontaneous callbacks as soon as possible.
  --     *
  --     * @note Because spontaneous callbacks may fire at an arbitrary time on an arbitrary thread, applications should take extra care when acquiring locks or mutating state inside the callback. It undefined behavior to re-entrantly call into the webgpu.h API if the callback fires while inside the callstack of another webgpu.h function that is not `wgpuInstanceWaitAny` or `wgpuInstanceProcessEvents`.
  --

   subtype WGPUCompareFunction is unsigned;
   WGPUCompareFunction_WGPUCompareFunction_Undefined : constant WGPUCompareFunction := 0;
   WGPUCompareFunction_WGPUCompareFunction_Never : constant WGPUCompareFunction := 1;
   WGPUCompareFunction_WGPUCompareFunction_Less : constant WGPUCompareFunction := 2;
   WGPUCompareFunction_WGPUCompareFunction_Equal : constant WGPUCompareFunction := 3;
   WGPUCompareFunction_WGPUCompareFunction_LessEqual : constant WGPUCompareFunction := 4;
   WGPUCompareFunction_WGPUCompareFunction_Greater : constant WGPUCompareFunction := 5;
   WGPUCompareFunction_WGPUCompareFunction_NotEqual : constant WGPUCompareFunction := 6;
   WGPUCompareFunction_WGPUCompareFunction_GreaterEqual : constant WGPUCompareFunction := 7;
   WGPUCompareFunction_WGPUCompareFunction_Always : constant WGPUCompareFunction := 8;
   WGPUCompareFunction_WGPUCompareFunction_Force32 : constant WGPUCompareFunction := 2147483647;  -- webgpu.h:401

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUCompilationInfoRequestStatus is unsigned;
   WGPUCompilationInfoRequestStatus_WGPUCompilationInfoRequestStatus_Success : constant WGPUCompilationInfoRequestStatus := 1;
   WGPUCompilationInfoRequestStatus_WGPUCompilationInfoRequestStatus_InstanceDropped : constant WGPUCompilationInfoRequestStatus := 2;
   WGPUCompilationInfoRequestStatus_WGPUCompilationInfoRequestStatus_Error : constant WGPUCompilationInfoRequestStatus := 3;
   WGPUCompilationInfoRequestStatus_WGPUCompilationInfoRequestStatus_Unknown : constant WGPUCompilationInfoRequestStatus := 4;
   WGPUCompilationInfoRequestStatus_WGPUCompilationInfoRequestStatus_Force32 : constant WGPUCompilationInfoRequestStatus := 2147483647;  -- webgpu.h:418

   subtype WGPUCompilationMessageType is unsigned;
   WGPUCompilationMessageType_WGPUCompilationMessageType_Error : constant WGPUCompilationMessageType := 1;
   WGPUCompilationMessageType_WGPUCompilationMessageType_Warning : constant WGPUCompilationMessageType := 2;
   WGPUCompilationMessageType_WGPUCompilationMessageType_Info : constant WGPUCompilationMessageType := 3;
   WGPUCompilationMessageType_WGPUCompilationMessageType_Force32 : constant WGPUCompilationMessageType := 2147483647;  -- webgpu.h:426

  --*
  -- * Describes how frames are composited with other contents on the screen when `::wgpuSurfacePresent` is called.
  --

   subtype WGPUCompositeAlphaMode is unsigned;
   WGPUCompositeAlphaMode_WGPUCompositeAlphaMode_Auto : constant WGPUCompositeAlphaMode := 0;
   WGPUCompositeAlphaMode_WGPUCompositeAlphaMode_Opaque : constant WGPUCompositeAlphaMode := 1;
   WGPUCompositeAlphaMode_WGPUCompositeAlphaMode_Premultiplied : constant WGPUCompositeAlphaMode := 2;
   WGPUCompositeAlphaMode_WGPUCompositeAlphaMode_Unpremultiplied : constant WGPUCompositeAlphaMode := 3;
   WGPUCompositeAlphaMode_WGPUCompositeAlphaMode_Inherit : constant WGPUCompositeAlphaMode := 4;
   WGPUCompositeAlphaMode_WGPUCompositeAlphaMode_Force32 : constant WGPUCompositeAlphaMode := 2147483647;  -- webgpu.h:436

  --*
  --     * `0x00000000`.
  --     * Lets the WebGPU implementation choose the best mode (supported, and with the best performance) between @ref WGPUCompositeAlphaMode_Opaque or @ref WGPUCompositeAlphaMode_Inherit.
  --

  --*
  --     * `0x00000001`.
  --     * The alpha component of the image is ignored and teated as if it is always 1.0.
  --

  --*
  --     * `0x00000002`.
  --     * The alpha component is respected and non-alpha components are assumed to be already multiplied with the alpha component. For example, (0.5, 0, 0, 0.5) is semi-transparent bright red.
  --

  --*
  --     * `0x00000003`.
  --     * The alpha component is respected and non-alpha components are assumed to NOT be already multiplied with the alpha component. For example, (1.0, 0, 0, 0.5) is semi-transparent bright red.
  --

  --*
  --     * `0x00000004`.
  --     * The handling of the alpha component is unknown to WebGPU and should be handled by the application using system-specific APIs. This mode may be unavailable (for example on Wasm).
  --

   subtype WGPUCreatePipelineAsyncStatus is unsigned;
   WGPUCreatePipelineAsyncStatus_WGPUCreatePipelineAsyncStatus_Success : constant WGPUCreatePipelineAsyncStatus := 1;
   WGPUCreatePipelineAsyncStatus_WGPUCreatePipelineAsyncStatus_InstanceDropped : constant WGPUCreatePipelineAsyncStatus := 2;
   WGPUCreatePipelineAsyncStatus_WGPUCreatePipelineAsyncStatus_ValidationError : constant WGPUCreatePipelineAsyncStatus := 3;
   WGPUCreatePipelineAsyncStatus_WGPUCreatePipelineAsyncStatus_InternalError : constant WGPUCreatePipelineAsyncStatus := 4;
   WGPUCreatePipelineAsyncStatus_WGPUCreatePipelineAsyncStatus_Unknown : constant WGPUCreatePipelineAsyncStatus := 5;
   WGPUCreatePipelineAsyncStatus_WGPUCreatePipelineAsyncStatus_Force32 : constant WGPUCreatePipelineAsyncStatus := 2147483647;  -- webgpu.h:465

   subtype WGPUCullMode is unsigned;
   WGPUCullMode_WGPUCullMode_Undefined : constant WGPUCullMode := 0;
   WGPUCullMode_WGPUCullMode_None : constant WGPUCullMode := 1;
   WGPUCullMode_WGPUCullMode_Front : constant WGPUCullMode := 2;
   WGPUCullMode_WGPUCullMode_Back : constant WGPUCullMode := 3;
   WGPUCullMode_WGPUCullMode_Force32 : constant WGPUCullMode := 2147483647;  -- webgpu.h:474

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUDeviceLostReason is unsigned;
   WGPUDeviceLostReason_WGPUDeviceLostReason_Unknown : constant WGPUDeviceLostReason := 1;
   WGPUDeviceLostReason_WGPUDeviceLostReason_Destroyed : constant WGPUDeviceLostReason := 2;
   WGPUDeviceLostReason_WGPUDeviceLostReason_InstanceDropped : constant WGPUDeviceLostReason := 3;
   WGPUDeviceLostReason_WGPUDeviceLostReason_FailedCreation : constant WGPUDeviceLostReason := 4;
   WGPUDeviceLostReason_WGPUDeviceLostReason_Force32 : constant WGPUDeviceLostReason := 2147483647;  -- webgpu.h:486

   subtype WGPUErrorFilter is unsigned;
   WGPUErrorFilter_WGPUErrorFilter_Validation : constant WGPUErrorFilter := 1;
   WGPUErrorFilter_WGPUErrorFilter_OutOfMemory : constant WGPUErrorFilter := 2;
   WGPUErrorFilter_WGPUErrorFilter_Internal : constant WGPUErrorFilter := 3;
   WGPUErrorFilter_WGPUErrorFilter_Force32 : constant WGPUErrorFilter := 2147483647;  -- webgpu.h:494

   subtype WGPUErrorType is unsigned;
   WGPUErrorType_WGPUErrorType_NoError : constant WGPUErrorType := 1;
   WGPUErrorType_WGPUErrorType_Validation : constant WGPUErrorType := 2;
   WGPUErrorType_WGPUErrorType_OutOfMemory : constant WGPUErrorType := 3;
   WGPUErrorType_WGPUErrorType_Internal : constant WGPUErrorType := 4;
   WGPUErrorType_WGPUErrorType_Unknown : constant WGPUErrorType := 5;
   WGPUErrorType_WGPUErrorType_Force32 : constant WGPUErrorType := 2147483647;  -- webgpu.h:501

  --*
  -- * See @ref WGPURequestAdapterOptions::featureLevel.
  --

   subtype WGPUFeatureLevel is unsigned;
   WGPUFeatureLevel_WGPUFeatureLevel_Compatibility : constant WGPUFeatureLevel := 1;
   WGPUFeatureLevel_WGPUFeatureLevel_Core : constant WGPUFeatureLevel := 2;
   WGPUFeatureLevel_WGPUFeatureLevel_Force32 : constant WGPUFeatureLevel := 2147483647;  -- webgpu.h:513

  --*
  --     * `0x00000001`.
  --     * "Compatibility" profile which can be supported on OpenGL ES 3.1.
  --

  --*
  --     * `0x00000002`.
  --     * "Core" profile which can be supported on Vulkan/Metal/D3D12.
  --

   subtype WGPUFeatureName is unsigned;
   WGPUFeatureName_WGPUFeatureName_Undefined : constant WGPUFeatureName := 0;
   WGPUFeatureName_WGPUFeatureName_DepthClipControl : constant WGPUFeatureName := 1;
   WGPUFeatureName_WGPUFeatureName_Depth32FloatStencil8 : constant WGPUFeatureName := 2;
   WGPUFeatureName_WGPUFeatureName_TimestampQuery : constant WGPUFeatureName := 3;
   WGPUFeatureName_WGPUFeatureName_TextureCompressionBC : constant WGPUFeatureName := 4;
   WGPUFeatureName_WGPUFeatureName_TextureCompressionBCSliced3D : constant WGPUFeatureName := 5;
   WGPUFeatureName_WGPUFeatureName_TextureCompressionETC2 : constant WGPUFeatureName := 6;
   WGPUFeatureName_WGPUFeatureName_TextureCompressionASTC : constant WGPUFeatureName := 7;
   WGPUFeatureName_WGPUFeatureName_TextureCompressionASTCSliced3D : constant WGPUFeatureName := 8;
   WGPUFeatureName_WGPUFeatureName_IndirectFirstInstance : constant WGPUFeatureName := 9;
   WGPUFeatureName_WGPUFeatureName_ShaderF16 : constant WGPUFeatureName := 10;
   WGPUFeatureName_WGPUFeatureName_RG11B10UfloatRenderable : constant WGPUFeatureName := 11;
   WGPUFeatureName_WGPUFeatureName_BGRA8UnormStorage : constant WGPUFeatureName := 12;
   WGPUFeatureName_WGPUFeatureName_Float32Filterable : constant WGPUFeatureName := 13;
   WGPUFeatureName_WGPUFeatureName_Float32Blendable : constant WGPUFeatureName := 14;
   WGPUFeatureName_WGPUFeatureName_ClipDistances : constant WGPUFeatureName := 15;
   WGPUFeatureName_WGPUFeatureName_DualSourceBlending : constant WGPUFeatureName := 16;
   WGPUFeatureName_WGPUFeatureName_Force32 : constant WGPUFeatureName := 2147483647;  -- webgpu.h:527

   subtype WGPUFilterMode is unsigned;
   WGPUFilterMode_WGPUFilterMode_Undefined : constant WGPUFilterMode := 0;
   WGPUFilterMode_WGPUFilterMode_Nearest : constant WGPUFilterMode := 1;
   WGPUFilterMode_WGPUFilterMode_Linear : constant WGPUFilterMode := 2;
   WGPUFilterMode_WGPUFilterMode_Force32 : constant WGPUFilterMode := 2147483647;  -- webgpu.h:548

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUFrontFace is unsigned;
   WGPUFrontFace_WGPUFrontFace_Undefined : constant WGPUFrontFace := 0;
   WGPUFrontFace_WGPUFrontFace_CCW : constant WGPUFrontFace := 1;
   WGPUFrontFace_WGPUFrontFace_CW : constant WGPUFrontFace := 2;
   WGPUFrontFace_WGPUFrontFace_Force32 : constant WGPUFrontFace := 2147483647;  -- webgpu.h:559

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUIndexFormat is unsigned;
   WGPUIndexFormat_WGPUIndexFormat_Undefined : constant WGPUIndexFormat := 0;
   WGPUIndexFormat_WGPUIndexFormat_Uint16 : constant WGPUIndexFormat := 1;
   WGPUIndexFormat_WGPUIndexFormat_Uint32 : constant WGPUIndexFormat := 2;
   WGPUIndexFormat_WGPUIndexFormat_Force32 : constant WGPUIndexFormat := 2147483647;  -- webgpu.h:570

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPULoadOp is unsigned;
   WGPULoadOp_WGPULoadOp_Undefined : constant WGPULoadOp := 0;
   WGPULoadOp_WGPULoadOp_Load : constant WGPULoadOp := 1;
   WGPULoadOp_WGPULoadOp_Clear : constant WGPULoadOp := 2;
   WGPULoadOp_WGPULoadOp_Force32 : constant WGPULoadOp := 2147483647;  -- webgpu.h:581

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUMapAsyncStatus is unsigned;
   WGPUMapAsyncStatus_WGPUMapAsyncStatus_Success : constant WGPUMapAsyncStatus := 1;
   WGPUMapAsyncStatus_WGPUMapAsyncStatus_InstanceDropped : constant WGPUMapAsyncStatus := 2;
   WGPUMapAsyncStatus_WGPUMapAsyncStatus_Error : constant WGPUMapAsyncStatus := 3;
   WGPUMapAsyncStatus_WGPUMapAsyncStatus_Aborted : constant WGPUMapAsyncStatus := 4;
   WGPUMapAsyncStatus_WGPUMapAsyncStatus_Unknown : constant WGPUMapAsyncStatus := 5;
   WGPUMapAsyncStatus_WGPUMapAsyncStatus_Force32 : constant WGPUMapAsyncStatus := 2147483647;  -- webgpu.h:592

   subtype WGPUMipmapFilterMode is unsigned;
   WGPUMipmapFilterMode_WGPUMipmapFilterMode_Undefined : constant WGPUMipmapFilterMode := 0;
   WGPUMipmapFilterMode_WGPUMipmapFilterMode_Nearest : constant WGPUMipmapFilterMode := 1;
   WGPUMipmapFilterMode_WGPUMipmapFilterMode_Linear : constant WGPUMipmapFilterMode := 2;
   WGPUMipmapFilterMode_WGPUMipmapFilterMode_Force32 : constant WGPUMipmapFilterMode := 2147483647;  -- webgpu.h:601

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUOptionalBool is unsigned;
   WGPUOptionalBool_WGPUOptionalBool_False : constant WGPUOptionalBool := 0;
   WGPUOptionalBool_WGPUOptionalBool_True : constant WGPUOptionalBool := 1;
   WGPUOptionalBool_WGPUOptionalBool_Undefined : constant WGPUOptionalBool := 2;
   WGPUOptionalBool_WGPUOptionalBool_Force32 : constant WGPUOptionalBool := 2147483647;  -- webgpu.h:612

   subtype WGPUPopErrorScopeStatus is unsigned;
   WGPUPopErrorScopeStatus_WGPUPopErrorScopeStatus_Success : constant WGPUPopErrorScopeStatus := 1;
   WGPUPopErrorScopeStatus_WGPUPopErrorScopeStatus_InstanceDropped : constant WGPUPopErrorScopeStatus := 2;
   WGPUPopErrorScopeStatus_WGPUPopErrorScopeStatus_EmptyStack : constant WGPUPopErrorScopeStatus := 3;
   WGPUPopErrorScopeStatus_WGPUPopErrorScopeStatus_Force32 : constant WGPUPopErrorScopeStatus := 2147483647;  -- webgpu.h:619

  --*
  --     * `0x00000001`.
  --     * The error scope stack was successfully popped and a result was reported.
  --

  --*
  --     * `0x00000003`.
  --     * The error scope stack could not be popped, because it was empty.
  --

   subtype WGPUPowerPreference is unsigned;
   WGPUPowerPreference_WGPUPowerPreference_Undefined : constant WGPUPowerPreference := 0;
   WGPUPowerPreference_WGPUPowerPreference_LowPower : constant WGPUPowerPreference := 1;
   WGPUPowerPreference_WGPUPowerPreference_HighPerformance : constant WGPUPowerPreference := 2;
   WGPUPowerPreference_WGPUPowerPreference_Force32 : constant WGPUPowerPreference := 2147483647;  -- webgpu.h:634

  --*
  --     * `0x00000000`.
  --     * No preference. (See also @ref SentinelValues.)
  --

  --*
  -- * Describes when and in which order frames are presented on the screen when `::wgpuSurfacePresent` is called.
  --

   subtype WGPUPresentMode is unsigned;
   WGPUPresentMode_WGPUPresentMode_Undefined : constant WGPUPresentMode := 0;
   WGPUPresentMode_WGPUPresentMode_Fifo : constant WGPUPresentMode := 1;
   WGPUPresentMode_WGPUPresentMode_FifoRelaxed : constant WGPUPresentMode := 2;
   WGPUPresentMode_WGPUPresentMode_Immediate : constant WGPUPresentMode := 3;
   WGPUPresentMode_WGPUPresentMode_Mailbox : constant WGPUPresentMode := 4;
   WGPUPresentMode_WGPUPresentMode_Force32 : constant WGPUPresentMode := 2147483647;  -- webgpu.h:648

  --*
  --     * `0x00000000`.
  --     * Present mode is not specified. Use the default.
  --

  --*
  --     * `0x00000001`.
  --     * The presentation of the image to the user waits for the next vertical blanking period to update in a first-in, first-out manner.
  --     * Tearing cannot be observed and frame-loop will be limited to the display's refresh rate.
  --     * This is the only mode that's always available.
  --

  --*
  --     * `0x00000002`.
  --     * The presentation of the image to the user tries to wait for the next vertical blanking period but may decide to not wait if a frame is presented late.
  --     * Tearing can sometimes be observed but late-frame don't produce a full-frame stutter in the presentation.
  --     * This is still a first-in, first-out mechanism so a frame-loop will be limited to the display's refresh rate.
  --

  --*
  --     * `0x00000003`.
  --     * The presentation of the image to the user is updated immediately without waiting for a vertical blank.
  --     * Tearing can be observed but latency is minimized.
  --

  --*
  --     * `0x00000004`.
  --     * The presentation of the image to the user waits for the next vertical blanking period to update to the latest provided image.
  --     * Tearing cannot be observed and a frame-loop is not limited to the display's refresh rate.
  --

   subtype WGPUPrimitiveTopology is unsigned;
   WGPUPrimitiveTopology_WGPUPrimitiveTopology_Undefined : constant WGPUPrimitiveTopology := 0;
   WGPUPrimitiveTopology_WGPUPrimitiveTopology_PointList : constant WGPUPrimitiveTopology := 1;
   WGPUPrimitiveTopology_WGPUPrimitiveTopology_LineList : constant WGPUPrimitiveTopology := 2;
   WGPUPrimitiveTopology_WGPUPrimitiveTopology_LineStrip : constant WGPUPrimitiveTopology := 3;
   WGPUPrimitiveTopology_WGPUPrimitiveTopology_TriangleList : constant WGPUPrimitiveTopology := 4;
   WGPUPrimitiveTopology_WGPUPrimitiveTopology_TriangleStrip : constant WGPUPrimitiveTopology := 5;
   WGPUPrimitiveTopology_WGPUPrimitiveTopology_Force32 : constant WGPUPrimitiveTopology := 2147483647;  -- webgpu.h:683

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUQueryType is unsigned;
   WGPUQueryType_WGPUQueryType_Occlusion : constant WGPUQueryType := 1;
   WGPUQueryType_WGPUQueryType_Timestamp : constant WGPUQueryType := 2;
   WGPUQueryType_WGPUQueryType_Force32 : constant WGPUQueryType := 2147483647;  -- webgpu.h:697

   subtype WGPUQueueWorkDoneStatus is unsigned;
   WGPUQueueWorkDoneStatus_WGPUQueueWorkDoneStatus_Success : constant WGPUQueueWorkDoneStatus := 1;
   WGPUQueueWorkDoneStatus_WGPUQueueWorkDoneStatus_InstanceDropped : constant WGPUQueueWorkDoneStatus := 2;
   WGPUQueueWorkDoneStatus_WGPUQueueWorkDoneStatus_Error : constant WGPUQueueWorkDoneStatus := 3;
   WGPUQueueWorkDoneStatus_WGPUQueueWorkDoneStatus_Unknown : constant WGPUQueueWorkDoneStatus := 4;
   WGPUQueueWorkDoneStatus_WGPUQueueWorkDoneStatus_Force32 : constant WGPUQueueWorkDoneStatus := 2147483647;  -- webgpu.h:703

   subtype WGPURequestAdapterStatus is unsigned;
   WGPURequestAdapterStatus_WGPURequestAdapterStatus_Success : constant WGPURequestAdapterStatus := 1;
   WGPURequestAdapterStatus_WGPURequestAdapterStatus_InstanceDropped : constant WGPURequestAdapterStatus := 2;
   WGPURequestAdapterStatus_WGPURequestAdapterStatus_Unavailable : constant WGPURequestAdapterStatus := 3;
   WGPURequestAdapterStatus_WGPURequestAdapterStatus_Error : constant WGPURequestAdapterStatus := 4;
   WGPURequestAdapterStatus_WGPURequestAdapterStatus_Unknown : constant WGPURequestAdapterStatus := 5;
   WGPURequestAdapterStatus_WGPURequestAdapterStatus_Force32 : constant WGPURequestAdapterStatus := 2147483647;  -- webgpu.h:711

   subtype WGPURequestDeviceStatus is unsigned;
   WGPURequestDeviceStatus_WGPURequestDeviceStatus_Success : constant WGPURequestDeviceStatus := 1;
   WGPURequestDeviceStatus_WGPURequestDeviceStatus_InstanceDropped : constant WGPURequestDeviceStatus := 2;
   WGPURequestDeviceStatus_WGPURequestDeviceStatus_Error : constant WGPURequestDeviceStatus := 3;
   WGPURequestDeviceStatus_WGPURequestDeviceStatus_Unknown : constant WGPURequestDeviceStatus := 4;
   WGPURequestDeviceStatus_WGPURequestDeviceStatus_Force32 : constant WGPURequestDeviceStatus := 2147483647;  -- webgpu.h:720

   subtype T_WGPUSType is unsigned;
   WGPUSType_WGPUSType_ShaderSourceSPIRV : constant T_WGPUSType := 1;
   WGPUSType_WGPUSType_ShaderSourceWGSL : constant T_WGPUSType := 2;
   WGPUSType_WGPUSType_RenderPassMaxDrawCount : constant T_WGPUSType := 3;
   WGPUSType_WGPUSType_SurfaceSourceMetalLayer : constant T_WGPUSType := 4;
   WGPUSType_WGPUSType_SurfaceSourceWindowsHWND : constant T_WGPUSType := 5;
   WGPUSType_WGPUSType_SurfaceSourceXlibWindow : constant T_WGPUSType := 6;
   WGPUSType_WGPUSType_SurfaceSourceWaylandSurface : constant T_WGPUSType := 7;
   WGPUSType_WGPUSType_SurfaceSourceAndroidNativeWindow : constant T_WGPUSType := 8;
   WGPUSType_WGPUSType_SurfaceSourceXCBWindow : constant T_WGPUSType := 9;
   WGPUSType_WGPUSType_Force32 : constant T_WGPUSType := 2147483647;  -- webgpu.h:728

   subtype WGPUSamplerBindingType is unsigned;
   WGPUSamplerBindingType_WGPUSamplerBindingType_BindingNotUsed : constant WGPUSamplerBindingType := 0;
   WGPUSamplerBindingType_WGPUSamplerBindingType_Undefined : constant WGPUSamplerBindingType := 1;
   WGPUSamplerBindingType_WGPUSamplerBindingType_Filtering : constant WGPUSamplerBindingType := 2;
   WGPUSamplerBindingType_WGPUSamplerBindingType_NonFiltering : constant WGPUSamplerBindingType := 3;
   WGPUSamplerBindingType_WGPUSamplerBindingType_Comparison : constant WGPUSamplerBindingType := 4;
   WGPUSamplerBindingType_WGPUSamplerBindingType_Force32 : constant WGPUSamplerBindingType := 2147483647;  -- webgpu.h:741

  --*
  --     * `0x00000000`.
  --     * Indicates that this @ref WGPUSamplerBindingLayout member of
  --     * its parent @ref WGPUBindGroupLayoutEntry is not used.
  --     * (See also @ref SentinelValues.)
  --

  --*
  --     * `0x00000001`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

  --*
  -- * Status code returned (synchronously) from many operations. Generally
  -- * indicates an invalid input like an unknown enum value or @ref OutStructChainError.
  -- * Read the function's documentation for specific error conditions.
  --

   subtype WGPUStatus is unsigned;
   WGPUStatus_WGPUStatus_Success : constant WGPUStatus := 1;
   WGPUStatus_WGPUStatus_Error : constant WGPUStatus := 2;
   WGPUStatus_WGPUStatus_Force32 : constant WGPUStatus := 2147483647;  -- webgpu.h:765

   subtype WGPUStencilOperation is unsigned;
   WGPUStencilOperation_WGPUStencilOperation_Undefined : constant WGPUStencilOperation := 0;
   WGPUStencilOperation_WGPUStencilOperation_Keep : constant WGPUStencilOperation := 1;
   WGPUStencilOperation_WGPUStencilOperation_Zero : constant WGPUStencilOperation := 2;
   WGPUStencilOperation_WGPUStencilOperation_Replace : constant WGPUStencilOperation := 3;
   WGPUStencilOperation_WGPUStencilOperation_Invert : constant WGPUStencilOperation := 4;
   WGPUStencilOperation_WGPUStencilOperation_IncrementClamp : constant WGPUStencilOperation := 5;
   WGPUStencilOperation_WGPUStencilOperation_DecrementClamp : constant WGPUStencilOperation := 6;
   WGPUStencilOperation_WGPUStencilOperation_IncrementWrap : constant WGPUStencilOperation := 7;
   WGPUStencilOperation_WGPUStencilOperation_DecrementWrap : constant WGPUStencilOperation := 8;
   WGPUStencilOperation_WGPUStencilOperation_Force32 : constant WGPUStencilOperation := 2147483647;  -- webgpu.h:771

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUStorageTextureAccess is unsigned;
   WGPUStorageTextureAccess_WGPUStorageTextureAccess_BindingNotUsed : constant WGPUStorageTextureAccess := 0;
   WGPUStorageTextureAccess_WGPUStorageTextureAccess_Undefined : constant WGPUStorageTextureAccess := 1;
   WGPUStorageTextureAccess_WGPUStorageTextureAccess_WriteOnly : constant WGPUStorageTextureAccess := 2;
   WGPUStorageTextureAccess_WGPUStorageTextureAccess_ReadOnly : constant WGPUStorageTextureAccess := 3;
   WGPUStorageTextureAccess_WGPUStorageTextureAccess_ReadWrite : constant WGPUStorageTextureAccess := 4;
   WGPUStorageTextureAccess_WGPUStorageTextureAccess_Force32 : constant WGPUStorageTextureAccess := 2147483647;  -- webgpu.h:788

  --*
  --     * `0x00000000`.
  --     * Indicates that this @ref WGPUStorageTextureBindingLayout member of
  --     * its parent @ref WGPUBindGroupLayoutEntry is not used.
  --     * (See also @ref SentinelValues.)
  --

  --*
  --     * `0x00000001`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUStoreOp is unsigned;
   WGPUStoreOp_WGPUStoreOp_Undefined : constant WGPUStoreOp := 0;
   WGPUStoreOp_WGPUStoreOp_Store : constant WGPUStoreOp := 1;
   WGPUStoreOp_WGPUStoreOp_Discard : constant WGPUStoreOp := 2;
   WGPUStoreOp_WGPUStoreOp_Force32 : constant WGPUStoreOp := 2147483647;  -- webgpu.h:807

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

  --*
  -- * The status enum for `::wgpuSurfaceGetCurrentTexture`.
  --

   subtype WGPUSurfaceGetCurrentTextureStatus is unsigned;
   WGPUSurfaceGetCurrentTextureStatus_WGPUSurfaceGetCurrentTextureStatus_SuccessOptimal : constant WGPUSurfaceGetCurrentTextureStatus := 1;
   WGPUSurfaceGetCurrentTextureStatus_WGPUSurfaceGetCurrentTextureStatus_SuccessSuboptimal : constant WGPUSurfaceGetCurrentTextureStatus := 2;
   WGPUSurfaceGetCurrentTextureStatus_WGPUSurfaceGetCurrentTextureStatus_Timeout : constant WGPUSurfaceGetCurrentTextureStatus := 3;
   WGPUSurfaceGetCurrentTextureStatus_WGPUSurfaceGetCurrentTextureStatus_Outdated : constant WGPUSurfaceGetCurrentTextureStatus := 4;
   WGPUSurfaceGetCurrentTextureStatus_WGPUSurfaceGetCurrentTextureStatus_Lost : constant WGPUSurfaceGetCurrentTextureStatus := 5;
   WGPUSurfaceGetCurrentTextureStatus_WGPUSurfaceGetCurrentTextureStatus_OutOfMemory : constant WGPUSurfaceGetCurrentTextureStatus := 6;
   WGPUSurfaceGetCurrentTextureStatus_WGPUSurfaceGetCurrentTextureStatus_DeviceLost : constant WGPUSurfaceGetCurrentTextureStatus := 7;
   WGPUSurfaceGetCurrentTextureStatus_WGPUSurfaceGetCurrentTextureStatus_Error : constant WGPUSurfaceGetCurrentTextureStatus := 8;
   WGPUSurfaceGetCurrentTextureStatus_WGPUSurfaceGetCurrentTextureStatus_Force32 : constant WGPUSurfaceGetCurrentTextureStatus := 2147483647;  -- webgpu.h:821

  --*
  --     * `0x00000001`.
  --     * Yay! Everything is good and we can render this frame.
  --

  --*
  --     * `0x00000002`.
  --     * Still OK - the surface can present the frame, but in a suboptimal way. The surface may need reconfiguration.
  --

  --*
  --     * `0x00000003`.
  --     * Some operation timed out while trying to acquire the frame.
  --

  --*
  --     * `0x00000004`.
  --     * The surface is too different to be used, compared to when it was originally created.
  --

  --*
  --     * `0x00000005`.
  --     * The connection to whatever owns the surface was lost.
  --

  --*
  --     * `0x00000006`.
  --     * The system ran out of memory.
  --

  --*
  --     * `0x00000007`.
  --     * The @ref WGPUDevice configured on the @ref WGPUSurface was lost.
  --

  --*
  --     * `0x00000008`.
  --     * The surface is not configured, or there was an @ref OutStructChainError.
  --

   subtype WGPUTextureAspect is unsigned;
   WGPUTextureAspect_WGPUTextureAspect_Undefined : constant WGPUTextureAspect := 0;
   WGPUTextureAspect_WGPUTextureAspect_All : constant WGPUTextureAspect := 1;
   WGPUTextureAspect_WGPUTextureAspect_StencilOnly : constant WGPUTextureAspect := 2;
   WGPUTextureAspect_WGPUTextureAspect_DepthOnly : constant WGPUTextureAspect := 3;
   WGPUTextureAspect_WGPUTextureAspect_Force32 : constant WGPUTextureAspect := 16#7FFFFFFF#;  -- webgpu.h:865

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUTextureDimension is unsigned;
   WGPUTextureDimension_WGPUTextureDimension_Undefined : constant WGPUTextureDimension := 0;
   WGPUTextureDimension_WGPUTextureDimension_1D : constant WGPUTextureDimension := 1;
   WGPUTextureDimension_WGPUTextureDimension_2D : constant WGPUTextureDimension := 2;
   WGPUTextureDimension_WGPUTextureDimension_3D : constant WGPUTextureDimension := 3;
   WGPUTextureDimension_WGPUTextureDimension_Force32 : constant WGPUTextureDimension := 2147483647;  -- webgpu.h:877

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUTextureFormat is unsigned;
   WGPUTextureFormat_WGPUTextureFormat_Undefined : constant WGPUTextureFormat := 0;
   WGPUTextureFormat_WGPUTextureFormat_R8Unorm : constant WGPUTextureFormat := 1;
   WGPUTextureFormat_WGPUTextureFormat_R8Snorm : constant WGPUTextureFormat := 2;
   WGPUTextureFormat_WGPUTextureFormat_R8Uint : constant WGPUTextureFormat := 3;
   WGPUTextureFormat_WGPUTextureFormat_R8Sint : constant WGPUTextureFormat := 4;
   WGPUTextureFormat_WGPUTextureFormat_R16Uint : constant WGPUTextureFormat := 5;
   WGPUTextureFormat_WGPUTextureFormat_R16Sint : constant WGPUTextureFormat := 6;
   WGPUTextureFormat_WGPUTextureFormat_R16Float : constant WGPUTextureFormat := 7;
   WGPUTextureFormat_WGPUTextureFormat_RG8Unorm : constant WGPUTextureFormat := 8;
   WGPUTextureFormat_WGPUTextureFormat_RG8Snorm : constant WGPUTextureFormat := 9;
   WGPUTextureFormat_WGPUTextureFormat_RG8Uint : constant WGPUTextureFormat := 10;
   WGPUTextureFormat_WGPUTextureFormat_RG8Sint : constant WGPUTextureFormat := 11;
   WGPUTextureFormat_WGPUTextureFormat_R32Float : constant WGPUTextureFormat := 12;
   WGPUTextureFormat_WGPUTextureFormat_R32Uint : constant WGPUTextureFormat := 13;
   WGPUTextureFormat_WGPUTextureFormat_R32Sint : constant WGPUTextureFormat := 14;
   WGPUTextureFormat_WGPUTextureFormat_RG16Uint : constant WGPUTextureFormat := 15;
   WGPUTextureFormat_WGPUTextureFormat_RG16Sint : constant WGPUTextureFormat := 16;
   WGPUTextureFormat_WGPUTextureFormat_RG16Float : constant WGPUTextureFormat := 17;
   WGPUTextureFormat_WGPUTextureFormat_RGBA8Unorm : constant WGPUTextureFormat := 18;
   WGPUTextureFormat_WGPUTextureFormat_RGBA8UnormSrgb : constant WGPUTextureFormat := 19;
   WGPUTextureFormat_WGPUTextureFormat_RGBA8Snorm : constant WGPUTextureFormat := 20;
   WGPUTextureFormat_WGPUTextureFormat_RGBA8Uint : constant WGPUTextureFormat := 21;
   WGPUTextureFormat_WGPUTextureFormat_RGBA8Sint : constant WGPUTextureFormat := 22;
   WGPUTextureFormat_WGPUTextureFormat_BGRA8Unorm : constant WGPUTextureFormat := 23;
   WGPUTextureFormat_WGPUTextureFormat_BGRA8UnormSrgb : constant WGPUTextureFormat := 24;
   WGPUTextureFormat_WGPUTextureFormat_RGB10A2Uint : constant WGPUTextureFormat := 25;
   WGPUTextureFormat_WGPUTextureFormat_RGB10A2Unorm : constant WGPUTextureFormat := 26;
   WGPUTextureFormat_WGPUTextureFormat_RG11B10Ufloat : constant WGPUTextureFormat := 27;
   WGPUTextureFormat_WGPUTextureFormat_RGB9E5Ufloat : constant WGPUTextureFormat := 28;
   WGPUTextureFormat_WGPUTextureFormat_RG32Float : constant WGPUTextureFormat := 29;
   WGPUTextureFormat_WGPUTextureFormat_RG32Uint : constant WGPUTextureFormat := 30;
   WGPUTextureFormat_WGPUTextureFormat_RG32Sint : constant WGPUTextureFormat := 31;
   WGPUTextureFormat_WGPUTextureFormat_RGBA16Uint : constant WGPUTextureFormat := 32;
   WGPUTextureFormat_WGPUTextureFormat_RGBA16Sint : constant WGPUTextureFormat := 33;
   WGPUTextureFormat_WGPUTextureFormat_RGBA16Float : constant WGPUTextureFormat := 34;
   WGPUTextureFormat_WGPUTextureFormat_RGBA32Float : constant WGPUTextureFormat := 35;
   WGPUTextureFormat_WGPUTextureFormat_RGBA32Uint : constant WGPUTextureFormat := 36;
   WGPUTextureFormat_WGPUTextureFormat_RGBA32Sint : constant WGPUTextureFormat := 37;
   WGPUTextureFormat_WGPUTextureFormat_Stencil8 : constant WGPUTextureFormat := 38;
   WGPUTextureFormat_WGPUTextureFormat_Depth16Unorm : constant WGPUTextureFormat := 39;
   WGPUTextureFormat_WGPUTextureFormat_Depth24Plus : constant WGPUTextureFormat := 40;
   WGPUTextureFormat_WGPUTextureFormat_Depth24PlusStencil8 : constant WGPUTextureFormat := 41;
   WGPUTextureFormat_WGPUTextureFormat_Depth32Float : constant WGPUTextureFormat := 42;
   WGPUTextureFormat_WGPUTextureFormat_Depth32FloatStencil8 : constant WGPUTextureFormat := 43;
   WGPUTextureFormat_WGPUTextureFormat_BC1RGBAUnorm : constant WGPUTextureFormat := 44;
   WGPUTextureFormat_WGPUTextureFormat_BC1RGBAUnormSrgb : constant WGPUTextureFormat := 45;
   WGPUTextureFormat_WGPUTextureFormat_BC2RGBAUnorm : constant WGPUTextureFormat := 46;
   WGPUTextureFormat_WGPUTextureFormat_BC2RGBAUnormSrgb : constant WGPUTextureFormat := 47;
   WGPUTextureFormat_WGPUTextureFormat_BC3RGBAUnorm : constant WGPUTextureFormat := 48;
   WGPUTextureFormat_WGPUTextureFormat_BC3RGBAUnormSrgb : constant WGPUTextureFormat := 49;
   WGPUTextureFormat_WGPUTextureFormat_BC4RUnorm : constant WGPUTextureFormat := 50;
   WGPUTextureFormat_WGPUTextureFormat_BC4RSnorm : constant WGPUTextureFormat := 51;
   WGPUTextureFormat_WGPUTextureFormat_BC5RGUnorm : constant WGPUTextureFormat := 52;
   WGPUTextureFormat_WGPUTextureFormat_BC5RGSnorm : constant WGPUTextureFormat := 53;
   WGPUTextureFormat_WGPUTextureFormat_BC6HRGBUfloat : constant WGPUTextureFormat := 54;
   WGPUTextureFormat_WGPUTextureFormat_BC6HRGBFloat : constant WGPUTextureFormat := 55;
   WGPUTextureFormat_WGPUTextureFormat_BC7RGBAUnorm : constant WGPUTextureFormat := 56;
   WGPUTextureFormat_WGPUTextureFormat_BC7RGBAUnormSrgb : constant WGPUTextureFormat := 57;
   WGPUTextureFormat_WGPUTextureFormat_ETC2RGB8Unorm : constant WGPUTextureFormat := 58;
   WGPUTextureFormat_WGPUTextureFormat_ETC2RGB8UnormSrgb : constant WGPUTextureFormat := 59;
   WGPUTextureFormat_WGPUTextureFormat_ETC2RGB8A1Unorm : constant WGPUTextureFormat := 60;
   WGPUTextureFormat_WGPUTextureFormat_ETC2RGB8A1UnormSrgb : constant WGPUTextureFormat := 61;
   WGPUTextureFormat_WGPUTextureFormat_ETC2RGBA8Unorm : constant WGPUTextureFormat := 62;
   WGPUTextureFormat_WGPUTextureFormat_ETC2RGBA8UnormSrgb : constant WGPUTextureFormat := 63;
   WGPUTextureFormat_WGPUTextureFormat_EACR11Unorm : constant WGPUTextureFormat := 64;
   WGPUTextureFormat_WGPUTextureFormat_EACR11Snorm : constant WGPUTextureFormat := 65;
   WGPUTextureFormat_WGPUTextureFormat_EACRG11Unorm : constant WGPUTextureFormat := 66;
   WGPUTextureFormat_WGPUTextureFormat_EACRG11Snorm : constant WGPUTextureFormat := 67;
   WGPUTextureFormat_WGPUTextureFormat_ASTC4x4Unorm : constant WGPUTextureFormat := 68;
   WGPUTextureFormat_WGPUTextureFormat_ASTC4x4UnormSrgb : constant WGPUTextureFormat := 69;
   WGPUTextureFormat_WGPUTextureFormat_ASTC5x4Unorm : constant WGPUTextureFormat := 70;
   WGPUTextureFormat_WGPUTextureFormat_ASTC5x4UnormSrgb : constant WGPUTextureFormat := 71;
   WGPUTextureFormat_WGPUTextureFormat_ASTC5x5Unorm : constant WGPUTextureFormat := 72;
   WGPUTextureFormat_WGPUTextureFormat_ASTC5x5UnormSrgb : constant WGPUTextureFormat := 73;
   WGPUTextureFormat_WGPUTextureFormat_ASTC6x5Unorm : constant WGPUTextureFormat := 74;
   WGPUTextureFormat_WGPUTextureFormat_ASTC6x5UnormSrgb : constant WGPUTextureFormat := 75;
   WGPUTextureFormat_WGPUTextureFormat_ASTC6x6Unorm : constant WGPUTextureFormat := 76;
   WGPUTextureFormat_WGPUTextureFormat_ASTC6x6UnormSrgb : constant WGPUTextureFormat := 77;
   WGPUTextureFormat_WGPUTextureFormat_ASTC8x5Unorm : constant WGPUTextureFormat := 78;
   WGPUTextureFormat_WGPUTextureFormat_ASTC8x5UnormSrgb : constant WGPUTextureFormat := 79;
   WGPUTextureFormat_WGPUTextureFormat_ASTC8x6Unorm : constant WGPUTextureFormat := 80;
   WGPUTextureFormat_WGPUTextureFormat_ASTC8x6UnormSrgb : constant WGPUTextureFormat := 81;
   WGPUTextureFormat_WGPUTextureFormat_ASTC8x8Unorm : constant WGPUTextureFormat := 82;
   WGPUTextureFormat_WGPUTextureFormat_ASTC8x8UnormSrgb : constant WGPUTextureFormat := 83;
   WGPUTextureFormat_WGPUTextureFormat_ASTC10x5Unorm : constant WGPUTextureFormat := 84;
   WGPUTextureFormat_WGPUTextureFormat_ASTC10x5UnormSrgb : constant WGPUTextureFormat := 85;
   WGPUTextureFormat_WGPUTextureFormat_ASTC10x6Unorm : constant WGPUTextureFormat := 86;
   WGPUTextureFormat_WGPUTextureFormat_ASTC10x6UnormSrgb : constant WGPUTextureFormat := 87;
   WGPUTextureFormat_WGPUTextureFormat_ASTC10x8Unorm : constant WGPUTextureFormat := 88;
   WGPUTextureFormat_WGPUTextureFormat_ASTC10x8UnormSrgb : constant WGPUTextureFormat := 89;
   WGPUTextureFormat_WGPUTextureFormat_ASTC10x10Unorm : constant WGPUTextureFormat := 90;
   WGPUTextureFormat_WGPUTextureFormat_ASTC10x10UnormSrgb : constant WGPUTextureFormat := 91;
   WGPUTextureFormat_WGPUTextureFormat_ASTC12x10Unorm : constant WGPUTextureFormat := 92;
   WGPUTextureFormat_WGPUTextureFormat_ASTC12x10UnormSrgb : constant WGPUTextureFormat := 93;
   WGPUTextureFormat_WGPUTextureFormat_ASTC12x12Unorm : constant WGPUTextureFormat := 94;
   WGPUTextureFormat_WGPUTextureFormat_ASTC12x12UnormSrgb : constant WGPUTextureFormat := 95;
   WGPUTextureFormat_WGPUTextureFormat_Force32 : constant WGPUTextureFormat := 2147483647;  -- webgpu.h:889

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUTextureSampleType is unsigned;
   WGPUTextureSampleType_WGPUTextureSampleType_BindingNotUsed : constant WGPUTextureSampleType := 0;
   WGPUTextureSampleType_WGPUTextureSampleType_Undefined : constant WGPUTextureSampleType := 1;
   WGPUTextureSampleType_WGPUTextureSampleType_Float : constant WGPUTextureSampleType := 2;
   WGPUTextureSampleType_WGPUTextureSampleType_UnfilterableFloat : constant WGPUTextureSampleType := 3;
   WGPUTextureSampleType_WGPUTextureSampleType_Depth : constant WGPUTextureSampleType := 4;
   WGPUTextureSampleType_WGPUTextureSampleType_Sint : constant WGPUTextureSampleType := 5;
   WGPUTextureSampleType_WGPUTextureSampleType_Uint : constant WGPUTextureSampleType := 6;
   WGPUTextureSampleType_WGPUTextureSampleType_Force32 : constant WGPUTextureSampleType := 2147483647;  -- webgpu.h:993

  --*
  --     * `0x00000000`.
  --     * Indicates that this @ref WGPUTextureBindingLayout member of
  --     * its parent @ref WGPUBindGroupLayoutEntry is not used.
  --     * (See also @ref SentinelValues.)
  --

  --*
  --     * `0x00000001`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUTextureViewDimension is unsigned;
   WGPUTextureViewDimension_WGPUTextureViewDimension_Undefined : constant WGPUTextureViewDimension := 0;
   WGPUTextureViewDimension_WGPUTextureViewDimension_1D : constant WGPUTextureViewDimension := 1;
   WGPUTextureViewDimension_WGPUTextureViewDimension_2D : constant WGPUTextureViewDimension := 2;
   WGPUTextureViewDimension_WGPUTextureViewDimension_2DArray : constant WGPUTextureViewDimension := 3;
   WGPUTextureViewDimension_WGPUTextureViewDimension_Cube : constant WGPUTextureViewDimension := 4;
   WGPUTextureViewDimension_WGPUTextureViewDimension_CubeArray : constant WGPUTextureViewDimension := 5;
   WGPUTextureViewDimension_WGPUTextureViewDimension_3D : constant WGPUTextureViewDimension := 6;
   WGPUTextureViewDimension_WGPUTextureViewDimension_Force32 : constant WGPUTextureViewDimension := 2147483647;  -- webgpu.h:1014

  --*
  --     * `0x00000000`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUVertexFormat is unsigned;
   WGPUVertexFormat_WGPUVertexFormat_Uint8 : constant WGPUVertexFormat := 1;
   WGPUVertexFormat_WGPUVertexFormat_Uint8x2 : constant WGPUVertexFormat := 2;
   WGPUVertexFormat_WGPUVertexFormat_Uint8x4 : constant WGPUVertexFormat := 3;
   WGPUVertexFormat_WGPUVertexFormat_Sint8 : constant WGPUVertexFormat := 4;
   WGPUVertexFormat_WGPUVertexFormat_Sint8x2 : constant WGPUVertexFormat := 5;
   WGPUVertexFormat_WGPUVertexFormat_Sint8x4 : constant WGPUVertexFormat := 6;
   WGPUVertexFormat_WGPUVertexFormat_Unorm8 : constant WGPUVertexFormat := 7;
   WGPUVertexFormat_WGPUVertexFormat_Unorm8x2 : constant WGPUVertexFormat := 8;
   WGPUVertexFormat_WGPUVertexFormat_Unorm8x4 : constant WGPUVertexFormat := 9;
   WGPUVertexFormat_WGPUVertexFormat_Snorm8 : constant WGPUVertexFormat := 10;
   WGPUVertexFormat_WGPUVertexFormat_Snorm8x2 : constant WGPUVertexFormat := 11;
   WGPUVertexFormat_WGPUVertexFormat_Snorm8x4 : constant WGPUVertexFormat := 12;
   WGPUVertexFormat_WGPUVertexFormat_Uint16 : constant WGPUVertexFormat := 13;
   WGPUVertexFormat_WGPUVertexFormat_Uint16x2 : constant WGPUVertexFormat := 14;
   WGPUVertexFormat_WGPUVertexFormat_Uint16x4 : constant WGPUVertexFormat := 15;
   WGPUVertexFormat_WGPUVertexFormat_Sint16 : constant WGPUVertexFormat := 16;
   WGPUVertexFormat_WGPUVertexFormat_Sint16x2 : constant WGPUVertexFormat := 17;
   WGPUVertexFormat_WGPUVertexFormat_Sint16x4 : constant WGPUVertexFormat := 18;
   WGPUVertexFormat_WGPUVertexFormat_Unorm16 : constant WGPUVertexFormat := 19;
   WGPUVertexFormat_WGPUVertexFormat_Unorm16x2 : constant WGPUVertexFormat := 20;
   WGPUVertexFormat_WGPUVertexFormat_Unorm16x4 : constant WGPUVertexFormat := 21;
   WGPUVertexFormat_WGPUVertexFormat_Snorm16 : constant WGPUVertexFormat := 22;
   WGPUVertexFormat_WGPUVertexFormat_Snorm16x2 : constant WGPUVertexFormat := 23;
   WGPUVertexFormat_WGPUVertexFormat_Snorm16x4 : constant WGPUVertexFormat := 24;
   WGPUVertexFormat_WGPUVertexFormat_Float16 : constant WGPUVertexFormat := 25;
   WGPUVertexFormat_WGPUVertexFormat_Float16x2 : constant WGPUVertexFormat := 26;
   WGPUVertexFormat_WGPUVertexFormat_Float16x4 : constant WGPUVertexFormat := 27;
   WGPUVertexFormat_WGPUVertexFormat_Float32 : constant WGPUVertexFormat := 28;
   WGPUVertexFormat_WGPUVertexFormat_Float32x2 : constant WGPUVertexFormat := 29;
   WGPUVertexFormat_WGPUVertexFormat_Float32x3 : constant WGPUVertexFormat := 30;
   WGPUVertexFormat_WGPUVertexFormat_Float32x4 : constant WGPUVertexFormat := 31;
   WGPUVertexFormat_WGPUVertexFormat_Uint32 : constant WGPUVertexFormat := 32;
   WGPUVertexFormat_WGPUVertexFormat_Uint32x2 : constant WGPUVertexFormat := 33;
   WGPUVertexFormat_WGPUVertexFormat_Uint32x3 : constant WGPUVertexFormat := 34;
   WGPUVertexFormat_WGPUVertexFormat_Uint32x4 : constant WGPUVertexFormat := 35;
   WGPUVertexFormat_WGPUVertexFormat_Sint32 : constant WGPUVertexFormat := 36;
   WGPUVertexFormat_WGPUVertexFormat_Sint32x2 : constant WGPUVertexFormat := 37;
   WGPUVertexFormat_WGPUVertexFormat_Sint32x3 : constant WGPUVertexFormat := 38;
   WGPUVertexFormat_WGPUVertexFormat_Sint32x4 : constant WGPUVertexFormat := 39;
   WGPUVertexFormat_WGPUVertexFormat_Unorm10_10_10_2 : constant WGPUVertexFormat := 40;
   WGPUVertexFormat_WGPUVertexFormat_Unorm8x4BGRA : constant WGPUVertexFormat := 41;
   WGPUVertexFormat_WGPUVertexFormat_Force32 : constant WGPUVertexFormat := 2147483647;  -- webgpu.h:1029

   subtype WGPUVertexStepMode is unsigned;
   WGPUVertexStepMode_WGPUVertexStepMode_VertexBufferNotUsed : constant WGPUVertexStepMode := 0;
   WGPUVertexStepMode_WGPUVertexStepMode_Undefined : constant WGPUVertexStepMode := 1;
   WGPUVertexStepMode_WGPUVertexStepMode_Vertex : constant WGPUVertexStepMode := 2;
   WGPUVertexStepMode_WGPUVertexStepMode_Instance : constant WGPUVertexStepMode := 3;
   WGPUVertexStepMode_WGPUVertexStepMode_Force32 : constant WGPUVertexStepMode := 2147483647;  -- webgpu.h:1074

  --*
  --     * `0x00000000`.
  --     * This @ref WGPUVertexBufferLayout is a "hole" in the @ref WGPUVertexState `buffers` array.
  --     * (See also @ref SentinelValues.)
  --

  --*
  --     * `0x00000001`.
  --     * Indicates no value is passed for this argument. See @ref SentinelValues.
  --

   subtype WGPUWGSLLanguageFeatureName is unsigned;
   WGPUWGSLLanguageFeatureName_WGPUWGSLLanguageFeatureName_ReadonlyAndReadwriteStorageTextures : constant WGPUWGSLLanguageFeatureName := 1;
   WGPUWGSLLanguageFeatureName_WGPUWGSLLanguageFeatureName_Packed4x8IntegerDotProduct : constant WGPUWGSLLanguageFeatureName := 2;
   WGPUWGSLLanguageFeatureName_WGPUWGSLLanguageFeatureName_UnrestrictedPointerParameters : constant WGPUWGSLLanguageFeatureName := 3;
   WGPUWGSLLanguageFeatureName_WGPUWGSLLanguageFeatureName_PointerCompositeAccess : constant WGPUWGSLLanguageFeatureName := 4;
   WGPUWGSLLanguageFeatureName_WGPUWGSLLanguageFeatureName_Force32 : constant WGPUWGSLLanguageFeatureName := 2147483647;  -- webgpu.h:1091

  --*
  -- * Status returned from a call to ::wgpuInstanceWaitAny.
  --

   subtype WGPUWaitStatus is unsigned;
   WGPUWaitStatus_WGPUWaitStatus_Success : constant WGPUWaitStatus := 1;
   WGPUWaitStatus_WGPUWaitStatus_TimedOut : constant WGPUWaitStatus := 2;
   WGPUWaitStatus_WGPUWaitStatus_UnsupportedTimeout : constant WGPUWaitStatus := 3;
   WGPUWaitStatus_WGPUWaitStatus_UnsupportedCount : constant WGPUWaitStatus := 4;
   WGPUWaitStatus_WGPUWaitStatus_UnsupportedMixedSources : constant WGPUWaitStatus := 5;
   WGPUWaitStatus_WGPUWaitStatus_Force32 : constant WGPUWaitStatus := 2147483647;  -- webgpu.h:1102

  --*
  --     * `0x00000001`.
  --     * At least one WGPUFuture completed successfully.
  --

  --*
  --     * `0x00000002`.
  --     * No WGPUFutures completed within the timeout.
  --

  --*
  --     * `0x00000003`.
  --     * A @ref Timed-Wait was performed when WGPUInstanceFeatures::timedWaitAnyEnable is false.
  --

  --*
  --     * `0x00000004`.
  --     * The number of futures waited on in a @ref Timed-Wait is greater than the supported WGPUInstanceFeatures::timedWaitAnyMaxCount.
  --

  --*
  --     * `0x00000005`.
  --     * An invalid wait was performed with @ref Mixed-Sources.
  --

  --* @}
  --*
  -- * \defgroup Bitflags
  -- * \brief Type and constant definitions for bitflag types.
  -- *
  -- * @{
  --

   subtype WGPUBufferUsage is WGPUFlags;  -- webgpu.h:1140

   WGPUBufferUsage_None : aliased constant WGPUBufferUsage  -- webgpu.h:1141
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL20WGPUBufferUsage_None";

   WGPUBufferUsage_MapRead : aliased constant WGPUBufferUsage  -- webgpu.h:1142
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL23WGPUBufferUsage_MapRead";

   WGPUBufferUsage_MapWrite : aliased constant WGPUBufferUsage  -- webgpu.h:1143
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL24WGPUBufferUsage_MapWrite";

   WGPUBufferUsage_CopySrc : aliased constant WGPUBufferUsage  -- webgpu.h:1144
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL23WGPUBufferUsage_CopySrc";

   WGPUBufferUsage_CopyDst : aliased constant WGPUBufferUsage  -- webgpu.h:1145
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL23WGPUBufferUsage_CopyDst";

   WGPUBufferUsage_Index : aliased constant WGPUBufferUsage  -- webgpu.h:1146
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL21WGPUBufferUsage_Index";

   WGPUBufferUsage_Vertex : aliased constant WGPUBufferUsage  -- webgpu.h:1147
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL22WGPUBufferUsage_Vertex";

   WGPUBufferUsage_Uniform : aliased constant WGPUBufferUsage  -- webgpu.h:1148
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL23WGPUBufferUsage_Uniform";

   WGPUBufferUsage_Storage : aliased constant WGPUBufferUsage  -- webgpu.h:1149
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL23WGPUBufferUsage_Storage";

   WGPUBufferUsage_Indirect : aliased constant WGPUBufferUsage  -- webgpu.h:1150
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL24WGPUBufferUsage_Indirect";

   WGPUBufferUsage_QueryResolve : aliased constant WGPUBufferUsage  -- webgpu.h:1151
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL28WGPUBufferUsage_QueryResolve";

   subtype WGPUColorWriteMask is WGPUFlags;  -- webgpu.h:1153

   WGPUColorWriteMask_None : aliased constant WGPUColorWriteMask  -- webgpu.h:1154
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL23WGPUColorWriteMask_None";

   WGPUColorWriteMask_Red : aliased constant WGPUColorWriteMask  -- webgpu.h:1155
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL22WGPUColorWriteMask_Red";

   WGPUColorWriteMask_Green : aliased constant WGPUColorWriteMask  -- webgpu.h:1156
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL24WGPUColorWriteMask_Green";

   WGPUColorWriteMask_Blue : aliased constant WGPUColorWriteMask  -- webgpu.h:1157
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL23WGPUColorWriteMask_Blue";

   WGPUColorWriteMask_Alpha : aliased constant WGPUColorWriteMask  -- webgpu.h:1158
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL24WGPUColorWriteMask_Alpha";

  -- Red | Green | Blue | Alpha
   WGPUColorWriteMask_All : aliased constant WGPUColorWriteMask  -- webgpu.h:1159
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL22WGPUColorWriteMask_All";

   subtype WGPUMapMode is WGPUFlags;  -- webgpu.h:1161

   WGPUMapMode_None : aliased constant WGPUMapMode  -- webgpu.h:1162
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL16WGPUMapMode_None";

   WGPUMapMode_Read : aliased constant WGPUMapMode  -- webgpu.h:1163
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL16WGPUMapMode_Read";

   WGPUMapMode_Write : aliased constant WGPUMapMode  -- webgpu.h:1164
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL17WGPUMapMode_Write";

   subtype WGPUShaderStage is WGPUFlags;  -- webgpu.h:1166

   WGPUShaderStage_None : aliased constant WGPUShaderStage  -- webgpu.h:1167
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL20WGPUShaderStage_None";

   WGPUShaderStage_Vertex : aliased constant WGPUShaderStage  -- webgpu.h:1168
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL22WGPUShaderStage_Vertex";

   WGPUShaderStage_Fragment : aliased constant WGPUShaderStage  -- webgpu.h:1169
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL24WGPUShaderStage_Fragment";

   WGPUShaderStage_Compute : aliased constant WGPUShaderStage  -- webgpu.h:1170
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL23WGPUShaderStage_Compute";

   subtype WGPUTextureUsage is WGPUFlags;  -- webgpu.h:1172

   WGPUTextureUsage_None : aliased constant WGPUTextureUsage  -- webgpu.h:1173
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL21WGPUTextureUsage_None";

   WGPUTextureUsage_CopySrc : aliased constant WGPUTextureUsage  -- webgpu.h:1174
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL24WGPUTextureUsage_CopySrc";

   WGPUTextureUsage_CopyDst : aliased constant WGPUTextureUsage  -- webgpu.h:1175
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL24WGPUTextureUsage_CopyDst";

   WGPUTextureUsage_TextureBinding : aliased constant WGPUTextureUsage  -- webgpu.h:1176
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL31WGPUTextureUsage_TextureBinding";

   WGPUTextureUsage_StorageBinding : aliased constant WGPUTextureUsage  -- webgpu.h:1177
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL31WGPUTextureUsage_StorageBinding";

   WGPUTextureUsage_RenderAttachment : aliased constant WGPUTextureUsage  -- webgpu.h:1178
   with Import => True,
        Convention => CPP,
        External_Name => "_ZL33WGPUTextureUsage_RenderAttachment";

  --* @}
   type WGPUProc is access procedure
   with Convention => C;  -- webgpu.h:1182

  --*
  -- * \defgroup Callbacks
  -- * \brief Callbacks through which asynchronous functions return.
  -- *
  -- * @{
  --

  --*
  -- * @param message
  -- * This parameter is @ref PassedWithoutOwnership.
  --

   type WGPUBufferMapCallback is access procedure
        (arg1 : WGPUMapAsyncStatus;
         arg2 : WGPUStringView;
         arg3 : System.Address;
         arg4 : System.Address)
   with Convention => C;  -- webgpu.h:1195

  --*
  -- * @param compilationInfo
  -- * This parameter is @ref PassedWithoutOwnership.
  --

   type WGPUCompilationInfo;
   type WGPUCompilationInfoCallback is access procedure
        (arg1 : WGPUCompilationInfoRequestStatus;
         arg2 : access constant WGPUCompilationInfo;
         arg3 : System.Address;
         arg4 : System.Address)
   with Convention => C;  -- webgpu.h:1200

  --*
  -- * @param pipeline
  -- * This parameter is @ref PassedWithOwnership.
  --

   type WGPUCreateComputePipelineAsyncCallback is access procedure
        (arg1 : WGPUCreatePipelineAsyncStatus;
         arg2 : WGPUComputePipeline;
         arg3 : WGPUStringView;
         arg4 : System.Address;
         arg5 : System.Address)
   with Convention => C;  -- webgpu.h:1205

  --*
  -- * @param pipeline
  -- * This parameter is @ref PassedWithOwnership.
  --

   type WGPUCreateRenderPipelineAsyncCallback is access procedure
        (arg1 : WGPUCreatePipelineAsyncStatus;
         arg2 : WGPURenderPipeline;
         arg3 : WGPUStringView;
         arg4 : System.Address;
         arg5 : System.Address)
   with Convention => C;  -- webgpu.h:1210

  --*
  -- * @param device
  -- * Reference to the device which was lost. If, and only if, the `reason` is @ref WGPUDeviceLostReason_FailedCreation, this is a non-null pointer to a null @ref WGPUDevice.
  -- * This parameter is @ref PassedWithoutOwnership.
  -- *
  -- * @param message
  -- * This parameter is @ref PassedWithoutOwnership.
  --

   type WGPUDeviceLostCallback is access procedure
        (arg1 : System.Address;
         arg2 : WGPUDeviceLostReason;
         arg3 : WGPUStringView;
         arg4 : System.Address;
         arg5 : System.Address)
   with Convention => C;  -- webgpu.h:1219

  --*
  -- * @param status
  -- * See @ref WGPUPopErrorScopeStatus.
  -- *
  -- * @param type
  -- * The type of the error caught by the scope, or @ref WGPUErrorType_NoError if there was none.
  -- * If the `status` is not @ref WGPUPopErrorScopeStatus_Success, this is @ref WGPUErrorType_NoError.
  -- *
  -- * @param message
  -- * If the `type` is not @ref WGPUErrorType_NoError, this is a non-empty @ref LocalizableHumanReadableMessageString;
  -- * otherwise, this is an empty string.
  -- * This parameter is @ref PassedWithoutOwnership.
  --

   type WGPUPopErrorScopeCallback is access procedure
        (arg1 : WGPUPopErrorScopeStatus;
         arg2 : WGPUErrorType;
         arg3 : WGPUStringView;
         arg4 : System.Address;
         arg5 : System.Address)
   with Convention => C;  -- webgpu.h:1233

   type WGPUQueueWorkDoneCallback is access procedure
        (arg1 : WGPUQueueWorkDoneStatus;
         arg2 : System.Address;
         arg3 : System.Address)
   with Convention => C;  -- webgpu.h:1234

  --*
  -- * @param adapter
  -- * This parameter is @ref PassedWithOwnership.
  -- *
  -- * @param message
  -- * This parameter is @ref PassedWithoutOwnership.
  --

   type WGPURequestAdapterCallback is access procedure
        (arg1 : WGPURequestAdapterStatus;
         arg2 : WGPUAdapter;
         arg3 : WGPUStringView;
         arg4 : System.Address;
         arg5 : System.Address)
   with Convention => C;  -- webgpu.h:1242

  --*
  -- * @param device
  -- * This parameter is @ref PassedWithOwnership.
  -- *
  -- * @param message
  -- * This parameter is @ref PassedWithoutOwnership.
  --

   type WGPURequestDeviceCallback is access procedure
        (arg1 : WGPURequestDeviceStatus;
         arg2 : WGPUDevice;
         arg3 : WGPUStringView;
         arg4 : System.Address;
         arg5 : System.Address)
   with Convention => C;  -- webgpu.h:1250

  --*
  -- * @param device
  -- * This parameter is @ref PassedWithoutOwnership.
  -- *
  -- * @param message
  -- * This parameter is @ref PassedWithoutOwnership.
  --

   type WGPUUncapturedErrorCallback is access procedure
        (arg1 : System.Address;
         arg2 : WGPUErrorType;
         arg3 : WGPUStringView;
         arg4 : System.Address;
         arg5 : System.Address)
   with Convention => C;  -- webgpu.h:1258

  --* @}
  --*
  -- * \defgroup ChainedStructures Chained Structures
  -- * \brief Structures used to extend descriptors.
  -- *
  -- * @{
  --

	type T_WGPUChainedStruct;
	type T_WGPUChainedStruct is record
		next  : access constant T_WGPUChainedStruct;  -- webgpu.h:1269
		sType : aliased T_WGPUSType;  -- webgpu.h:1270
	end record
	with Convention => C_Pass_By_Copy;  -- webgpu.h:1268

   type T_WGPUChainedStructOut;
   type T_WGPUChainedStructOut is record
      next : access T_WGPUChainedStructOut;  -- webgpu.h:1274
      sType : aliased T_WGPUSType;  -- webgpu.h:1275
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1273

  --* @}
  --*
  -- * \defgroup Structures
  -- * \brief Descriptors and other transparent structures.
  -- *
  -- * @{
  --

  --*
  -- * \defgroup WGPUCallbackInfo
  -- * \brief Callback info structures that are used in asynchronous functions.
  -- *
  -- * @{
  --

   type WGPUBufferMapCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1295
      mode : aliased WGPUCallbackMode;  -- webgpu.h:1296
      callback : WGPUBufferMapCallback;  -- webgpu.h:1297
      userdata1 : System.Address;  -- webgpu.h:1298
      userdata2 : System.Address;  -- webgpu.h:1299
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1294

   type WGPUCompilationInfoCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1303
      mode : aliased WGPUCallbackMode;  -- webgpu.h:1304
      callback : WGPUCompilationInfoCallback;  -- webgpu.h:1305
      userdata1 : System.Address;  -- webgpu.h:1306
      userdata2 : System.Address;  -- webgpu.h:1307
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1302

   type WGPUCreateComputePipelineAsyncCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1311
      mode : aliased WGPUCallbackMode;  -- webgpu.h:1312
      callback : WGPUCreateComputePipelineAsyncCallback;  -- webgpu.h:1313
      userdata1 : System.Address;  -- webgpu.h:1314
      userdata2 : System.Address;  -- webgpu.h:1315
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1310

   type WGPUCreateRenderPipelineAsyncCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1319
      mode : aliased WGPUCallbackMode;  -- webgpu.h:1320
      callback : WGPUCreateRenderPipelineAsyncCallback;  -- webgpu.h:1321
      userdata1 : System.Address;  -- webgpu.h:1322
      userdata2 : System.Address;  -- webgpu.h:1323
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1318

   type WGPUDeviceLostCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1327
      mode : aliased WGPUCallbackMode;  -- webgpu.h:1328
      callback : WGPUDeviceLostCallback;  -- webgpu.h:1329
      userdata1 : System.Address;  -- webgpu.h:1330
      userdata2 : System.Address;  -- webgpu.h:1331
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1326

   type WGPUPopErrorScopeCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1335
      mode : aliased WGPUCallbackMode;  -- webgpu.h:1336
      callback : WGPUPopErrorScopeCallback;  -- webgpu.h:1337
      userdata1 : System.Address;  -- webgpu.h:1338
      userdata2 : System.Address;  -- webgpu.h:1339
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1334

   type WGPUQueueWorkDoneCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1343
      mode : aliased WGPUCallbackMode;  -- webgpu.h:1344
      callback : WGPUQueueWorkDoneCallback;  -- webgpu.h:1345
      userdata1 : System.Address;  -- webgpu.h:1346
      userdata2 : System.Address;  -- webgpu.h:1347
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1342

   type WGPURequestAdapterCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1351
      mode : aliased WGPUCallbackMode;  -- webgpu.h:1352
      callback : WGPURequestAdapterCallback;  -- webgpu.h:1353
      userdata1 : System.Address;  -- webgpu.h:1354
      userdata2 : System.Address;  -- webgpu.h:1355
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1350

   type WGPURequestDeviceCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1359
      mode : aliased WGPUCallbackMode;  -- webgpu.h:1360
      callback : WGPURequestDeviceCallback;  -- webgpu.h:1361
      userdata1 : System.Address;  -- webgpu.h:1362
      userdata2 : System.Address;  -- webgpu.h:1363
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1358

   type WGPUUncapturedErrorCallbackInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1367
      callback : WGPUUncapturedErrorCallback;  -- webgpu.h:1368
      userdata1 : System.Address;  -- webgpu.h:1369
      userdata2 : System.Address;  -- webgpu.h:1370
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1366

  --* @}
   type WGPUAdapterInfo is record
      nextInChain : access T_WGPUChainedStructOut;  -- webgpu.h:1376
      vendor : aliased WGPUStringView;  -- webgpu.h:1380
      architecture : aliased WGPUStringView;  -- webgpu.h:1384
      device : aliased WGPUStringView;  -- webgpu.h:1388
      description : aliased WGPUStringView;  -- webgpu.h:1392
      backendType : aliased WGPUBackendType;  -- webgpu.h:1393
      adapterType : aliased WGPUAdapterType;  -- webgpu.h:1394
      vendorID : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1395
      deviceID : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1396
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1375

  --*
  --     * This is an \ref OutputString.
  --

  --*
  --     * This is an \ref OutputString.
  --

  --*
  --     * This is an \ref OutputString.
  --

  --*
  --     * This is an \ref OutputString.
  --

   type WGPUBindGroupEntry is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1400
      binding : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1401
      buffer : WGPUBuffer;  -- webgpu.h:1402
      offset : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1403
      size : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1404
      sampler : WGPUSampler;  -- webgpu.h:1405
      textureView : WGPUTextureView;  -- webgpu.h:1406
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1399

   type WGPUBlendComponent is record
      operation : aliased WGPUBlendOperation;  -- webgpu.h:1410
      srcFactor : aliased WGPUBlendFactor;  -- webgpu.h:1411
      dstFactor : aliased WGPUBlendFactor;  -- webgpu.h:1412
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1409

   type WGPUBufferBindingLayout is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1416
      c_type : aliased WGPUBufferBindingType;  -- webgpu.h:1417
      hasDynamicOffset : aliased T_WGPUBool;  -- webgpu.h:1418
      minBindingSize : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1419
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1415

   type WGPUBufferDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1423
      label : aliased WGPUStringView;  -- webgpu.h:1427
      usage : aliased WGPUBufferUsage;  -- webgpu.h:1428
      size : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1429
      mappedAtCreation : aliased T_WGPUBool;  -- webgpu.h:1430
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1422

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUColor is record
      r : aliased double;  -- webgpu.h:1434
      g : aliased double;  -- webgpu.h:1435
      b : aliased double;  -- webgpu.h:1436
      a : aliased double;  -- webgpu.h:1437
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1433

   type WGPUCommandBufferDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1441
      label : aliased WGPUStringView;  -- webgpu.h:1445
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1440

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUCommandEncoderDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1449
      label : aliased WGPUStringView;  -- webgpu.h:1453
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1448

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUCompilationMessage is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1457
      message : aliased WGPUStringView;  -- webgpu.h:1463
      c_type : aliased WGPUCompilationMessageType;  -- webgpu.h:1467
      lineNum : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1471
      linePos : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1475
      offset : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1479
      length : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1483
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1456

  --*
  --     * A @ref LocalizableHumanReadableMessageString.
  --     *
  --     * This is an \ref OutputString.
  --

  --*
  --     * Severity level of the message.
  --

  --*
  --     * Line number where the message is attached, starting at 1.
  --

  --*
  --     * Offset in UTF-8 code units (bytes) from the beginning of the line, starting at 1.
  --

  --*
  --     * Offset in UTF-8 code units (bytes) from the beginning of the shader code, starting at 0.
  --

  --*
  --     * Length in UTF-8 code units (bytes) of the span the message corresponds to.
  --

   type WGPUComputePassTimestampWrites is record
      querySet : WGPUQuerySet;  -- webgpu.h:1487
      beginningOfPassWriteIndex : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1488
      endOfPassWriteIndex : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1489
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1486

   type WGPUConstantEntry is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1493
      key : aliased WGPUStringView;  -- webgpu.h:1497
      value : aliased double;  -- webgpu.h:1498
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1492

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUExtent3D is record
      width : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1502
      height : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1503
      depthOrArrayLayers : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1504
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1501

  --*
  -- * Opaque handle to an asynchronous operation. See @ref Asynchronous-Operations for more information.
  --

  --*
  --     * Opaque id of the @ref WGPUFuture
  --

   type WGPUFuture is record
      id : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1514
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1510

  --*
  -- * Features enabled on the T_WGPUInstance
  --

	--* This struct chain is used as mutable in some places and immutable in others.
	type T_WGPUInstanceCapabilities is record
		nextInChain          : access T_WGPUChainedStructOut;  -- webgpu.h:1522
		timedWaitAnyEnable   : aliased T_WGPUBool;  -- webgpu.h:1526
		timedWaitAnyMaxCount : aliased T_Size;  -- webgpu.h:1530
	end record
	with Convention => C_Pass_By_Copy;  -- webgpu.h:1520

  --*
  --     * Enable use of ::wgpuInstanceWaitAny with `timeoutNS > 0`.
  --

  --*
  --     * The maximum number @ref WGPUFutureWaitInfo supported in a call to ::wgpuInstanceWaitAny with `timeoutNS > 0`.
  --

  --* This struct chain is used as mutable in some places and immutable in others.
   type WGPULimits is record
      nextInChain : access T_WGPUChainedStructOut;  -- webgpu.h:1535
      maxTextureDimension1D : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1536
      maxTextureDimension2D : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1537
      maxTextureDimension3D : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1538
      maxTextureArrayLayers : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1539
      maxBindGroups : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1540
      maxBindGroupsPlusVertexBuffers : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1541
      maxBindingsPerBindGroup : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1542
      maxDynamicUniformBuffersPerPipelineLayout : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1543
      maxDynamicStorageBuffersPerPipelineLayout : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1544
      maxSampledTexturesPerShaderStage : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1545
      maxSamplersPerShaderStage : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1546
      maxStorageBuffersPerShaderStage : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1547
      maxStorageTexturesPerShaderStage : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1548
      maxUniformBuffersPerShaderStage : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1549
      maxUniformBufferBindingSize : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1550
      maxStorageBufferBindingSize : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1551
      minUniformBufferOffsetAlignment : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1552
      minStorageBufferOffsetAlignment : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1553
      maxVertexBuffers : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1554
      maxBufferSize : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1555
      maxVertexAttributes : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1556
      maxVertexBufferArrayStride : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1557
      maxInterStageShaderVariables : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1558
      maxColorAttachments : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1559
      maxColorAttachmentBytesPerSample : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1560
      maxComputeWorkgroupStorageSize : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1561
      maxComputeInvocationsPerWorkgroup : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1562
      maxComputeWorkgroupSizeX : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1563
      maxComputeWorkgroupSizeY : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1564
      maxComputeWorkgroupSizeZ : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1565
      maxComputeWorkgroupsPerDimension : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1566
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1533

   type WGPUMultisampleState is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1570
      count : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1571
      mask : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1572
      alphaToCoverageEnabled : aliased T_WGPUBool;  -- webgpu.h:1573
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1569

   type WGPUOrigin3D is record
      x : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1577
      y : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1578
      z : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1579
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1576

   type WGPUPipelineLayoutDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1583
      label : aliased WGPUStringView;  -- webgpu.h:1587
      bindGroupLayoutCount : aliased T_Size;  -- webgpu.h:1588
      bindGroupLayouts : System.Address;  -- webgpu.h:1589
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1582

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUPrimitiveState is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1593
      topology : aliased WGPUPrimitiveTopology;  -- webgpu.h:1594
      stripIndexFormat : aliased WGPUIndexFormat;  -- webgpu.h:1595
      frontFace : aliased WGPUFrontFace;  -- webgpu.h:1596
      cullMode : aliased WGPUCullMode;  -- webgpu.h:1597
      unclippedDepth : aliased T_WGPUBool;  -- webgpu.h:1598
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1592

   type WGPUQuerySetDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1602
      label : aliased WGPUStringView;  -- webgpu.h:1606
      c_type : aliased WGPUQueryType;  -- webgpu.h:1607
      count : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1608
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1601

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUQueueDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1612
      label : aliased WGPUStringView;  -- webgpu.h:1616
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1611

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPURenderBundleDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1620
      label : aliased WGPUStringView;  -- webgpu.h:1624
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1619

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPURenderBundleEncoderDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1628
      label : aliased WGPUStringView;  -- webgpu.h:1632
      colorFormatCount : aliased T_Size;  -- webgpu.h:1633
      colorFormats : access WGPUTextureFormat;  -- webgpu.h:1634
      depthStencilFormat : aliased WGPUTextureFormat;  -- webgpu.h:1635
      sampleCount : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1636
      depthReadOnly : aliased T_WGPUBool;  -- webgpu.h:1637
      stencilReadOnly : aliased T_WGPUBool;  -- webgpu.h:1638
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1627

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPURenderPassDepthStencilAttachment is record
      view : WGPUTextureView;  -- webgpu.h:1642
      depthLoadOp : aliased WGPULoadOp;  -- webgpu.h:1643
      depthStoreOp : aliased WGPUStoreOp;  -- webgpu.h:1644
      depthClearValue : aliased float;  -- webgpu.h:1645
      depthReadOnly : aliased T_WGPUBool;  -- webgpu.h:1646
      stencilLoadOp : aliased WGPULoadOp;  -- webgpu.h:1647
      stencilStoreOp : aliased WGPUStoreOp;  -- webgpu.h:1648
      stencilClearValue : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1649
      stencilReadOnly : aliased T_WGPUBool;  -- webgpu.h:1650
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1641

   type WGPURenderPassMaxDrawCount is record
      chain : aliased T_WGPUChainedStruct;  -- webgpu.h:1654
      maxDrawCount : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1655
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1653

   type WGPURenderPassTimestampWrites is record
      querySet : WGPUQuerySet;  -- webgpu.h:1659
      beginningOfPassWriteIndex : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1660
      endOfPassWriteIndex : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1661
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1658

   type WGPURequestAdapterOptions is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1665
      featureLevel : aliased WGPUFeatureLevel;  -- webgpu.h:1671
      powerPreference : aliased WGPUPowerPreference;  -- webgpu.h:1672
      forceFallbackAdapter : aliased T_WGPUBool;  -- webgpu.h:1677
      backendType : aliased WGPUBackendType;  -- webgpu.h:1682
      compatibleSurface : WGPUSurface;  -- webgpu.h:1687
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1664

  --*
  --     * "Feature level" for the adapter request. If an adapter is returned, it must support the features and limits in the requested feature level.
  --     *
  --     * Implementations may ignore @ref WGPUFeatureLevel_Compatibility and provide @ref WGPUFeatureLevel_Core instead. @ref WGPUFeatureLevel_Core is the default in the JS API, but in C, this field is **required** (must not be undefined).
  --

  --*
  --     * If true, requires the adapter to be a "fallback" adapter as defined by the JS spec.
  --     * If this is not possible, the request returns null.
  --

  --*
  --     * If set, requires the adapter to have a particular backend type.
  --     * If this is not possible, the request returns null.
  --

  --*
  --     * If set, requires the adapter to be able to output to a particular surface.
  --     * If this is not possible, the request returns null.
  --

   type WGPUSamplerBindingLayout is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1691
      c_type : aliased WGPUSamplerBindingType;  -- webgpu.h:1692
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1690

   type WGPUSamplerDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1696
      label : aliased WGPUStringView;  -- webgpu.h:1700
      addressModeU : aliased WGPUAddressMode;  -- webgpu.h:1701
      addressModeV : aliased WGPUAddressMode;  -- webgpu.h:1702
      addressModeW : aliased WGPUAddressMode;  -- webgpu.h:1703
      magFilter : aliased WGPUFilterMode;  -- webgpu.h:1704
      minFilter : aliased WGPUFilterMode;  -- webgpu.h:1705
      mipmapFilter : aliased WGPUMipmapFilterMode;  -- webgpu.h:1706
      lodMinClamp : aliased float;  -- webgpu.h:1707
      lodMaxClamp : aliased float;  -- webgpu.h:1708
      compare : aliased WGPUCompareFunction;  -- webgpu.h:1709
      maxAnisotropy : aliased bits_stdint_uintn_h.uint16_t;  -- webgpu.h:1710
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1695

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUShaderModuleDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1714
      label : aliased WGPUStringView;  -- webgpu.h:1718
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1713

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUShaderSourceSPIRV is record
      chain : aliased T_WGPUChainedStruct;  -- webgpu.h:1722
      codeSize : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1723
      code : access bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1724
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1721

   type WGPUShaderSourceWGSL is record
      chain : aliased T_WGPUChainedStruct;  -- webgpu.h:1728
      code : aliased WGPUStringView;  -- webgpu.h:1732
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1727

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUStencilFaceState is record
      compare : aliased WGPUCompareFunction;  -- webgpu.h:1736
      failOp : aliased WGPUStencilOperation;  -- webgpu.h:1737
      depthFailOp : aliased WGPUStencilOperation;  -- webgpu.h:1738
      passOp : aliased WGPUStencilOperation;  -- webgpu.h:1739
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1735

   type WGPUStorageTextureBindingLayout is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1743
      c_access : aliased WGPUStorageTextureAccess;  -- webgpu.h:1744
      format : aliased WGPUTextureFormat;  -- webgpu.h:1745
      viewDimension : aliased WGPUTextureViewDimension;  -- webgpu.h:1746
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1742

   type WGPUSupportedFeatures is record
      featureCount : aliased T_Size;  -- webgpu.h:1750
      features : access WGPUFeatureName;  -- webgpu.h:1751
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1749

   type WGPUSupportedWGSLLanguageFeatures is record
      featureCount : aliased T_Size;  -- webgpu.h:1755
      features : access WGPUWGSLLanguageFeatureName;  -- webgpu.h:1756
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1754

  --*
  -- * Filled by `::wgpuSurfaceGetCapabilities` with what's supported for `::wgpuSurfaceConfigure` for a pair of @ref WGPUSurface and @ref WGPUAdapter.
  --

   type WGPUSurfaceCapabilities is record
      nextInChain : access T_WGPUChainedStructOut;  -- webgpu.h:1763
      usages : aliased WGPUTextureUsage;  -- webgpu.h:1768
      formatCount : aliased T_Size;  -- webgpu.h:1772
      formats : access WGPUTextureFormat;  -- webgpu.h:1773
      presentModeCount : aliased T_Size;  -- webgpu.h:1778
      presentModes : access WGPUPresentMode;  -- webgpu.h:1779
      alphaModeCount : aliased T_Size;  -- webgpu.h:1784
      alphaModes : access WGPUCompositeAlphaMode;  -- webgpu.h:1785
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1762

  --*
  --     * The bit set of supported @ref WGPUTextureUsage bits.
  --     * Guaranteed to contain @ref WGPUTextureUsage_RenderAttachment.
  --

  --*
  --     * A list of supported @ref WGPUTextureFormat values, in order of preference.
  --

  --*
  --     * A list of supported @ref WGPUPresentMode values.
  --     * Guaranteed to contain @ref WGPUPresentMode_Fifo.
  --

  --*
  --     * A list of supported @ref WGPUCompositeAlphaMode values.
  --     * @ref WGPUCompositeAlphaMode_Auto will be an alias for the first element and will never be present in this array.
  --

  --*
  -- * Options to `::wgpuSurfaceConfigure` for defining how a @ref WGPUSurface will be rendered to and presented to the user.
  -- * See @ref Surface-Configuration for more details.
  --

   type WGPUSurfaceConfiguration is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1793
      device : WGPUDevice;  -- webgpu.h:1797
      format : aliased WGPUTextureFormat;  -- webgpu.h:1801
      usage : aliased WGPUTextureUsage;  -- webgpu.h:1805
      width : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1809
      height : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1813
      viewFormatCount : aliased T_Size;  -- webgpu.h:1817
      viewFormats : access WGPUTextureFormat;  -- webgpu.h:1818
      alphaMode : aliased WGPUCompositeAlphaMode;  -- webgpu.h:1822
      presentMode : aliased WGPUPresentMode;  -- webgpu.h:1826
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1792

  --*
  --     * The @ref WGPUDevice to use to render to surface's textures.
  --

  --*
  --     * The @ref WGPUTextureFormat of the surface's textures.
  --

  --*
  --     * The @ref WGPUTextureUsage of the surface's textures.
  --

  --*
  --     * The width of the surface's textures.
  --

  --*
  --     * The height of the surface's textures.
  --

  --*
  --     * The additional @ref WGPUTextureFormat for @ref WGPUTextureView format reinterpretation of the surface's textures.
  --

  --*
  --     * How the surface's frames will be composited on the screen.
  --

  --*
  --     * When and in which order the surface's frames will be shown on the screen. Defaults to @ref WGPUPresentMode_Fifo.
  --

  --*
  -- * The root descriptor for the creation of an @ref WGPUSurface with `::wgpuInstanceCreateSurface`.
  -- * It isn't sufficient by itself and must have one of the `WGPUSurfaceSource*` in its chain.
  -- * See @ref Surface-Creation for more details.
  --

   type WGPUSurfaceDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1835
      label : aliased WGPUStringView;  -- webgpu.h:1841
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1834

  --*
  --     * Label used to refer to the object.
  --     *
  --     * This is a \ref NonNullInputString.
  --

  --*
  -- * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an Android [`ANativeWindow`](https://developer.android.com/ndk/reference/group/a-native-window).
  --

   type WGPUSurfaceSourceAndroidNativeWindow is record
      chain : aliased T_WGPUChainedStruct;  -- webgpu.h:1848
      window : System.Address;  -- webgpu.h:1852
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1847

  --*
  --     * The pointer to the [`ANativeWindow`](https://developer.android.com/ndk/reference/group/a-native-window) that will be wrapped by the @ref WGPUSurface.
  --

  --*
  -- * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a [`CAMetalLayer`](https://developer.apple.com/documentation/quartzcore/cametallayer?language=objc).
  --

   type WGPUSurfaceSourceMetalLayer is record
      chain : aliased T_WGPUChainedStruct;  -- webgpu.h:1859
      layer : System.Address;  -- webgpu.h:1863
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1858

  --*
  --     * The pointer to the [`CAMetalLayer`](https://developer.apple.com/documentation/quartzcore/cametallayer?language=objc) that will be wrapped by the @ref WGPUSurface.
  --

  --*
  -- * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a [Wayland](https://wayland.freedesktop.org/) [`wl_surface`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_surface).
  --

   type WGPUSurfaceSourceWaylandSurface is record
      chain : aliased T_WGPUChainedStruct;  -- webgpu.h:1870
      display : System.Address;  -- webgpu.h:1874
      surface : System.Address;  -- webgpu.h:1878
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1869

  --*
  --     * A [`wl_display`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_display) for this Wayland instance.
  --

  --*
  --     * A [`wl_surface`](https://wayland.freedesktop.org/docs/html/apa.html#protocol-spec-wl_surface) that will be wrapped by the @ref WGPUSurface
  --

  --*
  -- * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping a Windows [`HWND`](https://learn.microsoft.com/en-us/windows/apps/develop/ui-input/retrieve-hwnd).
  --

   type WGPUSurfaceSourceWindowsHWND is record
      chain : aliased T_WGPUChainedStruct;  -- webgpu.h:1885
      hinstance : System.Address;  -- webgpu.h:1890
      hwnd : System.Address;  -- webgpu.h:1894
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1884

  --*
  --     * The [`HINSTANCE`](https://learn.microsoft.com/en-us/windows/win32/learnwin32/winmain--the-application-entry-point) for this application.
  --     * Most commonly `GetModuleHandle(nullptr)`.
  --

  --*
  --     * The [`HWND`](https://learn.microsoft.com/en-us/windows/apps/develop/ui-input/retrieve-hwnd) that will be wrapped by the @ref WGPUSurface.
  --

  --*
  -- * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an [XCB](https://xcb.freedesktop.org/) `xcb_window_t`.
  --

   type WGPUSurfaceSourceXCBWindow is record
      chain : aliased T_WGPUChainedStruct;  -- webgpu.h:1901
      connection : System.Address;  -- webgpu.h:1905
      window : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1909
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1900

  --*
  --     * The `xcb_connection_t` for the connection to the X server.
  --

  --*
  --     * The `xcb_window_t` for the window that will be wrapped by the @ref WGPUSurface.
  --

  --*
  -- * Chained in @ref WGPUSurfaceDescriptor to make an @ref WGPUSurface wrapping an [Xlib](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html) `Window`.
  --

   type WGPUSurfaceSourceXlibWindow is record
      chain : aliased T_WGPUChainedStruct;  -- webgpu.h:1916
      display : System.Address;  -- webgpu.h:1920
      window : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1924
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1915

  --*
  --     * A pointer to the [`Display`](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Opening_the_Display) connected to the X server.
  --

  --*
  --     * The [`Window`](https://www.x.org/releases/current/doc/libX11/libX11/libX11.html#Creating_Windows) that will be wrapped by the @ref WGPUSurface.
  --

  --*
  -- * Queried each frame from a @ref WGPUSurface to get a @ref WGPUTexture to render to along with some metadata.
  -- * See @ref Surface-Presenting for more details.
  --

   type WGPUSurfaceTexture is record
      nextInChain : access T_WGPUChainedStructOut;  -- webgpu.h:1932
      texture : WGPUTexture;  -- webgpu.h:1937
      status : aliased WGPUSurfaceGetCurrentTextureStatus;  -- webgpu.h:1941
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1931

  --*
  --     * The @ref WGPUTexture representing the frame that will be shown on the surface.
  --     * It is @ref ReturnedWithOwnership from @ref wgpuSurfaceGetCurrentTexture.
  --

  --*
  --     * Whether the call to `::wgpuSurfaceGetCurrentTexture` succeeded and a hint as to why it might not have.
  --

   type WGPUTexelCopyBufferLayout is record
      offset : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1945
      bytesPerRow : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1946
      rowsPerImage : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1947
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1944

   type WGPUTextureBindingLayout is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1951
      sampleType : aliased WGPUTextureSampleType;  -- webgpu.h:1952
      viewDimension : aliased WGPUTextureViewDimension;  -- webgpu.h:1953
      multisampled : aliased T_WGPUBool;  -- webgpu.h:1954
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1950

   type WGPUTextureViewDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1958
      label : aliased WGPUStringView;  -- webgpu.h:1962
      format : aliased WGPUTextureFormat;  -- webgpu.h:1963
      dimension : aliased WGPUTextureViewDimension;  -- webgpu.h:1964
      baseMipLevel : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1965
      mipLevelCount : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1966
      baseArrayLayer : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1967
      arrayLayerCount : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1968
      aspect : aliased WGPUTextureAspect;  -- webgpu.h:1969
      usage : aliased WGPUTextureUsage;  -- webgpu.h:1970
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1957

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUVertexAttribute is record
      format : aliased WGPUVertexFormat;  -- webgpu.h:1974
      offset : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:1975
      shaderLocation : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1976
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1973

   type WGPUBindGroupDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1980
      label : aliased WGPUStringView;  -- webgpu.h:1984
      layout : WGPUBindGroupLayout;  -- webgpu.h:1985
      entryCount : aliased T_Size;  -- webgpu.h:1986
      entries : access constant WGPUBindGroupEntry;  -- webgpu.h:1987
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1979

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUBindGroupLayoutEntry is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:1991
      binding : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:1992
      visibility : aliased WGPUShaderStage;  -- webgpu.h:1993
      buffer : aliased WGPUBufferBindingLayout;  -- webgpu.h:1994
      sampler : aliased WGPUSamplerBindingLayout;  -- webgpu.h:1995
      texture : aliased WGPUTextureBindingLayout;  -- webgpu.h:1996
      storageTexture : aliased WGPUStorageTextureBindingLayout;  -- webgpu.h:1997
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:1990

   type WGPUBlendState is record
      color : aliased WGPUBlendComponent;  -- webgpu.h:2001
      alpha : aliased WGPUBlendComponent;  -- webgpu.h:2002
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2000

   type WGPUCompilationInfo is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2006
      messageCount : aliased T_Size;  -- webgpu.h:2007
      messages : access constant WGPUCompilationMessage;  -- webgpu.h:2008
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2005

   type WGPUComputePassDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2012
      label : aliased WGPUStringView;  -- webgpu.h:2016
      timestampWrites : access constant WGPUComputePassTimestampWrites;  -- webgpu.h:2017
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2011

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUDepthStencilState is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2021
      format : aliased WGPUTextureFormat;  -- webgpu.h:2022
      depthWriteEnabled : aliased WGPUOptionalBool;  -- webgpu.h:2023
      depthCompare : aliased WGPUCompareFunction;  -- webgpu.h:2024
      stencilFront : aliased WGPUStencilFaceState;  -- webgpu.h:2025
      stencilBack : aliased WGPUStencilFaceState;  -- webgpu.h:2026
      stencilReadMask : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:2027
      stencilWriteMask : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:2028
      depthBias : aliased bits_stdint_intn_h.int32_t;  -- webgpu.h:2029
      depthBiasSlopeScale : aliased float;  -- webgpu.h:2030
      depthBiasClamp : aliased float;  -- webgpu.h:2031
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2020

   type WGPUDeviceDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2035
      label : aliased WGPUStringView;  -- webgpu.h:2039
      requiredFeatureCount : aliased T_Size;  -- webgpu.h:2040
      requiredFeatures : access WGPUFeatureName;  -- webgpu.h:2041
      requiredLimits : access constant WGPULimits;  -- webgpu.h:2042
      defaultQueue : aliased WGPUQueueDescriptor;  -- webgpu.h:2043
      deviceLostCallbackInfo : aliased WGPUDeviceLostCallbackInfo;  -- webgpu.h:2044
      uncapturedErrorCallbackInfo : aliased WGPUUncapturedErrorCallbackInfo;  -- webgpu.h:2045
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2034

  --*
  --     * This is a \ref NonNullInputString.
  --

  --*
  -- * Struct holding a future to wait on, and a `completed` boolean flag.
  --

  --*
  --     * The future to wait on.
  --

   type WGPUFutureWaitInfo is record
      future : aliased WGPUFuture;  -- webgpu.h:2055
      completed : aliased T_WGPUBool;  -- webgpu.h:2059
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2051

  --*
  --     * Whether or not the future completed.
  --

	type T_WGPUInstanceDescriptor is record
		nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2063
		features    : aliased T_WGPUInstanceCapabilities;  -- webgpu.h:2067
	end record
	with Convention => C_Pass_By_Copy;  -- webgpu.h:2062

  --*
  --     * Instance features to enable
  --

   type WGPUProgrammableStageDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2071
      module : WGPUShaderModule;  -- webgpu.h:2072
      entryPoint : aliased WGPUStringView;  -- webgpu.h:2076
      constantCount : aliased T_Size;  -- webgpu.h:2077
      constants : access constant WGPUConstantEntry;  -- webgpu.h:2078
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2070

  --*
  --     * This is a \ref NullableInputString.
  --

   type WGPURenderPassColorAttachment is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2082
      view : WGPUTextureView;  -- webgpu.h:2083
      depthSlice : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:2084
      resolveTarget : WGPUTextureView;  -- webgpu.h:2085
      loadOp : aliased WGPULoadOp;  -- webgpu.h:2086
      storeOp : aliased WGPUStoreOp;  -- webgpu.h:2087
      clearValue : aliased WGPUColor;  -- webgpu.h:2088
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2081

   type WGPUTexelCopyBufferInfo is record
      layout : aliased WGPUTexelCopyBufferLayout;  -- webgpu.h:2092
      buffer : WGPUBuffer;  -- webgpu.h:2093
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2091

   type WGPUTexelCopyTextureInfo is record
      texture : WGPUTexture;  -- webgpu.h:2097
      mipLevel : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:2098
      origin : aliased WGPUOrigin3D;  -- webgpu.h:2099
      aspect : aliased WGPUTextureAspect;  -- webgpu.h:2100
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2096

   type WGPUTextureDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2104
      label : aliased WGPUStringView;  -- webgpu.h:2108
      usage : aliased WGPUTextureUsage;  -- webgpu.h:2109
      dimension : aliased WGPUTextureDimension;  -- webgpu.h:2110
      size : aliased WGPUExtent3D;  -- webgpu.h:2111
      format : aliased WGPUTextureFormat;  -- webgpu.h:2112
      mipLevelCount : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:2113
      sampleCount : aliased bits_stdint_uintn_h.uint32_t;  -- webgpu.h:2114
      viewFormatCount : aliased T_Size;  -- webgpu.h:2115
      viewFormats : access WGPUTextureFormat;  -- webgpu.h:2116
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2103

  --*
  --     * This is a \ref NonNullInputString.
  --

  --*
  --     * The step mode for the vertex buffer. If @ref WGPUVertexStepMode_VertexBufferNotUsed,
  --     * indicates a "hole" in the parent @ref WGPUVertexState `buffers` array:
  --     * the pipeline does not use a vertex buffer at this `location`.
  --

   type WGPUVertexBufferLayout is record
      stepMode : aliased WGPUVertexStepMode;  -- webgpu.h:2125
      arrayStride : aliased bits_stdint_uintn_h.uint64_t;  -- webgpu.h:2126
      attributeCount : aliased T_Size;  -- webgpu.h:2127
      attributes : access constant WGPUVertexAttribute;  -- webgpu.h:2128
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2119

   type WGPUBindGroupLayoutDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2132
      label : aliased WGPUStringView;  -- webgpu.h:2136
      entryCount : aliased T_Size;  -- webgpu.h:2137
      entries : access constant WGPUBindGroupLayoutEntry;  -- webgpu.h:2138
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2131

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUColorTargetState is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2142
      format : aliased WGPUTextureFormat;  -- webgpu.h:2148
      blend : access constant WGPUBlendState;  -- webgpu.h:2149
      writeMask : aliased WGPUColorWriteMask;  -- webgpu.h:2150
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2141

  --*
  --     * The texture format of the target. If @ref WGPUTextureFormat_Undefined,
  --     * indicates a "hole" in the parent @ref WGPUFragmentState `targets` array:
  --     * the pipeline does not output a value at this `location`.
  --

   type WGPUComputePipelineDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2154
      label : aliased WGPUStringView;  -- webgpu.h:2158
      layout : WGPUPipelineLayout;  -- webgpu.h:2159
      compute : aliased WGPUProgrammableStageDescriptor;  -- webgpu.h:2160
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2153

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPURenderPassDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2164
      label : aliased WGPUStringView;  -- webgpu.h:2168
      colorAttachmentCount : aliased T_Size;  -- webgpu.h:2169
      colorAttachments : access constant WGPURenderPassColorAttachment;  -- webgpu.h:2170
      depthStencilAttachment : access constant WGPURenderPassDepthStencilAttachment;  -- webgpu.h:2171
      occlusionQuerySet : WGPUQuerySet;  -- webgpu.h:2172
      timestampWrites : access constant WGPURenderPassTimestampWrites;  -- webgpu.h:2173
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2163

  --*
  --     * This is a \ref NonNullInputString.
  --

   type WGPUVertexState is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2177
      module : WGPUShaderModule;  -- webgpu.h:2178
      entryPoint : aliased WGPUStringView;  -- webgpu.h:2182
      constantCount : aliased T_Size;  -- webgpu.h:2183
      constants : access constant WGPUConstantEntry;  -- webgpu.h:2184
      bufferCount : aliased T_Size;  -- webgpu.h:2185
      buffers : access constant WGPUVertexBufferLayout;  -- webgpu.h:2186
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2176

  --*
  --     * This is a \ref NullableInputString.
  --

   type WGPUFragmentState is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2190
      module : WGPUShaderModule;  -- webgpu.h:2191
      entryPoint : aliased WGPUStringView;  -- webgpu.h:2195
      constantCount : aliased T_Size;  -- webgpu.h:2196
      constants : access constant WGPUConstantEntry;  -- webgpu.h:2197
      targetCount : aliased T_Size;  -- webgpu.h:2198
      targets : access constant WGPUColorTargetState;  -- webgpu.h:2199
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2189

  --*
  --     * This is a \ref NullableInputString.
  --

   type WGPURenderPipelineDescriptor is record
      nextInChain : access constant T_WGPUChainedStruct;  -- webgpu.h:2203
      label : aliased WGPUStringView;  -- webgpu.h:2207
      layout : WGPUPipelineLayout;  -- webgpu.h:2208
      vertex : aliased WGPUVertexState;  -- webgpu.h:2209
      primitive : aliased WGPUPrimitiveState;  -- webgpu.h:2210
      depthStencil : access constant WGPUDepthStencilState;  -- webgpu.h:2211
      multisample : aliased WGPUMultisampleState;  -- webgpu.h:2212
      fragment : access constant WGPUFragmentState;  -- webgpu.h:2213
   end record
   with Convention => C_Pass_By_Copy;  -- webgpu.h:2202

  --*
  --     * This is a \ref NonNullInputString.
  --

  --* @}
  --*
  -- * Proc pointer type for @ref wgpuCreateInstance:
  -- * > @copydoc wgpuCreateInstance
  --

   type WGPUProcCreateInstance is access function (arg1 : access constant T_WGPUInstanceDescriptor) return T_WGPUInstance
   with Convention => C;  -- webgpu.h:2228

  --*
  -- * Proc pointer type for @ref wgpuGetInstanceCapabilities:
  -- * > @copydoc wgpuGetInstanceCapabilities
  --

   type WGPUProcGetInstanceCapabilities is access function (arg1 : access T_WGPUInstanceCapabilities) return WGPUStatus
   with Convention => C;  -- webgpu.h:2233

  --*
  -- * Proc pointer type for @ref wgpuGetProcAddress:
  -- * > @copydoc wgpuGetProcAddress
  --

   type WGPUProcGetProcAddress is access function (arg1 : WGPUStringView) return WGPUProc
   with Convention => C;  -- webgpu.h:2238

  -- Procs of Adapter
  --*
  -- * Proc pointer type for @ref wgpuAdapterGetFeatures:
  -- * > @copydoc wgpuAdapterGetFeatures
  --

   type WGPUProcAdapterGetFeatures is access procedure (arg1 : WGPUAdapter; arg2 : access WGPUSupportedFeatures)
   with Convention => C;  -- webgpu.h:2245

  --*
  -- * Proc pointer type for @ref wgpuAdapterGetInfo:
  -- * > @copydoc wgpuAdapterGetInfo
  --

   type WGPUProcAdapterGetInfo is access function (arg1 : WGPUAdapter; arg2 : access WGPUAdapterInfo) return WGPUStatus
   with Convention => C;  -- webgpu.h:2250

  --*
  -- * Proc pointer type for @ref wgpuAdapterGetLimits:
  -- * > @copydoc wgpuAdapterGetLimits
  --

   type WGPUProcAdapterGetLimits is access function (arg1 : WGPUAdapter; arg2 : access WGPULimits) return WGPUStatus
   with Convention => C;  -- webgpu.h:2255

  --*
  -- * Proc pointer type for @ref wgpuAdapterHasFeature:
  -- * > @copydoc wgpuAdapterHasFeature
  --

   type WGPUProcAdapterHasFeature is access function (arg1 : WGPUAdapter; arg2 : WGPUFeatureName) return T_WGPUBool
   with Convention => C;  -- webgpu.h:2260

  --*
  -- * Proc pointer type for @ref wgpuAdapterRequestDevice:
  -- * > @copydoc wgpuAdapterRequestDevice
  --

   type WGPUProcAdapterRequestDevice is access function
        (arg1 : WGPUAdapter;
         arg2 : access constant WGPUDeviceDescriptor;
         arg3 : WGPURequestDeviceCallbackInfo) return WGPUFuture
   with Convention => C;  -- webgpu.h:2265

  --*
  -- * Proc pointer type for @ref wgpuAdapterAddRef.
  -- * > @copydoc wgpuAdapterAddRef
  --

   type WGPUProcAdapterAddRef is access procedure (arg1 : WGPUAdapter)
   with Convention => C;  -- webgpu.h:2270

  --*
  -- * Proc pointer type for @ref wgpuAdapterRelease.
  -- * > @copydoc wgpuAdapterRelease
  --

   type WGPUProcAdapterRelease is access procedure (arg1 : WGPUAdapter)
   with Convention => C;  -- webgpu.h:2275

  -- Procs of AdapterInfo
  --*
  -- * Proc pointer type for @ref wgpuAdapterInfoFreeMembers:
  -- * > @copydoc wgpuAdapterInfoFreeMembers
  --

   type WGPUProcAdapterInfoFreeMembers is access procedure (arg1 : WGPUAdapterInfo)
   with Convention => C;  -- webgpu.h:2282

  -- Procs of BindGroup
  --*
  -- * Proc pointer type for @ref wgpuBindGroupSetLabel:
  -- * > @copydoc wgpuBindGroupSetLabel
  --

   type WGPUProcBindGroupSetLabel is access procedure (arg1 : WGPUBindGroup; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2289

  --*
  -- * Proc pointer type for @ref wgpuBindGroupAddRef.
  -- * > @copydoc wgpuBindGroupAddRef
  --

   type WGPUProcBindGroupAddRef is access procedure (arg1 : WGPUBindGroup)
   with Convention => C;  -- webgpu.h:2294

  --*
  -- * Proc pointer type for @ref wgpuBindGroupRelease.
  -- * > @copydoc wgpuBindGroupRelease
  --

   type WGPUProcBindGroupRelease is access procedure (arg1 : WGPUBindGroup)
   with Convention => C;  -- webgpu.h:2299

  -- Procs of BindGroupLayout
  --*
  -- * Proc pointer type for @ref wgpuBindGroupLayoutSetLabel:
  -- * > @copydoc wgpuBindGroupLayoutSetLabel
  --

   type WGPUProcBindGroupLayoutSetLabel is access procedure (arg1 : WGPUBindGroupLayout; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2306

  --*
  -- * Proc pointer type for @ref wgpuBindGroupLayoutAddRef.
  -- * > @copydoc wgpuBindGroupLayoutAddRef
  --

   type WGPUProcBindGroupLayoutAddRef is access procedure (arg1 : WGPUBindGroupLayout)
   with Convention => C;  -- webgpu.h:2311

  --*
  -- * Proc pointer type for @ref wgpuBindGroupLayoutRelease.
  -- * > @copydoc wgpuBindGroupLayoutRelease
  --

   type WGPUProcBindGroupLayoutRelease is access procedure (arg1 : WGPUBindGroupLayout)
   with Convention => C;  -- webgpu.h:2316

  -- Procs of Buffer
  --*
  -- * Proc pointer type for @ref wgpuBufferDestroy:
  -- * > @copydoc wgpuBufferDestroy
  --

   type WGPUProcBufferDestroy is access procedure (arg1 : WGPUBuffer)
   with Convention => C;  -- webgpu.h:2323

  --*
  -- * Proc pointer type for @ref wgpuBufferGetConstMappedRange:
  -- * > @copydoc wgpuBufferGetConstMappedRange
  --

   type WGPUProcBufferGetConstMappedRange is access function
        (arg1 : WGPUBuffer;
         arg2 : T_Size;
         arg3 : T_Size) return System.Address
   with Convention => C;  -- webgpu.h:2328

  --*
  -- * Proc pointer type for @ref wgpuBufferGetMapState:
  -- * > @copydoc wgpuBufferGetMapState
  --

   type WGPUProcBufferGetMapState is access function (arg1 : WGPUBuffer) return WGPUBufferMapState
   with Convention => C;  -- webgpu.h:2333

  --*
  -- * Proc pointer type for @ref wgpuBufferGetMappedRange:
  -- * > @copydoc wgpuBufferGetMappedRange
  --

   type WGPUProcBufferGetMappedRange is access function
        (arg1 : WGPUBuffer;
         arg2 : T_Size;
         arg3 : T_Size) return System.Address
   with Convention => C;  -- webgpu.h:2338

  --*
  -- * Proc pointer type for @ref wgpuBufferGetSize:
  -- * > @copydoc wgpuBufferGetSize
  --

   type WGPUProcBufferGetSize is access function (arg1 : WGPUBuffer) return bits_stdint_uintn_h.uint64_t
   with Convention => C;  -- webgpu.h:2343

  --*
  -- * Proc pointer type for @ref wgpuBufferGetUsage:
  -- * > @copydoc wgpuBufferGetUsage
  --

   type WGPUProcBufferGetUsage is access function (arg1 : WGPUBuffer) return WGPUBufferUsage
   with Convention => C;  -- webgpu.h:2348

  --*
  -- * Proc pointer type for @ref wgpuBufferMapAsync:
  -- * > @copydoc wgpuBufferMapAsync
  --

   type WGPUProcBufferMapAsync is access function
        (arg1 : WGPUBuffer;
         arg2 : WGPUMapMode;
         arg3 : T_Size;
         arg4 : T_Size;
         arg5 : WGPUBufferMapCallbackInfo) return WGPUFuture
   with Convention => C;  -- webgpu.h:2353

  --*
  -- * Proc pointer type for @ref wgpuBufferSetLabel:
  -- * > @copydoc wgpuBufferSetLabel
  --

   type WGPUProcBufferSetLabel is access procedure (arg1 : WGPUBuffer; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2358

  --*
  -- * Proc pointer type for @ref wgpuBufferUnmap:
  -- * > @copydoc wgpuBufferUnmap
  --

   type WGPUProcBufferUnmap is access procedure (arg1 : WGPUBuffer)
   with Convention => C;  -- webgpu.h:2363

  --*
  -- * Proc pointer type for @ref wgpuBufferAddRef.
  -- * > @copydoc wgpuBufferAddRef
  --

   type WGPUProcBufferAddRef is access procedure (arg1 : WGPUBuffer)
   with Convention => C;  -- webgpu.h:2368

  --*
  -- * Proc pointer type for @ref wgpuBufferRelease.
  -- * > @copydoc wgpuBufferRelease
  --

   type WGPUProcBufferRelease is access procedure (arg1 : WGPUBuffer)
   with Convention => C;  -- webgpu.h:2373

  -- Procs of CommandBuffer
  --*
  -- * Proc pointer type for @ref wgpuCommandBufferSetLabel:
  -- * > @copydoc wgpuCommandBufferSetLabel
  --

   type WGPUProcCommandBufferSetLabel is access procedure (arg1 : WGPUCommandBuffer; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2380

  --*
  -- * Proc pointer type for @ref wgpuCommandBufferAddRef.
  -- * > @copydoc wgpuCommandBufferAddRef
  --

   type WGPUProcCommandBufferAddRef is access procedure (arg1 : WGPUCommandBuffer)
   with Convention => C;  -- webgpu.h:2385

  --*
  -- * Proc pointer type for @ref wgpuCommandBufferRelease.
  -- * > @copydoc wgpuCommandBufferRelease
  --

   type WGPUProcCommandBufferRelease is access procedure (arg1 : WGPUCommandBuffer)
   with Convention => C;  -- webgpu.h:2390

  -- Procs of CommandEncoder
  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderBeginComputePass:
  -- * > @copydoc wgpuCommandEncoderBeginComputePass
  --

   type WGPUProcCommandEncoderBeginComputePass is access function (arg1 : WGPUCommandEncoder; arg2 : access constant WGPUComputePassDescriptor) return WGPUComputePassEncoder
   with Convention => C;  -- webgpu.h:2397

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderBeginRenderPass:
  -- * > @copydoc wgpuCommandEncoderBeginRenderPass
  --

   type WGPUProcCommandEncoderBeginRenderPass is access function (arg1 : WGPUCommandEncoder; arg2 : access constant WGPURenderPassDescriptor) return WGPURenderPassEncoder
   with Convention => C;  -- webgpu.h:2402

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderClearBuffer:
  -- * > @copydoc wgpuCommandEncoderClearBuffer
  --

   type WGPUProcCommandEncoderClearBuffer is access procedure
        (arg1 : WGPUCommandEncoder;
         arg2 : WGPUBuffer;
         arg3 : bits_stdint_uintn_h.uint64_t;
         arg4 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2407

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderCopyBufferToBuffer:
  -- * > @copydoc wgpuCommandEncoderCopyBufferToBuffer
  --

   type WGPUProcCommandEncoderCopyBufferToBuffer is access procedure
        (arg1 : WGPUCommandEncoder;
         arg2 : WGPUBuffer;
         arg3 : bits_stdint_uintn_h.uint64_t;
         arg4 : WGPUBuffer;
         arg5 : bits_stdint_uintn_h.uint64_t;
         arg6 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2412

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderCopyBufferToTexture:
  -- * > @copydoc wgpuCommandEncoderCopyBufferToTexture
  --

   type WGPUProcCommandEncoderCopyBufferToTexture is access procedure
        (arg1 : WGPUCommandEncoder;
         arg2 : access constant WGPUTexelCopyBufferInfo;
         arg3 : access constant WGPUTexelCopyTextureInfo;
         arg4 : access constant WGPUExtent3D)
   with Convention => C;  -- webgpu.h:2417

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderCopyTextureToBuffer:
  -- * > @copydoc wgpuCommandEncoderCopyTextureToBuffer
  --

   type WGPUProcCommandEncoderCopyTextureToBuffer is access procedure
        (arg1 : WGPUCommandEncoder;
         arg2 : access constant WGPUTexelCopyTextureInfo;
         arg3 : access constant WGPUTexelCopyBufferInfo;
         arg4 : access constant WGPUExtent3D)
   with Convention => C;  -- webgpu.h:2422

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderCopyTextureToTexture:
  -- * > @copydoc wgpuCommandEncoderCopyTextureToTexture
  --

   type WGPUProcCommandEncoderCopyTextureToTexture is access procedure
        (arg1 : WGPUCommandEncoder;
         arg2 : access constant WGPUTexelCopyTextureInfo;
         arg3 : access constant WGPUTexelCopyTextureInfo;
         arg4 : access constant WGPUExtent3D)
   with Convention => C;  -- webgpu.h:2427

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderFinish:
  -- * > @copydoc wgpuCommandEncoderFinish
  --

   type WGPUProcCommandEncoderFinish is access function (arg1 : WGPUCommandEncoder; arg2 : access constant WGPUCommandBufferDescriptor) return WGPUCommandBuffer
   with Convention => C;  -- webgpu.h:2432

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderInsertDebugMarker:
  -- * > @copydoc wgpuCommandEncoderInsertDebugMarker
  --

   type WGPUProcCommandEncoderInsertDebugMarker is access procedure (arg1 : WGPUCommandEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2437

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderPopDebugGroup:
  -- * > @copydoc wgpuCommandEncoderPopDebugGroup
  --

   type WGPUProcCommandEncoderPopDebugGroup is access procedure (arg1 : WGPUCommandEncoder)
   with Convention => C;  -- webgpu.h:2442

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderPushDebugGroup:
  -- * > @copydoc wgpuCommandEncoderPushDebugGroup
  --

   type WGPUProcCommandEncoderPushDebugGroup is access procedure (arg1 : WGPUCommandEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2447

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderResolveQuerySet:
  -- * > @copydoc wgpuCommandEncoderResolveQuerySet
  --

   type WGPUProcCommandEncoderResolveQuerySet is access procedure
        (arg1 : WGPUCommandEncoder;
         arg2 : WGPUQuerySet;
         arg3 : bits_stdint_uintn_h.uint32_t;
         arg4 : bits_stdint_uintn_h.uint32_t;
         arg5 : WGPUBuffer;
         arg6 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2452

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderSetLabel:
  -- * > @copydoc wgpuCommandEncoderSetLabel
  --

   type WGPUProcCommandEncoderSetLabel is access procedure (arg1 : WGPUCommandEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2457

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderWriteTimestamp:
  -- * > @copydoc wgpuCommandEncoderWriteTimestamp
  --

   type WGPUProcCommandEncoderWriteTimestamp is access procedure
        (arg1 : WGPUCommandEncoder;
         arg2 : WGPUQuerySet;
         arg3 : bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2462

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderAddRef.
  -- * > @copydoc wgpuCommandEncoderAddRef
  --

   type WGPUProcCommandEncoderAddRef is access procedure (arg1 : WGPUCommandEncoder)
   with Convention => C;  -- webgpu.h:2467

  --*
  -- * Proc pointer type for @ref wgpuCommandEncoderRelease.
  -- * > @copydoc wgpuCommandEncoderRelease
  --

   type WGPUProcCommandEncoderRelease is access procedure (arg1 : WGPUCommandEncoder)
   with Convention => C;  -- webgpu.h:2472

  -- Procs of ComputePassEncoder
  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderDispatchWorkgroups:
  -- * > @copydoc wgpuComputePassEncoderDispatchWorkgroups
  --

   type WGPUProcComputePassEncoderDispatchWorkgroups is access procedure
        (arg1 : WGPUComputePassEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : bits_stdint_uintn_h.uint32_t;
         arg4 : bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2479

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderDispatchWorkgroupsIndirect:
  -- * > @copydoc wgpuComputePassEncoderDispatchWorkgroupsIndirect
  --

   type WGPUProcComputePassEncoderDispatchWorkgroupsIndirect is access procedure
        (arg1 : WGPUComputePassEncoder;
         arg2 : WGPUBuffer;
         arg3 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2484

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderEnd:
  -- * > @copydoc wgpuComputePassEncoderEnd
  --

   type WGPUProcComputePassEncoderEnd is access procedure (arg1 : WGPUComputePassEncoder)
   with Convention => C;  -- webgpu.h:2489

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderInsertDebugMarker:
  -- * > @copydoc wgpuComputePassEncoderInsertDebugMarker
  --

   type WGPUProcComputePassEncoderInsertDebugMarker is access procedure (arg1 : WGPUComputePassEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2494

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderPopDebugGroup:
  -- * > @copydoc wgpuComputePassEncoderPopDebugGroup
  --

   type WGPUProcComputePassEncoderPopDebugGroup is access procedure (arg1 : WGPUComputePassEncoder)
   with Convention => C;  -- webgpu.h:2499

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderPushDebugGroup:
  -- * > @copydoc wgpuComputePassEncoderPushDebugGroup
  --

   type WGPUProcComputePassEncoderPushDebugGroup is access procedure (arg1 : WGPUComputePassEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2504

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderSetBindGroup:
  -- * > @copydoc wgpuComputePassEncoderSetBindGroup
  --

   type WGPUProcComputePassEncoderSetBindGroup is access procedure
        (arg1 : WGPUComputePassEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : WGPUBindGroup;
         arg4 : T_Size;
         arg5 : access bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2509

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderSetLabel:
  -- * > @copydoc wgpuComputePassEncoderSetLabel
  --

   type WGPUProcComputePassEncoderSetLabel is access procedure (arg1 : WGPUComputePassEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2514

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderSetPipeline:
  -- * > @copydoc wgpuComputePassEncoderSetPipeline
  --

   type WGPUProcComputePassEncoderSetPipeline is access procedure (arg1 : WGPUComputePassEncoder; arg2 : WGPUComputePipeline)
   with Convention => C;  -- webgpu.h:2519

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderAddRef.
  -- * > @copydoc wgpuComputePassEncoderAddRef
  --

   type WGPUProcComputePassEncoderAddRef is access procedure (arg1 : WGPUComputePassEncoder)
   with Convention => C;  -- webgpu.h:2524

  --*
  -- * Proc pointer type for @ref wgpuComputePassEncoderRelease.
  -- * > @copydoc wgpuComputePassEncoderRelease
  --

   type WGPUProcComputePassEncoderRelease is access procedure (arg1 : WGPUComputePassEncoder)
   with Convention => C;  -- webgpu.h:2529

  -- Procs of ComputePipeline
  --*
  -- * Proc pointer type for @ref wgpuComputePipelineGetBindGroupLayout:
  -- * > @copydoc wgpuComputePipelineGetBindGroupLayout
  --

   type WGPUProcComputePipelineGetBindGroupLayout is access function (arg1 : WGPUComputePipeline; arg2 : bits_stdint_uintn_h.uint32_t) return WGPUBindGroupLayout
   with Convention => C;  -- webgpu.h:2536

  --*
  -- * Proc pointer type for @ref wgpuComputePipelineSetLabel:
  -- * > @copydoc wgpuComputePipelineSetLabel
  --

   type WGPUProcComputePipelineSetLabel is access procedure (arg1 : WGPUComputePipeline; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2541

  --*
  -- * Proc pointer type for @ref wgpuComputePipelineAddRef.
  -- * > @copydoc wgpuComputePipelineAddRef
  --

   type WGPUProcComputePipelineAddRef is access procedure (arg1 : WGPUComputePipeline)
   with Convention => C;  -- webgpu.h:2546

  --*
  -- * Proc pointer type for @ref wgpuComputePipelineRelease.
  -- * > @copydoc wgpuComputePipelineRelease
  --

   type WGPUProcComputePipelineRelease is access procedure (arg1 : WGPUComputePipeline)
   with Convention => C;  -- webgpu.h:2551

  -- Procs of Device
  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateBindGroup:
  -- * > @copydoc wgpuDeviceCreateBindGroup
  --

   type WGPUProcDeviceCreateBindGroup is access function (arg1 : WGPUDevice; arg2 : access constant WGPUBindGroupDescriptor) return WGPUBindGroup
   with Convention => C;  -- webgpu.h:2558

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateBindGroupLayout:
  -- * > @copydoc wgpuDeviceCreateBindGroupLayout
  --

   type WGPUProcDeviceCreateBindGroupLayout is access function (arg1 : WGPUDevice; arg2 : access constant WGPUBindGroupLayoutDescriptor) return WGPUBindGroupLayout
   with Convention => C;  -- webgpu.h:2563

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateBuffer:
  -- * > @copydoc wgpuDeviceCreateBuffer
  --

   type WGPUProcDeviceCreateBuffer is access function (arg1 : WGPUDevice; arg2 : access constant WGPUBufferDescriptor) return WGPUBuffer
   with Convention => C;  -- webgpu.h:2568

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateCommandEncoder:
  -- * > @copydoc wgpuDeviceCreateCommandEncoder
  --

   type WGPUProcDeviceCreateCommandEncoder is access function (arg1 : WGPUDevice; arg2 : access constant WGPUCommandEncoderDescriptor) return WGPUCommandEncoder
   with Convention => C;  -- webgpu.h:2573

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateComputePipeline:
  -- * > @copydoc wgpuDeviceCreateComputePipeline
  --

   type WGPUProcDeviceCreateComputePipeline is access function (arg1 : WGPUDevice; arg2 : access constant WGPUComputePipelineDescriptor) return WGPUComputePipeline
   with Convention => C;  -- webgpu.h:2578

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateComputePipelineAsync:
  -- * > @copydoc wgpuDeviceCreateComputePipelineAsync
  --

   type WGPUProcDeviceCreateComputePipelineAsync is access function
        (arg1 : WGPUDevice;
         arg2 : access constant WGPUComputePipelineDescriptor;
         arg3 : WGPUCreateComputePipelineAsyncCallbackInfo) return WGPUFuture
   with Convention => C;  -- webgpu.h:2583

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreatePipelineLayout:
  -- * > @copydoc wgpuDeviceCreatePipelineLayout
  --

   type WGPUProcDeviceCreatePipelineLayout is access function (arg1 : WGPUDevice; arg2 : access constant WGPUPipelineLayoutDescriptor) return WGPUPipelineLayout
   with Convention => C;  -- webgpu.h:2588

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateQuerySet:
  -- * > @copydoc wgpuDeviceCreateQuerySet
  --

   type WGPUProcDeviceCreateQuerySet is access function (arg1 : WGPUDevice; arg2 : access constant WGPUQuerySetDescriptor) return WGPUQuerySet
   with Convention => C;  -- webgpu.h:2593

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateRenderBundleEncoder:
  -- * > @copydoc wgpuDeviceCreateRenderBundleEncoder
  --

   type WGPUProcDeviceCreateRenderBundleEncoder is access function (arg1 : WGPUDevice; arg2 : access constant WGPURenderBundleEncoderDescriptor) return WGPURenderBundleEncoder
   with Convention => C;  -- webgpu.h:2598

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateRenderPipeline:
  -- * > @copydoc wgpuDeviceCreateRenderPipeline
  --

   type WGPUProcDeviceCreateRenderPipeline is access function (arg1 : WGPUDevice; arg2 : access constant WGPURenderPipelineDescriptor) return WGPURenderPipeline
   with Convention => C;  -- webgpu.h:2603

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateRenderPipelineAsync:
  -- * > @copydoc wgpuDeviceCreateRenderPipelineAsync
  --

   type WGPUProcDeviceCreateRenderPipelineAsync is access function
        (arg1 : WGPUDevice;
         arg2 : access constant WGPURenderPipelineDescriptor;
         arg3 : WGPUCreateRenderPipelineAsyncCallbackInfo) return WGPUFuture
   with Convention => C;  -- webgpu.h:2608

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateSampler:
  -- * > @copydoc wgpuDeviceCreateSampler
  --

   type WGPUProcDeviceCreateSampler is access function (arg1 : WGPUDevice; arg2 : access constant WGPUSamplerDescriptor) return WGPUSampler
   with Convention => C;  -- webgpu.h:2613

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateShaderModule:
  -- * > @copydoc wgpuDeviceCreateShaderModule
  --

   type WGPUProcDeviceCreateShaderModule is access function (arg1 : WGPUDevice; arg2 : access constant WGPUShaderModuleDescriptor) return WGPUShaderModule
   with Convention => C;  -- webgpu.h:2618

  --*
  -- * Proc pointer type for @ref wgpuDeviceCreateTexture:
  -- * > @copydoc wgpuDeviceCreateTexture
  --

   type WGPUProcDeviceCreateTexture is access function (arg1 : WGPUDevice; arg2 : access constant WGPUTextureDescriptor) return WGPUTexture
   with Convention => C;  -- webgpu.h:2623

  --*
  -- * Proc pointer type for @ref wgpuDeviceDestroy:
  -- * > @copydoc wgpuDeviceDestroy
  --

   type WGPUProcDeviceDestroy is access procedure (arg1 : WGPUDevice)
   with Convention => C;  -- webgpu.h:2628

  --*
  -- * Proc pointer type for @ref wgpuDeviceGetAdapterInfo:
  -- * > @copydoc wgpuDeviceGetAdapterInfo
  --

   type WGPUProcDeviceGetAdapterInfo is access function (arg1 : WGPUDevice) return WGPUAdapterInfo
   with Convention => C;  -- webgpu.h:2633

  --*
  -- * Proc pointer type for @ref wgpuDeviceGetFeatures:
  -- * > @copydoc wgpuDeviceGetFeatures
  --

   type WGPUProcDeviceGetFeatures is access procedure (arg1 : WGPUDevice; arg2 : access WGPUSupportedFeatures)
   with Convention => C;  -- webgpu.h:2638

  --*
  -- * Proc pointer type for @ref wgpuDeviceGetLimits:
  -- * > @copydoc wgpuDeviceGetLimits
  --

   type WGPUProcDeviceGetLimits is access function (arg1 : WGPUDevice; arg2 : access WGPULimits) return WGPUStatus
   with Convention => C;  -- webgpu.h:2643

  --*
  -- * Proc pointer type for @ref wgpuDeviceGetLostFuture:
  -- * > @copydoc wgpuDeviceGetLostFuture
  --

   type WGPUProcDeviceGetLostFuture is access function (arg1 : WGPUDevice) return WGPUFuture
   with Convention => C;  -- webgpu.h:2648

  --*
  -- * Proc pointer type for @ref wgpuDeviceGetQueue:
  -- * > @copydoc wgpuDeviceGetQueue
  --

   type WGPUProcDeviceGetQueue is access function (arg1 : WGPUDevice) return WGPUQueue
   with Convention => C;  -- webgpu.h:2653

  --*
  -- * Proc pointer type for @ref wgpuDeviceHasFeature:
  -- * > @copydoc wgpuDeviceHasFeature
  --

   type WGPUProcDeviceHasFeature is access function (arg1 : WGPUDevice; arg2 : WGPUFeatureName) return T_WGPUBool
   with Convention => C;  -- webgpu.h:2658

  --*
  -- * Proc pointer type for @ref wgpuDevicePopErrorScope:
  -- * > @copydoc wgpuDevicePopErrorScope
  --

   type WGPUProcDevicePopErrorScope is access function (arg1 : WGPUDevice; arg2 : WGPUPopErrorScopeCallbackInfo) return WGPUFuture
   with Convention => C;  -- webgpu.h:2663

  --*
  -- * Proc pointer type for @ref wgpuDevicePushErrorScope:
  -- * > @copydoc wgpuDevicePushErrorScope
  --

   type WGPUProcDevicePushErrorScope is access procedure (arg1 : WGPUDevice; arg2 : WGPUErrorFilter)
   with Convention => C;  -- webgpu.h:2668

  --*
  -- * Proc pointer type for @ref wgpuDeviceSetLabel:
  -- * > @copydoc wgpuDeviceSetLabel
  --

   type WGPUProcDeviceSetLabel is access procedure (arg1 : WGPUDevice; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2673

  --*
  -- * Proc pointer type for @ref wgpuDeviceAddRef.
  -- * > @copydoc wgpuDeviceAddRef
  --

   type WGPUProcDeviceAddRef is access procedure (arg1 : WGPUDevice)
   with Convention => C;  -- webgpu.h:2678

  --*
  -- * Proc pointer type for @ref wgpuDeviceRelease.
  -- * > @copydoc wgpuDeviceRelease
  --

   type WGPUProcDeviceRelease is access procedure (arg1 : WGPUDevice)
   with Convention => C;  -- webgpu.h:2683

  -- Procs of Instance
  --*
  -- * Proc pointer type for @ref wgpuInstanceCreateSurface:
  -- * > @copydoc wgpuInstanceCreateSurface
  --

   type WGPUProcInstanceCreateSurface is access function (arg1 : T_WGPUInstance; arg2 : access constant WGPUSurfaceDescriptor) return WGPUSurface
   with Convention => C;  -- webgpu.h:2690

  --*
  -- * Proc pointer type for @ref wgpuInstanceGetWGSLLanguageFeatures:
  -- * > @copydoc wgpuInstanceGetWGSLLanguageFeatures
  --

   type WGPUProcInstanceGetWGSLLanguageFeatures is access function (arg1 : T_WGPUInstance; arg2 : access WGPUSupportedWGSLLanguageFeatures) return WGPUStatus
   with Convention => C;  -- webgpu.h:2695

  --*
  -- * Proc pointer type for @ref wgpuInstanceHasWGSLLanguageFeature:
  -- * > @copydoc wgpuInstanceHasWGSLLanguageFeature
  --

   type WGPUProcInstanceHasWGSLLanguageFeature is access function (arg1 : T_WGPUInstance; arg2 : WGPUWGSLLanguageFeatureName) return T_WGPUBool
   with Convention => C;  -- webgpu.h:2700

  --*
  -- * Proc pointer type for @ref wgpuInstanceProcessEvents:
  -- * > @copydoc wgpuInstanceProcessEvents
  --

   type WGPUProcInstanceProcessEvents is access procedure (arg1 : T_WGPUInstance)
   with Convention => C;  -- webgpu.h:2705

  --*
  -- * Proc pointer type for @ref wgpuInstanceRequestAdapter:
  -- * > @copydoc wgpuInstanceRequestAdapter
  --

   type WGPUProcInstanceRequestAdapter is access function
        (arg1 : T_WGPUInstance;
         arg2 : access constant WGPURequestAdapterOptions;
         arg3 : WGPURequestAdapterCallbackInfo) return WGPUFuture
   with Convention => C;  -- webgpu.h:2710

  --*
  -- * Proc pointer type for @ref wgpuInstanceWaitAny:
  -- * > @copydoc wgpuInstanceWaitAny
  --

   type WGPUProcInstanceWaitAny is access function
        (arg1 : T_WGPUInstance;
         arg2 : T_Size;
         arg3 : access WGPUFutureWaitInfo;
         arg4 : bits_stdint_uintn_h.uint64_t) return WGPUWaitStatus
   with Convention => C;  -- webgpu.h:2715

  --*
  -- * Proc pointer type for @ref wgpuInstanceAddRef.
  -- * > @copydoc wgpuInstanceAddRef
  --

   type WGPUProcInstanceAddRef is access procedure (arg1 : T_WGPUInstance)
   with Convention => C;  -- webgpu.h:2720

  --*
  -- * Proc pointer type for @ref wgpuInstanceRelease.
  -- * > @copydoc wgpuInstanceRelease
  --

   type WGPUProcInstanceRelease is access procedure (arg1 : T_WGPUInstance)
   with Convention => C;  -- webgpu.h:2725

  -- Procs of PipelineLayout
  --*
  -- * Proc pointer type for @ref wgpuPipelineLayoutSetLabel:
  -- * > @copydoc wgpuPipelineLayoutSetLabel
  --

   type WGPUProcPipelineLayoutSetLabel is access procedure (arg1 : WGPUPipelineLayout; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2732

  --*
  -- * Proc pointer type for @ref wgpuPipelineLayoutAddRef.
  -- * > @copydoc wgpuPipelineLayoutAddRef
  --

   type WGPUProcPipelineLayoutAddRef is access procedure (arg1 : WGPUPipelineLayout)
   with Convention => C;  -- webgpu.h:2737

  --*
  -- * Proc pointer type for @ref wgpuPipelineLayoutRelease.
  -- * > @copydoc wgpuPipelineLayoutRelease
  --

   type WGPUProcPipelineLayoutRelease is access procedure (arg1 : WGPUPipelineLayout)
   with Convention => C;  -- webgpu.h:2742

  -- Procs of QuerySet
  --*
  -- * Proc pointer type for @ref wgpuQuerySetDestroy:
  -- * > @copydoc wgpuQuerySetDestroy
  --

   type WGPUProcQuerySetDestroy is access procedure (arg1 : WGPUQuerySet)
   with Convention => C;  -- webgpu.h:2749

  --*
  -- * Proc pointer type for @ref wgpuQuerySetGetCount:
  -- * > @copydoc wgpuQuerySetGetCount
  --

   type WGPUProcQuerySetGetCount is access function (arg1 : WGPUQuerySet) return bits_stdint_uintn_h.uint32_t
   with Convention => C;  -- webgpu.h:2754

  --*
  -- * Proc pointer type for @ref wgpuQuerySetGetType:
  -- * > @copydoc wgpuQuerySetGetType
  --

   type WGPUProcQuerySetGetType is access function (arg1 : WGPUQuerySet) return WGPUQueryType
   with Convention => C;  -- webgpu.h:2759

  --*
  -- * Proc pointer type for @ref wgpuQuerySetSetLabel:
  -- * > @copydoc wgpuQuerySetSetLabel
  --

   type WGPUProcQuerySetSetLabel is access procedure (arg1 : WGPUQuerySet; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2764

  --*
  -- * Proc pointer type for @ref wgpuQuerySetAddRef.
  -- * > @copydoc wgpuQuerySetAddRef
  --

   type WGPUProcQuerySetAddRef is access procedure (arg1 : WGPUQuerySet)
   with Convention => C;  -- webgpu.h:2769

  --*
  -- * Proc pointer type for @ref wgpuQuerySetRelease.
  -- * > @copydoc wgpuQuerySetRelease
  --

   type WGPUProcQuerySetRelease is access procedure (arg1 : WGPUQuerySet)
   with Convention => C;  -- webgpu.h:2774

  -- Procs of Queue
  --*
  -- * Proc pointer type for @ref wgpuQueueOnSubmittedWorkDone:
  -- * > @copydoc wgpuQueueOnSubmittedWorkDone
  --

   type WGPUProcQueueOnSubmittedWorkDone is access function (arg1 : WGPUQueue; arg2 : WGPUQueueWorkDoneCallbackInfo) return WGPUFuture
   with Convention => C;  -- webgpu.h:2781

  --*
  -- * Proc pointer type for @ref wgpuQueueSetLabel:
  -- * > @copydoc wgpuQueueSetLabel
  --

   type WGPUProcQueueSetLabel is access procedure (arg1 : WGPUQueue; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2786

  --*
  -- * Proc pointer type for @ref wgpuQueueSubmit:
  -- * > @copydoc wgpuQueueSubmit
  --

   type WGPUProcQueueSubmit is access procedure
        (arg1 : WGPUQueue;
         arg2 : T_Size;
         arg3 : System.Address)
   with Convention => C;  -- webgpu.h:2791

  --*
  -- * Proc pointer type for @ref wgpuQueueWriteBuffer:
  -- * > @copydoc wgpuQueueWriteBuffer
  --

   type WGPUProcQueueWriteBuffer is access procedure
        (arg1 : WGPUQueue;
         arg2 : WGPUBuffer;
         arg3 : bits_stdint_uintn_h.uint64_t;
         arg4 : System.Address;
         arg5 : T_Size)
   with Convention => C;  -- webgpu.h:2796

  --*
  -- * Proc pointer type for @ref wgpuQueueWriteTexture:
  -- * > @copydoc wgpuQueueWriteTexture
  --

   type WGPUProcQueueWriteTexture is access procedure
        (arg1 : WGPUQueue;
         arg2 : access constant WGPUTexelCopyTextureInfo;
         arg3 : System.Address;
         arg4 : T_Size;
         arg5 : access constant WGPUTexelCopyBufferLayout;
         arg6 : access constant WGPUExtent3D)
   with Convention => C;  -- webgpu.h:2801

  --*
  -- * Proc pointer type for @ref wgpuQueueAddRef.
  -- * > @copydoc wgpuQueueAddRef
  --

   type WGPUProcQueueAddRef is access procedure (arg1 : WGPUQueue)
   with Convention => C;  -- webgpu.h:2806

  --*
  -- * Proc pointer type for @ref wgpuQueueRelease.
  -- * > @copydoc wgpuQueueRelease
  --

   type WGPUProcQueueRelease is access procedure (arg1 : WGPUQueue)
   with Convention => C;  -- webgpu.h:2811

  -- Procs of RenderBundle
  --*
  -- * Proc pointer type for @ref wgpuRenderBundleSetLabel:
  -- * > @copydoc wgpuRenderBundleSetLabel
  --

   type WGPUProcRenderBundleSetLabel is access procedure (arg1 : WGPURenderBundle; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2818

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleAddRef.
  -- * > @copydoc wgpuRenderBundleAddRef
  --

   type WGPUProcRenderBundleAddRef is access procedure (arg1 : WGPURenderBundle)
   with Convention => C;  -- webgpu.h:2823

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleRelease.
  -- * > @copydoc wgpuRenderBundleRelease
  --

   type WGPUProcRenderBundleRelease is access procedure (arg1 : WGPURenderBundle)
   with Convention => C;  -- webgpu.h:2828

  -- Procs of RenderBundleEncoder
  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderDraw:
  -- * > @copydoc wgpuRenderBundleEncoderDraw
  --

   type WGPUProcRenderBundleEncoderDraw is access procedure
        (arg1 : WGPURenderBundleEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : bits_stdint_uintn_h.uint32_t;
         arg4 : bits_stdint_uintn_h.uint32_t;
         arg5 : bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2835

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndexed:
  -- * > @copydoc wgpuRenderBundleEncoderDrawIndexed
  --

   type WGPUProcRenderBundleEncoderDrawIndexed is access procedure
        (arg1 : WGPURenderBundleEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : bits_stdint_uintn_h.uint32_t;
         arg4 : bits_stdint_uintn_h.uint32_t;
         arg5 : bits_stdint_intn_h.int32_t;
         arg6 : bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2840

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndexedIndirect:
  -- * > @copydoc wgpuRenderBundleEncoderDrawIndexedIndirect
  --

   type WGPUProcRenderBundleEncoderDrawIndexedIndirect is access procedure
        (arg1 : WGPURenderBundleEncoder;
         arg2 : WGPUBuffer;
         arg3 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2845

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderDrawIndirect:
  -- * > @copydoc wgpuRenderBundleEncoderDrawIndirect
  --

   type WGPUProcRenderBundleEncoderDrawIndirect is access procedure
        (arg1 : WGPURenderBundleEncoder;
         arg2 : WGPUBuffer;
         arg3 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2850

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderFinish:
  -- * > @copydoc wgpuRenderBundleEncoderFinish
  --

   type WGPUProcRenderBundleEncoderFinish is access function (arg1 : WGPURenderBundleEncoder; arg2 : access constant WGPURenderBundleDescriptor) return WGPURenderBundle
   with Convention => C;  -- webgpu.h:2855

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderInsertDebugMarker:
  -- * > @copydoc wgpuRenderBundleEncoderInsertDebugMarker
  --

   type WGPUProcRenderBundleEncoderInsertDebugMarker is access procedure (arg1 : WGPURenderBundleEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2860

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderPopDebugGroup:
  -- * > @copydoc wgpuRenderBundleEncoderPopDebugGroup
  --

   type WGPUProcRenderBundleEncoderPopDebugGroup is access procedure (arg1 : WGPURenderBundleEncoder)
   with Convention => C;  -- webgpu.h:2865

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderPushDebugGroup:
  -- * > @copydoc wgpuRenderBundleEncoderPushDebugGroup
  --

   type WGPUProcRenderBundleEncoderPushDebugGroup is access procedure (arg1 : WGPURenderBundleEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2870

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderSetBindGroup:
  -- * > @copydoc wgpuRenderBundleEncoderSetBindGroup
  --

   type WGPUProcRenderBundleEncoderSetBindGroup is access procedure
        (arg1 : WGPURenderBundleEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : WGPUBindGroup;
         arg4 : T_Size;
         arg5 : access bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2875

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderSetIndexBuffer:
  -- * > @copydoc wgpuRenderBundleEncoderSetIndexBuffer
  --

   type WGPUProcRenderBundleEncoderSetIndexBuffer is access procedure
        (arg1 : WGPURenderBundleEncoder;
         arg2 : WGPUBuffer;
         arg3 : WGPUIndexFormat;
         arg4 : bits_stdint_uintn_h.uint64_t;
         arg5 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2880

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderSetLabel:
  -- * > @copydoc wgpuRenderBundleEncoderSetLabel
  --

   type WGPUProcRenderBundleEncoderSetLabel is access procedure (arg1 : WGPURenderBundleEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2885

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderSetPipeline:
  -- * > @copydoc wgpuRenderBundleEncoderSetPipeline
  --

   type WGPUProcRenderBundleEncoderSetPipeline is access procedure (arg1 : WGPURenderBundleEncoder; arg2 : WGPURenderPipeline)
   with Convention => C;  -- webgpu.h:2890

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderSetVertexBuffer:
  -- * > @copydoc wgpuRenderBundleEncoderSetVertexBuffer
  --

   type WGPUProcRenderBundleEncoderSetVertexBuffer is access procedure
        (arg1 : WGPURenderBundleEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : WGPUBuffer;
         arg4 : bits_stdint_uintn_h.uint64_t;
         arg5 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2895

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderAddRef.
  -- * > @copydoc wgpuRenderBundleEncoderAddRef
  --

   type WGPUProcRenderBundleEncoderAddRef is access procedure (arg1 : WGPURenderBundleEncoder)
   with Convention => C;  -- webgpu.h:2900

  --*
  -- * Proc pointer type for @ref wgpuRenderBundleEncoderRelease.
  -- * > @copydoc wgpuRenderBundleEncoderRelease
  --

   type WGPUProcRenderBundleEncoderRelease is access procedure (arg1 : WGPURenderBundleEncoder)
   with Convention => C;  -- webgpu.h:2905

  -- Procs of RenderPassEncoder
  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderBeginOcclusionQuery:
  -- * > @copydoc wgpuRenderPassEncoderBeginOcclusionQuery
  --

   type WGPUProcRenderPassEncoderBeginOcclusionQuery is access procedure (arg1 : WGPURenderPassEncoder; arg2 : bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2912

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderDraw:
  -- * > @copydoc wgpuRenderPassEncoderDraw
  --

   type WGPUProcRenderPassEncoderDraw is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : bits_stdint_uintn_h.uint32_t;
         arg4 : bits_stdint_uintn_h.uint32_t;
         arg5 : bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2917

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderDrawIndexed:
  -- * > @copydoc wgpuRenderPassEncoderDrawIndexed
  --

   type WGPUProcRenderPassEncoderDrawIndexed is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : bits_stdint_uintn_h.uint32_t;
         arg4 : bits_stdint_uintn_h.uint32_t;
         arg5 : bits_stdint_intn_h.int32_t;
         arg6 : bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2922

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderDrawIndexedIndirect:
  -- * > @copydoc wgpuRenderPassEncoderDrawIndexedIndirect
  --

   type WGPUProcRenderPassEncoderDrawIndexedIndirect is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : WGPUBuffer;
         arg3 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2927

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderDrawIndirect:
  -- * > @copydoc wgpuRenderPassEncoderDrawIndirect
  --

   type WGPUProcRenderPassEncoderDrawIndirect is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : WGPUBuffer;
         arg3 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2932

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderEnd:
  -- * > @copydoc wgpuRenderPassEncoderEnd
  --

   type WGPUProcRenderPassEncoderEnd is access procedure (arg1 : WGPURenderPassEncoder)
   with Convention => C;  -- webgpu.h:2937

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderEndOcclusionQuery:
  -- * > @copydoc wgpuRenderPassEncoderEndOcclusionQuery
  --

   type WGPUProcRenderPassEncoderEndOcclusionQuery is access procedure (arg1 : WGPURenderPassEncoder)
   with Convention => C;  -- webgpu.h:2942

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderExecuteBundles:
  -- * > @copydoc wgpuRenderPassEncoderExecuteBundles
  --

   type WGPUProcRenderPassEncoderExecuteBundles is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : T_Size;
         arg3 : System.Address)
   with Convention => C;  -- webgpu.h:2947

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderInsertDebugMarker:
  -- * > @copydoc wgpuRenderPassEncoderInsertDebugMarker
  --

   type WGPUProcRenderPassEncoderInsertDebugMarker is access procedure (arg1 : WGPURenderPassEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2952

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderPopDebugGroup:
  -- * > @copydoc wgpuRenderPassEncoderPopDebugGroup
  --

   type WGPUProcRenderPassEncoderPopDebugGroup is access procedure (arg1 : WGPURenderPassEncoder)
   with Convention => C;  -- webgpu.h:2957

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderPushDebugGroup:
  -- * > @copydoc wgpuRenderPassEncoderPushDebugGroup
  --

   type WGPUProcRenderPassEncoderPushDebugGroup is access procedure (arg1 : WGPURenderPassEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2962

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderSetBindGroup:
  -- * > @copydoc wgpuRenderPassEncoderSetBindGroup
  --

   type WGPUProcRenderPassEncoderSetBindGroup is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : WGPUBindGroup;
         arg4 : T_Size;
         arg5 : access bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2967

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderSetBlendConstant:
  -- * > @copydoc wgpuRenderPassEncoderSetBlendConstant
  --

   type WGPUProcRenderPassEncoderSetBlendConstant is access procedure (arg1 : WGPURenderPassEncoder; arg2 : access constant WGPUColor)
   with Convention => C;  -- webgpu.h:2972

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderSetIndexBuffer:
  -- * > @copydoc wgpuRenderPassEncoderSetIndexBuffer
  --

   type WGPUProcRenderPassEncoderSetIndexBuffer is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : WGPUBuffer;
         arg3 : WGPUIndexFormat;
         arg4 : bits_stdint_uintn_h.uint64_t;
         arg5 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:2977

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderSetLabel:
  -- * > @copydoc wgpuRenderPassEncoderSetLabel
  --

   type WGPUProcRenderPassEncoderSetLabel is access procedure (arg1 : WGPURenderPassEncoder; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:2982

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderSetPipeline:
  -- * > @copydoc wgpuRenderPassEncoderSetPipeline
  --

   type WGPUProcRenderPassEncoderSetPipeline is access procedure (arg1 : WGPURenderPassEncoder; arg2 : WGPURenderPipeline)
   with Convention => C;  -- webgpu.h:2987

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderSetScissorRect:
  -- * > @copydoc wgpuRenderPassEncoderSetScissorRect
  --

   type WGPUProcRenderPassEncoderSetScissorRect is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : bits_stdint_uintn_h.uint32_t;
         arg4 : bits_stdint_uintn_h.uint32_t;
         arg5 : bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2992

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderSetStencilReference:
  -- * > @copydoc wgpuRenderPassEncoderSetStencilReference
  --

   type WGPUProcRenderPassEncoderSetStencilReference is access procedure (arg1 : WGPURenderPassEncoder; arg2 : bits_stdint_uintn_h.uint32_t)
   with Convention => C;  -- webgpu.h:2997

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderSetVertexBuffer:
  -- * > @copydoc wgpuRenderPassEncoderSetVertexBuffer
  --

   type WGPUProcRenderPassEncoderSetVertexBuffer is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : bits_stdint_uintn_h.uint32_t;
         arg3 : WGPUBuffer;
         arg4 : bits_stdint_uintn_h.uint64_t;
         arg5 : bits_stdint_uintn_h.uint64_t)
   with Convention => C;  -- webgpu.h:3002

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderSetViewport:
  -- * > @copydoc wgpuRenderPassEncoderSetViewport
  --

   type WGPUProcRenderPassEncoderSetViewport is access procedure
        (arg1 : WGPURenderPassEncoder;
         arg2 : float;
         arg3 : float;
         arg4 : float;
         arg5 : float;
         arg6 : float;
         arg7 : float)
   with Convention => C;  -- webgpu.h:3007

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderAddRef.
  -- * > @copydoc wgpuRenderPassEncoderAddRef
  --

   type WGPUProcRenderPassEncoderAddRef is access procedure (arg1 : WGPURenderPassEncoder)
   with Convention => C;  -- webgpu.h:3012

  --*
  -- * Proc pointer type for @ref wgpuRenderPassEncoderRelease.
  -- * > @copydoc wgpuRenderPassEncoderRelease
  --

   type WGPUProcRenderPassEncoderRelease is access procedure (arg1 : WGPURenderPassEncoder)
   with Convention => C;  -- webgpu.h:3017

  -- Procs of RenderPipeline
  --*
  -- * Proc pointer type for @ref wgpuRenderPipelineGetBindGroupLayout:
  -- * > @copydoc wgpuRenderPipelineGetBindGroupLayout
  --

   type WGPUProcRenderPipelineGetBindGroupLayout is access function (arg1 : WGPURenderPipeline; arg2 : bits_stdint_uintn_h.uint32_t) return WGPUBindGroupLayout
   with Convention => C;  -- webgpu.h:3024

  --*
  -- * Proc pointer type for @ref wgpuRenderPipelineSetLabel:
  -- * > @copydoc wgpuRenderPipelineSetLabel
  --

   type WGPUProcRenderPipelineSetLabel is access procedure (arg1 : WGPURenderPipeline; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:3029

  --*
  -- * Proc pointer type for @ref wgpuRenderPipelineAddRef.
  -- * > @copydoc wgpuRenderPipelineAddRef
  --

   type WGPUProcRenderPipelineAddRef is access procedure (arg1 : WGPURenderPipeline)
   with Convention => C;  -- webgpu.h:3034

  --*
  -- * Proc pointer type for @ref wgpuRenderPipelineRelease.
  -- * > @copydoc wgpuRenderPipelineRelease
  --

   type WGPUProcRenderPipelineRelease is access procedure (arg1 : WGPURenderPipeline)
   with Convention => C;  -- webgpu.h:3039

  -- Procs of Sampler
  --*
  -- * Proc pointer type for @ref wgpuSamplerSetLabel:
  -- * > @copydoc wgpuSamplerSetLabel
  --

   type WGPUProcSamplerSetLabel is access procedure (arg1 : WGPUSampler; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:3046

  --*
  -- * Proc pointer type for @ref wgpuSamplerAddRef.
  -- * > @copydoc wgpuSamplerAddRef
  --

   type WGPUProcSamplerAddRef is access procedure (arg1 : WGPUSampler)
   with Convention => C;  -- webgpu.h:3051

  --*
  -- * Proc pointer type for @ref wgpuSamplerRelease.
  -- * > @copydoc wgpuSamplerRelease
  --

   type WGPUProcSamplerRelease is access procedure (arg1 : WGPUSampler)
   with Convention => C;  -- webgpu.h:3056

  -- Procs of ShaderModule
  --*
  -- * Proc pointer type for @ref wgpuShaderModuleGetCompilationInfo:
  -- * > @copydoc wgpuShaderModuleGetCompilationInfo
  --

   type WGPUProcShaderModuleGetCompilationInfo is access function (arg1 : WGPUShaderModule; arg2 : WGPUCompilationInfoCallbackInfo) return WGPUFuture
   with Convention => C;  -- webgpu.h:3063

  --*
  -- * Proc pointer type for @ref wgpuShaderModuleSetLabel:
  -- * > @copydoc wgpuShaderModuleSetLabel
  --

   type WGPUProcShaderModuleSetLabel is access procedure (arg1 : WGPUShaderModule; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:3068

  --*
  -- * Proc pointer type for @ref wgpuShaderModuleAddRef.
  -- * > @copydoc wgpuShaderModuleAddRef
  --

   type WGPUProcShaderModuleAddRef is access procedure (arg1 : WGPUShaderModule)
   with Convention => C;  -- webgpu.h:3073

  --*
  -- * Proc pointer type for @ref wgpuShaderModuleRelease.
  -- * > @copydoc wgpuShaderModuleRelease
  --

   type WGPUProcShaderModuleRelease is access procedure (arg1 : WGPUShaderModule)
   with Convention => C;  -- webgpu.h:3078

  -- Procs of SupportedFeatures
  --*
  -- * Proc pointer type for @ref wgpuSupportedFeaturesFreeMembers:
  -- * > @copydoc wgpuSupportedFeaturesFreeMembers
  --

   type WGPUProcSupportedFeaturesFreeMembers is access procedure (arg1 : WGPUSupportedFeatures)
   with Convention => C;  -- webgpu.h:3085

  -- Procs of SupportedWGSLLanguageFeatures
  --*
  -- * Proc pointer type for @ref wgpuSupportedWGSLLanguageFeaturesFreeMembers:
  -- * > @copydoc wgpuSupportedWGSLLanguageFeaturesFreeMembers
  --

   type WGPUProcSupportedWGSLLanguageFeaturesFreeMembers is access procedure (arg1 : WGPUSupportedWGSLLanguageFeatures)
   with Convention => C;  -- webgpu.h:3092

  -- Procs of Surface
  --*
  -- * Proc pointer type for @ref wgpuSurfaceConfigure:
  -- * > @copydoc wgpuSurfaceConfigure
  --

   type WGPUProcSurfaceConfigure is access procedure (arg1 : WGPUSurface; arg2 : access constant WGPUSurfaceConfiguration)
   with Convention => C;  -- webgpu.h:3099

  --*
  -- * Proc pointer type for @ref wgpuSurfaceGetCapabilities:
  -- * > @copydoc wgpuSurfaceGetCapabilities
  --

   type WGPUProcSurfaceGetCapabilities is access function
        (arg1 : WGPUSurface;
         arg2 : WGPUAdapter;
         arg3 : access WGPUSurfaceCapabilities) return WGPUStatus
   with Convention => C;  -- webgpu.h:3104

  --*
  -- * Proc pointer type for @ref wgpuSurfaceGetCurrentTexture:
  -- * > @copydoc wgpuSurfaceGetCurrentTexture
  --

   type WGPUProcSurfaceGetCurrentTexture is access procedure (arg1 : WGPUSurface; arg2 : access WGPUSurfaceTexture)
   with Convention => C;  -- webgpu.h:3109

  --*
  -- * Proc pointer type for @ref wgpuSurfacePresent:
  -- * > @copydoc wgpuSurfacePresent
  --

   type WGPUProcSurfacePresent is access function (arg1 : WGPUSurface) return WGPUStatus
   with Convention => C;  -- webgpu.h:3114

  --*
  -- * Proc pointer type for @ref wgpuSurfaceSetLabel:
  -- * > @copydoc wgpuSurfaceSetLabel
  --

   type WGPUProcSurfaceSetLabel is access procedure (arg1 : WGPUSurface; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:3119

  --*
  -- * Proc pointer type for @ref wgpuSurfaceUnconfigure:
  -- * > @copydoc wgpuSurfaceUnconfigure
  --

   type WGPUProcSurfaceUnconfigure is access procedure (arg1 : WGPUSurface)
   with Convention => C;  -- webgpu.h:3124

  --*
  -- * Proc pointer type for @ref wgpuSurfaceAddRef.
  -- * > @copydoc wgpuSurfaceAddRef
  --

   type WGPUProcSurfaceAddRef is access procedure (arg1 : WGPUSurface)
   with Convention => C;  -- webgpu.h:3129

  --*
  -- * Proc pointer type for @ref wgpuSurfaceRelease.
  -- * > @copydoc wgpuSurfaceRelease
  --

   type WGPUProcSurfaceRelease is access procedure (arg1 : WGPUSurface)
   with Convention => C;  -- webgpu.h:3134

  -- Procs of SurfaceCapabilities
  --*
  -- * Proc pointer type for @ref wgpuSurfaceCapabilitiesFreeMembers:
  -- * > @copydoc wgpuSurfaceCapabilitiesFreeMembers
  --

   type WGPUProcSurfaceCapabilitiesFreeMembers is access procedure (arg1 : WGPUSurfaceCapabilities)
   with Convention => C;  -- webgpu.h:3141

  -- Procs of Texture
  --*
  -- * Proc pointer type for @ref wgpuTextureCreateView:
  -- * > @copydoc wgpuTextureCreateView
  --

   type WGPUProcTextureCreateView is access function (arg1 : WGPUTexture; arg2 : access constant WGPUTextureViewDescriptor) return WGPUTextureView
   with Convention => C;  -- webgpu.h:3148

  --*
  -- * Proc pointer type for @ref wgpuTextureDestroy:
  -- * > @copydoc wgpuTextureDestroy
  --

   type WGPUProcTextureDestroy is access procedure (arg1 : WGPUTexture)
   with Convention => C;  -- webgpu.h:3153

  --*
  -- * Proc pointer type for @ref wgpuTextureGetDepthOrArrayLayers:
  -- * > @copydoc wgpuTextureGetDepthOrArrayLayers
  --

   type WGPUProcTextureGetDepthOrArrayLayers is access function (arg1 : WGPUTexture) return bits_stdint_uintn_h.uint32_t
   with Convention => C;  -- webgpu.h:3158

  --*
  -- * Proc pointer type for @ref wgpuTextureGetDimension:
  -- * > @copydoc wgpuTextureGetDimension
  --

   type WGPUProcTextureGetDimension is access function (arg1 : WGPUTexture) return WGPUTextureDimension
   with Convention => C;  -- webgpu.h:3163

  --*
  -- * Proc pointer type for @ref wgpuTextureGetFormat:
  -- * > @copydoc wgpuTextureGetFormat
  --

   type WGPUProcTextureGetFormat is access function (arg1 : WGPUTexture) return WGPUTextureFormat
   with Convention => C;  -- webgpu.h:3168

  --*
  -- * Proc pointer type for @ref wgpuTextureGetHeight:
  -- * > @copydoc wgpuTextureGetHeight
  --

   type WGPUProcTextureGetHeight is access function (arg1 : WGPUTexture) return bits_stdint_uintn_h.uint32_t
   with Convention => C;  -- webgpu.h:3173

  --*
  -- * Proc pointer type for @ref wgpuTextureGetMipLevelCount:
  -- * > @copydoc wgpuTextureGetMipLevelCount
  --

   type WGPUProcTextureGetMipLevelCount is access function (arg1 : WGPUTexture) return bits_stdint_uintn_h.uint32_t
   with Convention => C;  -- webgpu.h:3178

  --*
  -- * Proc pointer type for @ref wgpuTextureGetSampleCount:
  -- * > @copydoc wgpuTextureGetSampleCount
  --

   type WGPUProcTextureGetSampleCount is access function (arg1 : WGPUTexture) return bits_stdint_uintn_h.uint32_t
   with Convention => C;  -- webgpu.h:3183

  --*
  -- * Proc pointer type for @ref wgpuTextureGetUsage:
  -- * > @copydoc wgpuTextureGetUsage
  --

   type WGPUProcTextureGetUsage is access function (arg1 : WGPUTexture) return WGPUTextureUsage
   with Convention => C;  -- webgpu.h:3188

  --*
  -- * Proc pointer type for @ref wgpuTextureGetWidth:
  -- * > @copydoc wgpuTextureGetWidth
  --

   type WGPUProcTextureGetWidth is access function (arg1 : WGPUTexture) return bits_stdint_uintn_h.uint32_t
   with Convention => C;  -- webgpu.h:3193

  --*
  -- * Proc pointer type for @ref wgpuTextureSetLabel:
  -- * > @copydoc wgpuTextureSetLabel
  --

   type WGPUProcTextureSetLabel is access procedure (arg1 : WGPUTexture; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:3198

  --*
  -- * Proc pointer type for @ref wgpuTextureAddRef.
  -- * > @copydoc wgpuTextureAddRef
  --

   type WGPUProcTextureAddRef is access procedure (arg1 : WGPUTexture)
   with Convention => C;  -- webgpu.h:3203

  --*
  -- * Proc pointer type for @ref wgpuTextureRelease.
  -- * > @copydoc wgpuTextureRelease
  --

   type WGPUProcTextureRelease is access procedure (arg1 : WGPUTexture)
   with Convention => C;  -- webgpu.h:3208

  -- Procs of TextureView
  --*
  -- * Proc pointer type for @ref wgpuTextureViewSetLabel:
  -- * > @copydoc wgpuTextureViewSetLabel
  --

   type WGPUProcTextureViewSetLabel is access procedure (arg1 : WGPUTextureView; arg2 : WGPUStringView)
   with Convention => C;  -- webgpu.h:3215

  --*
  -- * Proc pointer type for @ref wgpuTextureViewAddRef.
  -- * > @copydoc wgpuTextureViewAddRef
  --

   type WGPUProcTextureViewAddRef is access procedure (arg1 : WGPUTextureView)
   with Convention => C;  -- webgpu.h:3220

  --*
  -- * Proc pointer type for @ref wgpuTextureViewRelease.
  -- * > @copydoc wgpuTextureViewRelease
  --

   type WGPUProcTextureViewRelease is access procedure (arg1 : WGPUTextureView)
   with Convention => C;  -- webgpu.h:3225

  --*
  -- * \defgroup GlobalFunctions Global Functions
  -- * \brief Functions that are not specific to an object.
  -- *
  -- * @{
  --

  --*
  -- * Create a T_WGPUInstance
  --

   function wgpuCreateInstance (descriptor : access constant T_WGPUInstanceDescriptor) return T_WGPUInstance  -- webgpu.h:3239
   with Import => True,
        Convention => C,
        External_Name => "wgpuCreateInstance";

  --*
  -- * Query the supported instance capabilities.
  -- *
  -- * @param capabilities
  -- * The supported instance capabilities
  -- *
  -- * @returns
  -- * Indicates if there was an @ref OutStructChainError.
  --

   function wgpuGetInstanceCapabilities (capabilities : access T_WGPUInstanceCapabilities) return WGPUStatus  -- webgpu.h:3249
   with Import => True,
        Convention => C,
        External_Name => "wgpuGetInstanceCapabilities";

  --*
  -- * Returns the "procedure address" (function pointer) of the named function.
  -- * The result must be cast to the appropriate proc pointer type.
  --

   function wgpuGetProcAddress (procName : WGPUStringView) return WGPUProc  -- webgpu.h:3254
   with Import => True,
        Convention => C,
        External_Name => "wgpuGetProcAddress";

  --* @}
  --*
  -- * \defgroup Methods
  -- * \brief Functions that are relative to a specific object.
  -- *
  -- * @{
  --

  --*
  -- * \defgroup WGPUAdapterMethods WGPUAdapter methods
  -- * \brief Functions whose first argument has type WGPUAdapter.
  -- *
  -- * @{
  --

  --*
  -- * Get the list of @ref WGPUFeatureName values supported by the adapter.
  -- *
  -- * @param features
  -- * This parameter is @ref ReturnedWithOwnership.
  --

   procedure wgpuAdapterGetFeatures (adapter : WGPUAdapter; features : access WGPUSupportedFeatures)  -- webgpu.h:3278
   with Import => True,
        Convention => C,
        External_Name => "wgpuAdapterGetFeatures";

  --*
  -- * @param info
  -- * This parameter is @ref ReturnedWithOwnership.
  -- *
  -- * @returns
  -- * Indicates if there was an @ref OutStructChainError.
  --

   function wgpuAdapterGetInfo (adapter : WGPUAdapter; info : access WGPUAdapterInfo) return WGPUStatus  -- webgpu.h:3286
   with Import => True,
        Convention => C,
        External_Name => "wgpuAdapterGetInfo";

  --*
  -- * @returns
  -- * Indicates if there was an @ref OutStructChainError.
  --

   function wgpuAdapterGetLimits (adapter : WGPUAdapter; limits : access WGPULimits) return WGPUStatus  -- webgpu.h:3291
   with Import => True,
        Convention => C,
        External_Name => "wgpuAdapterGetLimits";

   function wgpuAdapterHasFeature (adapter : WGPUAdapter; feature : WGPUFeatureName) return T_WGPUBool  -- webgpu.h:3292
   with Import => True,
        Convention => C,
        External_Name => "wgpuAdapterHasFeature";

   function wgpuAdapterRequestDevice
     (adapter : WGPUAdapter;
      descriptor : access constant WGPUDeviceDescriptor;
      callbackInfo : WGPURequestDeviceCallbackInfo) return WGPUFuture  -- webgpu.h:3293
   with Import => True,
        Convention => C,
        External_Name => "wgpuAdapterRequestDevice";

   procedure wgpuAdapterAddRef (adapter : WGPUAdapter)  -- webgpu.h:3294
   with Import => True,
        Convention => C,
        External_Name => "wgpuAdapterAddRef";

   procedure wgpuAdapterRelease (adapter : WGPUAdapter)  -- webgpu.h:3295
   with Import => True,
        Convention => C,
        External_Name => "wgpuAdapterRelease";

  --* @}
  --*
  -- * \defgroup WGPUAdapterInfoMethods WGPUAdapterInfo methods
  -- * \brief Functions whose first argument has type WGPUAdapterInfo.
  -- *
  -- * @{
  --

  --*
  -- * Frees array members of WGPUAdapterInfo which were allocated by the API.
  --

   procedure wgpuAdapterInfoFreeMembers (adapterInfo : WGPUAdapterInfo)  -- webgpu.h:3309
   with Import => True,
        Convention => C,
        External_Name => "wgpuAdapterInfoFreeMembers";

  --* @}
  --*
  -- * \defgroup WGPUBindGroupMethods WGPUBindGroup methods
  -- * \brief Functions whose first argument has type WGPUBindGroup.
  -- *
  -- * @{
  --

   procedure wgpuBindGroupSetLabel (bindGroup : WGPUBindGroup; label : WGPUStringView)  -- webgpu.h:3320
   with Import => True,
        Convention => C,
        External_Name => "wgpuBindGroupSetLabel";

   procedure wgpuBindGroupAddRef (bindGroup : WGPUBindGroup)  -- webgpu.h:3321
   with Import => True,
        Convention => C,
        External_Name => "wgpuBindGroupAddRef";

   procedure wgpuBindGroupRelease (bindGroup : WGPUBindGroup)  -- webgpu.h:3322
   with Import => True,
        Convention => C,
        External_Name => "wgpuBindGroupRelease";

  --* @}
  --*
  -- * \defgroup WGPUBindGroupLayoutMethods WGPUBindGroupLayout methods
  -- * \brief Functions whose first argument has type WGPUBindGroupLayout.
  -- *
  -- * @{
  --

   procedure wgpuBindGroupLayoutSetLabel (bindGroupLayout : WGPUBindGroupLayout; label : WGPUStringView)  -- webgpu.h:3333
   with Import => True,
        Convention => C,
        External_Name => "wgpuBindGroupLayoutSetLabel";

   procedure wgpuBindGroupLayoutAddRef (bindGroupLayout : WGPUBindGroupLayout)  -- webgpu.h:3334
   with Import => True,
        Convention => C,
        External_Name => "wgpuBindGroupLayoutAddRef";

   procedure wgpuBindGroupLayoutRelease (bindGroupLayout : WGPUBindGroupLayout)  -- webgpu.h:3335
   with Import => True,
        Convention => C,
        External_Name => "wgpuBindGroupLayoutRelease";

  --* @}
  --*
  -- * \defgroup WGPUBufferMethods WGPUBuffer methods
  -- * \brief Functions whose first argument has type WGPUBuffer.
  -- *
  -- * @{
  --

   procedure wgpuBufferDestroy (buffer : WGPUBuffer)  -- webgpu.h:3346
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferDestroy";

  --*
  -- * @param offset
  -- * Byte offset relative to the beginning of the buffer.
  -- *
  -- * @param size
  -- * Byte size of the range to get. The returned pointer is valid for exactly this many bytes.
  -- *
  -- * @returns
  -- * Returns a const pointer to beginning of the mapped range.
  -- * It must not be written; writing to this range causes undefined behavior.
  -- * Returns `NULL` with @ref ImplementationDefinedLogging if:
  -- *
  -- * - There is any content-timeline error as defined in the WebGPU specification for `getMappedRange()` (alignments, overlaps, etc.)
  -- *   **except** for overlaps with other *const* ranges, which are allowed in C.
  -- *   (JS does not allow this because const ranges do not exist.)
  --

   function wgpuBufferGetConstMappedRange
     (buffer : WGPUBuffer;
      offset : T_Size;
      size : T_Size) return System.Address  -- webgpu.h:3363
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferGetConstMappedRange";

   function wgpuBufferGetMapState (buffer : WGPUBuffer) return WGPUBufferMapState  -- webgpu.h:3364
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferGetMapState";

  --*
  -- * @param offset
  -- * Byte offset relative to the beginning of the buffer.
  -- *
  -- * @param size
  -- * Byte size of the range to get. The returned pointer is valid for exactly this many bytes.
  -- *
  -- * @returns
  -- * Returns a mutable pointer to beginning of the mapped range.
  -- * Returns `NULL` with @ref ImplementationDefinedLogging if:
  -- *
  -- * - There is any content-timeline error as defined in the WebGPU specification for `getMappedRange()` (alignments, overlaps, etc.)
  -- * - The buffer is not mapped with @ref WGPUMapMode_Write.
  --

   function wgpuBufferGetMappedRange
     (buffer : WGPUBuffer;
      offset : T_Size;
      size : T_Size) return System.Address  -- webgpu.h:3379
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferGetMappedRange";

   function wgpuBufferGetSize (buffer : WGPUBuffer) return bits_stdint_uintn_h.uint64_t  -- webgpu.h:3380
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferGetSize";

   function wgpuBufferGetUsage (buffer : WGPUBuffer) return WGPUBufferUsage  -- webgpu.h:3381
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferGetUsage";

   function wgpuBufferMapAsync
     (buffer : WGPUBuffer;
      mode : WGPUMapMode;
      offset : T_Size;
      size : T_Size;
      callbackInfo : WGPUBufferMapCallbackInfo) return WGPUFuture  -- webgpu.h:3382
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferMapAsync";

   procedure wgpuBufferSetLabel (buffer : WGPUBuffer; label : WGPUStringView)  -- webgpu.h:3383
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferSetLabel";

   procedure wgpuBufferUnmap (buffer : WGPUBuffer)  -- webgpu.h:3384
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferUnmap";

   procedure wgpuBufferAddRef (buffer : WGPUBuffer)  -- webgpu.h:3385
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferAddRef";

   procedure wgpuBufferRelease (buffer : WGPUBuffer)  -- webgpu.h:3386
   with Import => True,
        Convention => C,
        External_Name => "wgpuBufferRelease";

  --* @}
  --*
  -- * \defgroup WGPUCommandBufferMethods WGPUCommandBuffer methods
  -- * \brief Functions whose first argument has type WGPUCommandBuffer.
  -- *
  -- * @{
  --

   procedure wgpuCommandBufferSetLabel (commandBuffer : WGPUCommandBuffer; label : WGPUStringView)  -- webgpu.h:3397
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandBufferSetLabel";

   procedure wgpuCommandBufferAddRef (commandBuffer : WGPUCommandBuffer)  -- webgpu.h:3398
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandBufferAddRef";

   procedure wgpuCommandBufferRelease (commandBuffer : WGPUCommandBuffer)  -- webgpu.h:3399
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandBufferRelease";

  --* @}
  --*
  -- * \defgroup WGPUCommandEncoderMethods WGPUCommandEncoder methods
  -- * \brief Functions whose first argument has type WGPUCommandEncoder.
  -- *
  -- * @{
  --

   function wgpuCommandEncoderBeginComputePass (commandEncoder : WGPUCommandEncoder; descriptor : access constant WGPUComputePassDescriptor) return WGPUComputePassEncoder  -- webgpu.h:3410
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderBeginComputePass";

   function wgpuCommandEncoderBeginRenderPass (commandEncoder : WGPUCommandEncoder; descriptor : access constant WGPURenderPassDescriptor) return WGPURenderPassEncoder  -- webgpu.h:3411
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderBeginRenderPass";

   procedure wgpuCommandEncoderClearBuffer
     (commandEncoder : WGPUCommandEncoder;
      buffer : WGPUBuffer;
      offset : bits_stdint_uintn_h.uint64_t;
      size : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3412
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderClearBuffer";

   procedure wgpuCommandEncoderCopyBufferToBuffer
     (commandEncoder : WGPUCommandEncoder;
      source : WGPUBuffer;
      sourceOffset : bits_stdint_uintn_h.uint64_t;
      destination : WGPUBuffer;
      destinationOffset : bits_stdint_uintn_h.uint64_t;
      size : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3413
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderCopyBufferToBuffer";

   procedure wgpuCommandEncoderCopyBufferToTexture
     (commandEncoder : WGPUCommandEncoder;
      source : access constant WGPUTexelCopyBufferInfo;
      destination : access constant WGPUTexelCopyTextureInfo;
      copySize : access constant WGPUExtent3D)  -- webgpu.h:3414
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderCopyBufferToTexture";

   procedure wgpuCommandEncoderCopyTextureToBuffer
     (commandEncoder : WGPUCommandEncoder;
      source : access constant WGPUTexelCopyTextureInfo;
      destination : access constant WGPUTexelCopyBufferInfo;
      copySize : access constant WGPUExtent3D)  -- webgpu.h:3415
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderCopyTextureToBuffer";

   procedure wgpuCommandEncoderCopyTextureToTexture
     (commandEncoder : WGPUCommandEncoder;
      source : access constant WGPUTexelCopyTextureInfo;
      destination : access constant WGPUTexelCopyTextureInfo;
      copySize : access constant WGPUExtent3D)  -- webgpu.h:3416
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderCopyTextureToTexture";

   function wgpuCommandEncoderFinish (commandEncoder : WGPUCommandEncoder; descriptor : access constant WGPUCommandBufferDescriptor) return WGPUCommandBuffer  -- webgpu.h:3417
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderFinish";

   procedure wgpuCommandEncoderInsertDebugMarker (commandEncoder : WGPUCommandEncoder; markerLabel : WGPUStringView)  -- webgpu.h:3418
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderInsertDebugMarker";

   procedure wgpuCommandEncoderPopDebugGroup (commandEncoder : WGPUCommandEncoder)  -- webgpu.h:3419
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderPopDebugGroup";

   procedure wgpuCommandEncoderPushDebugGroup (commandEncoder : WGPUCommandEncoder; groupLabel : WGPUStringView)  -- webgpu.h:3420
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderPushDebugGroup";

   procedure wgpuCommandEncoderResolveQuerySet
     (commandEncoder : WGPUCommandEncoder;
      querySet : WGPUQuerySet;
      firstQuery : bits_stdint_uintn_h.uint32_t;
      queryCount : bits_stdint_uintn_h.uint32_t;
      destination : WGPUBuffer;
      destinationOffset : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3421
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderResolveQuerySet";

   procedure wgpuCommandEncoderSetLabel (commandEncoder : WGPUCommandEncoder; label : WGPUStringView)  -- webgpu.h:3422
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderSetLabel";

   procedure wgpuCommandEncoderWriteTimestamp
     (commandEncoder : WGPUCommandEncoder;
      querySet : WGPUQuerySet;
      queryIndex : bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3423
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderWriteTimestamp";

   procedure wgpuCommandEncoderAddRef (commandEncoder : WGPUCommandEncoder)  -- webgpu.h:3424
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderAddRef";

   procedure wgpuCommandEncoderRelease (commandEncoder : WGPUCommandEncoder)  -- webgpu.h:3425
   with Import => True,
        Convention => C,
        External_Name => "wgpuCommandEncoderRelease";

  --* @}
  --*
  -- * \defgroup WGPUComputePassEncoderMethods WGPUComputePassEncoder methods
  -- * \brief Functions whose first argument has type WGPUComputePassEncoder.
  -- *
  -- * @{
  --

   procedure wgpuComputePassEncoderDispatchWorkgroups
     (computePassEncoder : WGPUComputePassEncoder;
      workgroupCountX : bits_stdint_uintn_h.uint32_t;
      workgroupCountY : bits_stdint_uintn_h.uint32_t;
      workgroupCountZ : bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3436
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderDispatchWorkgroups";

   procedure wgpuComputePassEncoderDispatchWorkgroupsIndirect
     (computePassEncoder : WGPUComputePassEncoder;
      indirectBuffer : WGPUBuffer;
      indirectOffset : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3437
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderDispatchWorkgroupsIndirect";

   procedure wgpuComputePassEncoderEnd (computePassEncoder : WGPUComputePassEncoder)  -- webgpu.h:3438
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderEnd";

   procedure wgpuComputePassEncoderInsertDebugMarker (computePassEncoder : WGPUComputePassEncoder; markerLabel : WGPUStringView)  -- webgpu.h:3439
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderInsertDebugMarker";

   procedure wgpuComputePassEncoderPopDebugGroup (computePassEncoder : WGPUComputePassEncoder)  -- webgpu.h:3440
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderPopDebugGroup";

   procedure wgpuComputePassEncoderPushDebugGroup (computePassEncoder : WGPUComputePassEncoder; groupLabel : WGPUStringView)  -- webgpu.h:3441
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderPushDebugGroup";

   procedure wgpuComputePassEncoderSetBindGroup
     (computePassEncoder : WGPUComputePassEncoder;
      groupIndex : bits_stdint_uintn_h.uint32_t;
      group : WGPUBindGroup;
      dynamicOffsetCount : T_Size;
      dynamicOffsets : access bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3442
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderSetBindGroup";

   procedure wgpuComputePassEncoderSetLabel (computePassEncoder : WGPUComputePassEncoder; label : WGPUStringView)  -- webgpu.h:3443
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderSetLabel";

   procedure wgpuComputePassEncoderSetPipeline (computePassEncoder : WGPUComputePassEncoder; pipeline : WGPUComputePipeline)  -- webgpu.h:3444
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderSetPipeline";

   procedure wgpuComputePassEncoderAddRef (computePassEncoder : WGPUComputePassEncoder)  -- webgpu.h:3445
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderAddRef";

   procedure wgpuComputePassEncoderRelease (computePassEncoder : WGPUComputePassEncoder)  -- webgpu.h:3446
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePassEncoderRelease";

  --* @}
  --*
  -- * \defgroup WGPUComputePipelineMethods WGPUComputePipeline methods
  -- * \brief Functions whose first argument has type WGPUComputePipeline.
  -- *
  -- * @{
  --

   function wgpuComputePipelineGetBindGroupLayout (computePipeline : WGPUComputePipeline; groupIndex : bits_stdint_uintn_h.uint32_t) return WGPUBindGroupLayout  -- webgpu.h:3457
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePipelineGetBindGroupLayout";

   procedure wgpuComputePipelineSetLabel (computePipeline : WGPUComputePipeline; label : WGPUStringView)  -- webgpu.h:3458
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePipelineSetLabel";

   procedure wgpuComputePipelineAddRef (computePipeline : WGPUComputePipeline)  -- webgpu.h:3459
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePipelineAddRef";

   procedure wgpuComputePipelineRelease (computePipeline : WGPUComputePipeline)  -- webgpu.h:3460
   with Import => True,
        Convention => C,
        External_Name => "wgpuComputePipelineRelease";

  --* @}
  --*
  -- * \defgroup WGPUDeviceMethods WGPUDevice methods
  -- * \brief Functions whose first argument has type WGPUDevice.
  -- *
  -- * @{
  --

   function wgpuDeviceCreateBindGroup (device : WGPUDevice; descriptor : access constant WGPUBindGroupDescriptor) return WGPUBindGroup  -- webgpu.h:3471
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateBindGroup";

   function wgpuDeviceCreateBindGroupLayout (device : WGPUDevice; descriptor : access constant WGPUBindGroupLayoutDescriptor) return WGPUBindGroupLayout  -- webgpu.h:3472
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateBindGroupLayout";

   function wgpuDeviceCreateBuffer (device : WGPUDevice; descriptor : access constant WGPUBufferDescriptor) return WGPUBuffer  -- webgpu.h:3473
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateBuffer";

   function wgpuDeviceCreateCommandEncoder (device : WGPUDevice; descriptor : access constant WGPUCommandEncoderDescriptor) return WGPUCommandEncoder  -- webgpu.h:3474
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateCommandEncoder";

   function wgpuDeviceCreateComputePipeline (device : WGPUDevice; descriptor : access constant WGPUComputePipelineDescriptor) return WGPUComputePipeline  -- webgpu.h:3475
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateComputePipeline";

   function wgpuDeviceCreateComputePipelineAsync
     (device : WGPUDevice;
      descriptor : access constant WGPUComputePipelineDescriptor;
      callbackInfo : WGPUCreateComputePipelineAsyncCallbackInfo) return WGPUFuture  -- webgpu.h:3476
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateComputePipelineAsync";

   function wgpuDeviceCreatePipelineLayout (device : WGPUDevice; descriptor : access constant WGPUPipelineLayoutDescriptor) return WGPUPipelineLayout  -- webgpu.h:3477
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreatePipelineLayout";

   function wgpuDeviceCreateQuerySet (device : WGPUDevice; descriptor : access constant WGPUQuerySetDescriptor) return WGPUQuerySet  -- webgpu.h:3478
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateQuerySet";

   function wgpuDeviceCreateRenderBundleEncoder (device : WGPUDevice; descriptor : access constant WGPURenderBundleEncoderDescriptor) return WGPURenderBundleEncoder  -- webgpu.h:3479
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateRenderBundleEncoder";

   function wgpuDeviceCreateRenderPipeline (device : WGPUDevice; descriptor : access constant WGPURenderPipelineDescriptor) return WGPURenderPipeline  -- webgpu.h:3480
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateRenderPipeline";

   function wgpuDeviceCreateRenderPipelineAsync
     (device : WGPUDevice;
      descriptor : access constant WGPURenderPipelineDescriptor;
      callbackInfo : WGPUCreateRenderPipelineAsyncCallbackInfo) return WGPUFuture  -- webgpu.h:3481
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateRenderPipelineAsync";

   function wgpuDeviceCreateSampler (device : WGPUDevice; descriptor : access constant WGPUSamplerDescriptor) return WGPUSampler  -- webgpu.h:3482
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateSampler";

   function wgpuDeviceCreateShaderModule (device : WGPUDevice; descriptor : access constant WGPUShaderModuleDescriptor) return WGPUShaderModule  -- webgpu.h:3483
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateShaderModule";

   function wgpuDeviceCreateTexture (device : WGPUDevice; descriptor : access constant WGPUTextureDescriptor) return WGPUTexture  -- webgpu.h:3484
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceCreateTexture";

   procedure wgpuDeviceDestroy (device : WGPUDevice)  -- webgpu.h:3485
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceDestroy";

   function wgpuDeviceGetAdapterInfo (device : WGPUDevice) return WGPUAdapterInfo  -- webgpu.h:3486
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceGetAdapterInfo";

  --*
  -- * Get the list of @ref WGPUFeatureName values supported by the device.
  -- *
  -- * @param features
  -- * This parameter is @ref ReturnedWithOwnership.
  --

   procedure wgpuDeviceGetFeatures (device : WGPUDevice; features : access WGPUSupportedFeatures)  -- webgpu.h:3493
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceGetFeatures";

  --*
  -- * @returns
  -- * Indicates if there was an @ref OutStructChainError.
  --

   function wgpuDeviceGetLimits (device : WGPUDevice; limits : access WGPULimits) return WGPUStatus  -- webgpu.h:3498
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceGetLimits";

  --*
  -- * @returns
  -- * The @ref WGPUFuture for the device-lost event of the device.
  --

   function wgpuDeviceGetLostFuture (device : WGPUDevice) return WGPUFuture  -- webgpu.h:3503
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceGetLostFuture";

   function wgpuDeviceGetQueue (device : WGPUDevice) return WGPUQueue  -- webgpu.h:3504
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceGetQueue";

   function wgpuDeviceHasFeature (device : WGPUDevice; feature : WGPUFeatureName) return T_WGPUBool  -- webgpu.h:3505
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceHasFeature";

   function wgpuDevicePopErrorScope (device : WGPUDevice; callbackInfo : WGPUPopErrorScopeCallbackInfo) return WGPUFuture  -- webgpu.h:3506
   with Import => True,
        Convention => C,
        External_Name => "wgpuDevicePopErrorScope";

   procedure wgpuDevicePushErrorScope (device : WGPUDevice; filter : WGPUErrorFilter)  -- webgpu.h:3507
   with Import => True,
        Convention => C,
        External_Name => "wgpuDevicePushErrorScope";

   procedure wgpuDeviceSetLabel (device : WGPUDevice; label : WGPUStringView)  -- webgpu.h:3508
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceSetLabel";

   procedure wgpuDeviceAddRef (device : WGPUDevice)  -- webgpu.h:3509
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceAddRef";

   procedure wgpuDeviceRelease (device : WGPUDevice)  -- webgpu.h:3510
   with Import => True,
        Convention => C,
        External_Name => "wgpuDeviceRelease";

  --* @}
  --*
  -- * \defgroup WGPUInstanceMethods T_WGPUInstance methods
  -- * \brief Functions whose first argument has type T_WGPUInstance.
  -- *
  -- * @{
  --

  --*
  -- * Creates a @ref WGPUSurface, see @ref Surface-Creation for more details.
  -- *
  -- * @param descriptor
  -- * The description of the @ref WGPUSurface to create.
  -- *
  -- * @returns
  -- * A new @ref WGPUSurface for this descriptor (or an error @ref WGPUSurface).
  --

   function wgpuInstanceCreateSurface (instance : T_WGPUInstance; descriptor : access constant WGPUSurfaceDescriptor) return WGPUSurface  -- webgpu.h:3530
   with Import => True,
        Convention => C,
        External_Name => "wgpuInstanceCreateSurface";

  --*
  -- * Get the list of @ref WGPUWGSLLanguageFeatureName values supported by the instance.
  --

   function wgpuInstanceGetWGSLLanguageFeatures (instance : T_WGPUInstance; features : access WGPUSupportedWGSLLanguageFeatures) return WGPUStatus  -- webgpu.h:3534
   with Import => True,
        Convention => C,
        External_Name => "wgpuInstanceGetWGSLLanguageFeatures";

   function wgpuInstanceHasWGSLLanguageFeature (instance : T_WGPUInstance; feature : WGPUWGSLLanguageFeatureName) return T_WGPUBool  -- webgpu.h:3535
   with Import => True,
        Convention => C,
        External_Name => "wgpuInstanceHasWGSLLanguageFeature";

  --*
  -- * Processes asynchronous events on this `T_WGPUInstance`, calling any callbacks for asynchronous operations created with `::WGPUCallbackMode_AllowProcessEvents`.
  -- *
  -- * See @ref Process-Events for more information.
  --

   procedure wgpuInstanceProcessEvents (instance : T_WGPUInstance)  -- webgpu.h:3541
   with Import => True,
        Convention => C,
        External_Name => "wgpuInstanceProcessEvents";

   function wgpuInstanceRequestAdapter
     (instance : T_WGPUInstance;
      options : access constant WGPURequestAdapterOptions;
      callbackInfo : WGPURequestAdapterCallbackInfo) return WGPUFuture  -- webgpu.h:3542
   with Import => True,
        Convention => C,
        External_Name => "wgpuInstanceRequestAdapter";

  --*
  -- * Wait for at least one WGPUFuture in `futures` to complete, and call callbacks of the respective completed asynchronous operations.
  -- *
  -- * See @ref Wait-Any for more information.
  --

   function wgpuInstanceWaitAny
     (instance : T_WGPUInstance;
      futureCount : T_Size;
      futures : access WGPUFutureWaitInfo;
      timeoutNS : bits_stdint_uintn_h.uint64_t) return WGPUWaitStatus  -- webgpu.h:3548
   with Import => True,
        Convention => C,
        External_Name => "wgpuInstanceWaitAny";

   procedure wgpuInstanceAddRef (instance : T_WGPUInstance)  -- webgpu.h:3549
   with Import => True,
        Convention => C,
        External_Name => "wgpuInstanceAddRef";

   procedure wgpuInstanceRelease (instance : T_WGPUInstance)  -- webgpu.h:3550
   with Import => True,
        Convention => C,
        External_Name => "wgpuInstanceRelease";

  --* @}
  --*
  -- * \defgroup WGPUPipelineLayoutMethods WGPUPipelineLayout methods
  -- * \brief Functions whose first argument has type WGPUPipelineLayout.
  -- *
  -- * @{
  --

   procedure wgpuPipelineLayoutSetLabel (pipelineLayout : WGPUPipelineLayout; label : WGPUStringView)  -- webgpu.h:3561
   with Import => True,
        Convention => C,
        External_Name => "wgpuPipelineLayoutSetLabel";

   procedure wgpuPipelineLayoutAddRef (pipelineLayout : WGPUPipelineLayout)  -- webgpu.h:3562
   with Import => True,
        Convention => C,
        External_Name => "wgpuPipelineLayoutAddRef";

   procedure wgpuPipelineLayoutRelease (pipelineLayout : WGPUPipelineLayout)  -- webgpu.h:3563
   with Import => True,
        Convention => C,
        External_Name => "wgpuPipelineLayoutRelease";

  --* @}
  --*
  -- * \defgroup WGPUQuerySetMethods WGPUQuerySet methods
  -- * \brief Functions whose first argument has type WGPUQuerySet.
  -- *
  -- * @{
  --

   procedure wgpuQuerySetDestroy (querySet : WGPUQuerySet)  -- webgpu.h:3574
   with Import => True,
        Convention => C,
        External_Name => "wgpuQuerySetDestroy";

   function wgpuQuerySetGetCount (querySet : WGPUQuerySet) return bits_stdint_uintn_h.uint32_t  -- webgpu.h:3575
   with Import => True,
        Convention => C,
        External_Name => "wgpuQuerySetGetCount";

   function wgpuQuerySetGetType (querySet : WGPUQuerySet) return WGPUQueryType  -- webgpu.h:3576
   with Import => True,
        Convention => C,
        External_Name => "wgpuQuerySetGetType";

   procedure wgpuQuerySetSetLabel (querySet : WGPUQuerySet; label : WGPUStringView)  -- webgpu.h:3577
   with Import => True,
        Convention => C,
        External_Name => "wgpuQuerySetSetLabel";

   procedure wgpuQuerySetAddRef (querySet : WGPUQuerySet)  -- webgpu.h:3578
   with Import => True,
        Convention => C,
        External_Name => "wgpuQuerySetAddRef";

   procedure wgpuQuerySetRelease (querySet : WGPUQuerySet)  -- webgpu.h:3579
   with Import => True,
        Convention => C,
        External_Name => "wgpuQuerySetRelease";

  --* @}
  --*
  -- * \defgroup WGPUQueueMethods WGPUQueue methods
  -- * \brief Functions whose first argument has type WGPUQueue.
  -- *
  -- * @{
  --

   function wgpuQueueOnSubmittedWorkDone (queue : WGPUQueue; callbackInfo : WGPUQueueWorkDoneCallbackInfo) return WGPUFuture  -- webgpu.h:3590
   with Import => True,
        Convention => C,
        External_Name => "wgpuQueueOnSubmittedWorkDone";

   procedure wgpuQueueSetLabel (queue : WGPUQueue; label : WGPUStringView)  -- webgpu.h:3591
   with Import => True,
        Convention => C,
        External_Name => "wgpuQueueSetLabel";

   procedure wgpuQueueSubmit
     (queue : WGPUQueue;
      commandCount : T_Size;
      commands : System.Address)  -- webgpu.h:3592
   with Import => True,
        Convention => C,
        External_Name => "wgpuQueueSubmit";

  --*
  -- * Produces a @ref DeviceError both content-timeline (`size` alignment) and device-timeline
  -- * errors defined by the WebGPU specification.
  --

   procedure wgpuQueueWriteBuffer
     (queue : WGPUQueue;
      buffer : WGPUBuffer;
      bufferOffset : bits_stdint_uintn_h.uint64_t;
      data : System.Address;
      size : T_Size)  -- webgpu.h:3597
   with Import => True,
        Convention => C,
        External_Name => "wgpuQueueWriteBuffer";

   procedure wgpuQueueWriteTexture
     (queue : WGPUQueue;
      destination : access constant WGPUTexelCopyTextureInfo;
      data : System.Address;
      dataSize : T_Size;
      dataLayout : access constant WGPUTexelCopyBufferLayout;
      writeSize : access constant WGPUExtent3D)  -- webgpu.h:3598
   with Import => True,
        Convention => C,
        External_Name => "wgpuQueueWriteTexture";

   procedure wgpuQueueAddRef (queue : WGPUQueue)  -- webgpu.h:3599
   with Import => True,
        Convention => C,
        External_Name => "wgpuQueueAddRef";

   procedure wgpuQueueRelease (queue : WGPUQueue)  -- webgpu.h:3600
   with Import => True,
        Convention => C,
        External_Name => "wgpuQueueRelease";

  --* @}
  --*
  -- * \defgroup WGPURenderBundleMethods WGPURenderBundle methods
  -- * \brief Functions whose first argument has type WGPURenderBundle.
  -- *
  -- * @{
  --

   procedure wgpuRenderBundleSetLabel (renderBundle : WGPURenderBundle; label : WGPUStringView)  -- webgpu.h:3611
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleSetLabel";

   procedure wgpuRenderBundleAddRef (renderBundle : WGPURenderBundle)  -- webgpu.h:3612
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleAddRef";

   procedure wgpuRenderBundleRelease (renderBundle : WGPURenderBundle)  -- webgpu.h:3613
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleRelease";

  --* @}
  --*
  -- * \defgroup WGPURenderBundleEncoderMethods WGPURenderBundleEncoder methods
  -- * \brief Functions whose first argument has type WGPURenderBundleEncoder.
  -- *
  -- * @{
  --

   procedure wgpuRenderBundleEncoderDraw
     (renderBundleEncoder : WGPURenderBundleEncoder;
      vertexCount : bits_stdint_uintn_h.uint32_t;
      instanceCount : bits_stdint_uintn_h.uint32_t;
      firstVertex : bits_stdint_uintn_h.uint32_t;
      firstInstance : bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3624
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderDraw";

   procedure wgpuRenderBundleEncoderDrawIndexed
     (renderBundleEncoder : WGPURenderBundleEncoder;
      indexCount : bits_stdint_uintn_h.uint32_t;
      instanceCount : bits_stdint_uintn_h.uint32_t;
      firstIndex : bits_stdint_uintn_h.uint32_t;
      baseVertex : bits_stdint_intn_h.int32_t;
      firstInstance : bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3625
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderDrawIndexed";

   procedure wgpuRenderBundleEncoderDrawIndexedIndirect
     (renderBundleEncoder : WGPURenderBundleEncoder;
      indirectBuffer : WGPUBuffer;
      indirectOffset : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3626
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderDrawIndexedIndirect";

   procedure wgpuRenderBundleEncoderDrawIndirect
     (renderBundleEncoder : WGPURenderBundleEncoder;
      indirectBuffer : WGPUBuffer;
      indirectOffset : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3627
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderDrawIndirect";

   function wgpuRenderBundleEncoderFinish (renderBundleEncoder : WGPURenderBundleEncoder; descriptor : access constant WGPURenderBundleDescriptor) return WGPURenderBundle  -- webgpu.h:3628
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderFinish";

   procedure wgpuRenderBundleEncoderInsertDebugMarker (renderBundleEncoder : WGPURenderBundleEncoder; markerLabel : WGPUStringView)  -- webgpu.h:3629
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderInsertDebugMarker";

   procedure wgpuRenderBundleEncoderPopDebugGroup (renderBundleEncoder : WGPURenderBundleEncoder)  -- webgpu.h:3630
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderPopDebugGroup";

   procedure wgpuRenderBundleEncoderPushDebugGroup (renderBundleEncoder : WGPURenderBundleEncoder; groupLabel : WGPUStringView)  -- webgpu.h:3631
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderPushDebugGroup";

   procedure wgpuRenderBundleEncoderSetBindGroup
     (renderBundleEncoder : WGPURenderBundleEncoder;
      groupIndex : bits_stdint_uintn_h.uint32_t;
      group : WGPUBindGroup;
      dynamicOffsetCount : T_Size;
      dynamicOffsets : access bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3632
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderSetBindGroup";

   procedure wgpuRenderBundleEncoderSetIndexBuffer
     (renderBundleEncoder : WGPURenderBundleEncoder;
      buffer : WGPUBuffer;
      format : WGPUIndexFormat;
      offset : bits_stdint_uintn_h.uint64_t;
      size : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3633
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderSetIndexBuffer";

   procedure wgpuRenderBundleEncoderSetLabel (renderBundleEncoder : WGPURenderBundleEncoder; label : WGPUStringView)  -- webgpu.h:3634
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderSetLabel";

   procedure wgpuRenderBundleEncoderSetPipeline (renderBundleEncoder : WGPURenderBundleEncoder; pipeline : WGPURenderPipeline)  -- webgpu.h:3635
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderSetPipeline";

   procedure wgpuRenderBundleEncoderSetVertexBuffer
     (renderBundleEncoder : WGPURenderBundleEncoder;
      slot : bits_stdint_uintn_h.uint32_t;
      buffer : WGPUBuffer;
      offset : bits_stdint_uintn_h.uint64_t;
      size : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3636
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderSetVertexBuffer";

   procedure wgpuRenderBundleEncoderAddRef (renderBundleEncoder : WGPURenderBundleEncoder)  -- webgpu.h:3637
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderAddRef";

   procedure wgpuRenderBundleEncoderRelease (renderBundleEncoder : WGPURenderBundleEncoder)  -- webgpu.h:3638
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderBundleEncoderRelease";

  --* @}
  --*
  -- * \defgroup WGPURenderPassEncoderMethods WGPURenderPassEncoder methods
  -- * \brief Functions whose first argument has type WGPURenderPassEncoder.
  -- *
  -- * @{
  --

   procedure wgpuRenderPassEncoderBeginOcclusionQuery (renderPassEncoder : WGPURenderPassEncoder; queryIndex : bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3649
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderBeginOcclusionQuery";

   procedure wgpuRenderPassEncoderDraw
     (renderPassEncoder : WGPURenderPassEncoder;
      vertexCount : bits_stdint_uintn_h.uint32_t;
      instanceCount : bits_stdint_uintn_h.uint32_t;
      firstVertex : bits_stdint_uintn_h.uint32_t;
      firstInstance : bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3650
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderDraw";

   procedure wgpuRenderPassEncoderDrawIndexed
     (renderPassEncoder : WGPURenderPassEncoder;
      indexCount : bits_stdint_uintn_h.uint32_t;
      instanceCount : bits_stdint_uintn_h.uint32_t;
      firstIndex : bits_stdint_uintn_h.uint32_t;
      baseVertex : bits_stdint_intn_h.int32_t;
      firstInstance : bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3651
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderDrawIndexed";

   procedure wgpuRenderPassEncoderDrawIndexedIndirect
     (renderPassEncoder : WGPURenderPassEncoder;
      indirectBuffer : WGPUBuffer;
      indirectOffset : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3652
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderDrawIndexedIndirect";

   procedure wgpuRenderPassEncoderDrawIndirect
     (renderPassEncoder : WGPURenderPassEncoder;
      indirectBuffer : WGPUBuffer;
      indirectOffset : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3653
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderDrawIndirect";

   procedure wgpuRenderPassEncoderEnd (renderPassEncoder : WGPURenderPassEncoder)  -- webgpu.h:3654
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderEnd";

   procedure wgpuRenderPassEncoderEndOcclusionQuery (renderPassEncoder : WGPURenderPassEncoder)  -- webgpu.h:3655
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderEndOcclusionQuery";

   procedure wgpuRenderPassEncoderExecuteBundles
     (renderPassEncoder : WGPURenderPassEncoder;
      bundleCount : T_Size;
      bundles : System.Address)  -- webgpu.h:3656
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderExecuteBundles";

   procedure wgpuRenderPassEncoderInsertDebugMarker (renderPassEncoder : WGPURenderPassEncoder; markerLabel : WGPUStringView)  -- webgpu.h:3657
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderInsertDebugMarker";

   procedure wgpuRenderPassEncoderPopDebugGroup (renderPassEncoder : WGPURenderPassEncoder)  -- webgpu.h:3658
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderPopDebugGroup";

   procedure wgpuRenderPassEncoderPushDebugGroup (renderPassEncoder : WGPURenderPassEncoder; groupLabel : WGPUStringView)  -- webgpu.h:3659
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderPushDebugGroup";

   procedure wgpuRenderPassEncoderSetBindGroup
     (renderPassEncoder : WGPURenderPassEncoder;
      groupIndex : bits_stdint_uintn_h.uint32_t;
      group : WGPUBindGroup;
      dynamicOffsetCount : T_Size;
      dynamicOffsets : access bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3660
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderSetBindGroup";

   procedure wgpuRenderPassEncoderSetBlendConstant (renderPassEncoder : WGPURenderPassEncoder; color : access constant WGPUColor)  -- webgpu.h:3661
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderSetBlendConstant";

   procedure wgpuRenderPassEncoderSetIndexBuffer
     (renderPassEncoder : WGPURenderPassEncoder;
      buffer : WGPUBuffer;
      format : WGPUIndexFormat;
      offset : bits_stdint_uintn_h.uint64_t;
      size : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3662
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderSetIndexBuffer";

   procedure wgpuRenderPassEncoderSetLabel (renderPassEncoder : WGPURenderPassEncoder; label : WGPUStringView)  -- webgpu.h:3663
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderSetLabel";

   procedure wgpuRenderPassEncoderSetPipeline (renderPassEncoder : WGPURenderPassEncoder; pipeline : WGPURenderPipeline)  -- webgpu.h:3664
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderSetPipeline";

   procedure wgpuRenderPassEncoderSetScissorRect
     (renderPassEncoder : WGPURenderPassEncoder;
      x : bits_stdint_uintn_h.uint32_t;
      y : bits_stdint_uintn_h.uint32_t;
      width : bits_stdint_uintn_h.uint32_t;
      height : bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3665
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderSetScissorRect";

   procedure wgpuRenderPassEncoderSetStencilReference (renderPassEncoder : WGPURenderPassEncoder; reference : bits_stdint_uintn_h.uint32_t)  -- webgpu.h:3666
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderSetStencilReference";

   procedure wgpuRenderPassEncoderSetVertexBuffer
     (renderPassEncoder : WGPURenderPassEncoder;
      slot : bits_stdint_uintn_h.uint32_t;
      buffer : WGPUBuffer;
      offset : bits_stdint_uintn_h.uint64_t;
      size : bits_stdint_uintn_h.uint64_t)  -- webgpu.h:3667
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderSetVertexBuffer";

   procedure wgpuRenderPassEncoderSetViewport
     (renderPassEncoder : WGPURenderPassEncoder;
      x : float;
      y : float;
      width : float;
      height : float;
      minDepth : float;
      maxDepth : float)  -- webgpu.h:3668
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderSetViewport";

   procedure wgpuRenderPassEncoderAddRef (renderPassEncoder : WGPURenderPassEncoder)  -- webgpu.h:3669
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderAddRef";

   procedure wgpuRenderPassEncoderRelease (renderPassEncoder : WGPURenderPassEncoder)  -- webgpu.h:3670
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPassEncoderRelease";

  --* @}
  --*
  -- * \defgroup WGPURenderPipelineMethods WGPURenderPipeline methods
  -- * \brief Functions whose first argument has type WGPURenderPipeline.
  -- *
  -- * @{
  --

   function wgpuRenderPipelineGetBindGroupLayout (renderPipeline : WGPURenderPipeline; groupIndex : bits_stdint_uintn_h.uint32_t) return WGPUBindGroupLayout  -- webgpu.h:3681
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPipelineGetBindGroupLayout";

   procedure wgpuRenderPipelineSetLabel (renderPipeline : WGPURenderPipeline; label : WGPUStringView)  -- webgpu.h:3682
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPipelineSetLabel";

   procedure wgpuRenderPipelineAddRef (renderPipeline : WGPURenderPipeline)  -- webgpu.h:3683
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPipelineAddRef";

   procedure wgpuRenderPipelineRelease (renderPipeline : WGPURenderPipeline)  -- webgpu.h:3684
   with Import => True,
        Convention => C,
        External_Name => "wgpuRenderPipelineRelease";

  --* @}
  --*
  -- * \defgroup WGPUSamplerMethods WGPUSampler methods
  -- * \brief Functions whose first argument has type WGPUSampler.
  -- *
  -- * @{
  --

   procedure wgpuSamplerSetLabel (sampler : WGPUSampler; label : WGPUStringView)  -- webgpu.h:3695
   with Import => True,
        Convention => C,
        External_Name => "wgpuSamplerSetLabel";

   procedure wgpuSamplerAddRef (sampler : WGPUSampler)  -- webgpu.h:3696
   with Import => True,
        Convention => C,
        External_Name => "wgpuSamplerAddRef";

   procedure wgpuSamplerRelease (sampler : WGPUSampler)  -- webgpu.h:3697
   with Import => True,
        Convention => C,
        External_Name => "wgpuSamplerRelease";

  --* @}
  --*
  -- * \defgroup WGPUShaderModuleMethods WGPUShaderModule methods
  -- * \brief Functions whose first argument has type WGPUShaderModule.
  -- *
  -- * @{
  --

   function wgpuShaderModuleGetCompilationInfo (shaderModule : WGPUShaderModule; callbackInfo : WGPUCompilationInfoCallbackInfo) return WGPUFuture  -- webgpu.h:3708
   with Import => True,
        Convention => C,
        External_Name => "wgpuShaderModuleGetCompilationInfo";

   procedure wgpuShaderModuleSetLabel (shaderModule : WGPUShaderModule; label : WGPUStringView)  -- webgpu.h:3709
   with Import => True,
        Convention => C,
        External_Name => "wgpuShaderModuleSetLabel";

   procedure wgpuShaderModuleAddRef (shaderModule : WGPUShaderModule)  -- webgpu.h:3710
   with Import => True,
        Convention => C,
        External_Name => "wgpuShaderModuleAddRef";

   procedure wgpuShaderModuleRelease (shaderModule : WGPUShaderModule)  -- webgpu.h:3711
   with Import => True,
        Convention => C,
        External_Name => "wgpuShaderModuleRelease";

  --* @}
  --*
  -- * \defgroup WGPUSupportedFeaturesMethods WGPUSupportedFeatures methods
  -- * \brief Functions whose first argument has type WGPUSupportedFeatures.
  -- *
  -- * @{
  --

  --*
  -- * Frees array members of WGPUSupportedFeatures which were allocated by the API.
  --

   procedure wgpuSupportedFeaturesFreeMembers (supportedFeatures : WGPUSupportedFeatures)  -- webgpu.h:3725
   with Import => True,
        Convention => C,
        External_Name => "wgpuSupportedFeaturesFreeMembers";

  --* @}
  --*
  -- * \defgroup WGPUSupportedWGSLLanguageFeaturesMethods WGPUSupportedWGSLLanguageFeatures methods
  -- * \brief Functions whose first argument has type WGPUSupportedWGSLLanguageFeatures.
  -- *
  -- * @{
  --

  --*
  -- * Frees array members of WGPUSupportedWGSLLanguageFeatures which were allocated by the API.
  --

   procedure wgpuSupportedWGSLLanguageFeaturesFreeMembers (supportedWGSLLanguageFeatures : WGPUSupportedWGSLLanguageFeatures)  -- webgpu.h:3739
   with Import => True,
        Convention => C,
        External_Name => "wgpuSupportedWGSLLanguageFeaturesFreeMembers";

  --* @}
  --*
  -- * \defgroup WGPUSurfaceMethods WGPUSurface methods
  -- * \brief Functions whose first argument has type WGPUSurface.
  -- *
  -- * @{
  --

  --*
  -- * Configures parameters for rendering to `surface`.
  -- * Produces a @ref DeviceError for all content-timeline errors defined by the WebGPU specification.
  -- *
  -- * See @ref Surface-Configuration for more details.
  -- *
  -- * @param config
  -- * The new configuration to use.
  --

   procedure wgpuSurfaceConfigure (surface : WGPUSurface; config : access constant WGPUSurfaceConfiguration)  -- webgpu.h:3759
   with Import => True,
        Convention => C,
        External_Name => "wgpuSurfaceConfigure";

  --*
  -- * Provides information on how `adapter` is able to use `surface`.
  -- * See @ref Surface-Capabilities for more details.
  -- *
  -- * @param adapter
  -- * The @ref WGPUAdapter to get capabilities for presenting to this @ref WGPUSurface.
  -- *
  -- * @param capabilities
  -- * The structure to fill capabilities in.
  -- * It may contain memory allocations so `::wgpuSurfaceCapabilitiesFreeMembers` must be called to avoid memory leaks.
  -- * This parameter is @ref ReturnedWithOwnership.
  -- *
  -- * @returns
  -- * Indicates if there was an @ref OutStructChainError.
  --

   function wgpuSurfaceGetCapabilities
     (surface : WGPUSurface;
      adapter : WGPUAdapter;
      capabilities : access WGPUSurfaceCapabilities) return WGPUStatus  -- webgpu.h:3775
   with Import => True,
        Convention => C,
        External_Name => "wgpuSurfaceGetCapabilities";

  --*
  -- * Returns the @ref WGPUTexture to render to `surface` this frame along with metadata on the frame.
  -- * Returns `NULL` and @ref WGPUSurfaceGetCurrentTextureStatus_Error if the surface is not configured.
  -- *
  -- * See @ref Surface-Presenting for more details.
  -- *
  -- * @param surfaceTexture
  -- * The structure to fill the @ref WGPUTexture and metadata in.
  --

   procedure wgpuSurfaceGetCurrentTexture (surface : WGPUSurface; surfaceTexture : access WGPUSurfaceTexture)  -- webgpu.h:3785
   with Import => True,
        Convention => C,
        External_Name => "wgpuSurfaceGetCurrentTexture";

  --*
  -- * Shows `surface`'s current texture to the user.
  -- * See @ref Surface-Presenting for more details.
  -- *
  -- * @returns
  -- * Returns @ref WGPUStatus_Error if the surface doesn't have a current texture.
  --

   function wgpuSurfacePresent (surface : WGPUSurface) return WGPUStatus  -- webgpu.h:3793
   with Import => True,
        Convention => C,
        External_Name => "wgpuSurfacePresent";

  --*
  -- * Modifies the label used to refer to `surface`.
  -- *
  -- * @param label
  -- * The new label.
  --

   procedure wgpuSurfaceSetLabel (surface : WGPUSurface; label : WGPUStringView)  -- webgpu.h:3800
   with Import => True,
        Convention => C,
        External_Name => "wgpuSurfaceSetLabel";

  --*
  -- * Removes the configuration for `surface`.
  -- * See @ref Surface-Configuration for more details.
  --

   procedure wgpuSurfaceUnconfigure (surface : WGPUSurface)  -- webgpu.h:3805
   with Import => True,
        Convention => C,
        External_Name => "wgpuSurfaceUnconfigure";

   procedure wgpuSurfaceAddRef (surface : WGPUSurface)  -- webgpu.h:3806
   with Import => True,
        Convention => C,
        External_Name => "wgpuSurfaceAddRef";

   procedure wgpuSurfaceRelease (surface : WGPUSurface)  -- webgpu.h:3807
   with Import => True,
        Convention => C,
        External_Name => "wgpuSurfaceRelease";

  --* @}
  --*
  -- * \defgroup WGPUSurfaceCapabilitiesMethods WGPUSurfaceCapabilities methods
  -- * \brief Functions whose first argument has type WGPUSurfaceCapabilities.
  -- *
  -- * @{
  --

  --*
  -- * Frees array members of WGPUSurfaceCapabilities which were allocated by the API.
  --

   procedure wgpuSurfaceCapabilitiesFreeMembers (surfaceCapabilities : WGPUSurfaceCapabilities)  -- webgpu.h:3821
   with Import => True,
        Convention => C,
        External_Name => "wgpuSurfaceCapabilitiesFreeMembers";

  --* @}
  --*
  -- * \defgroup WGPUTextureMethods WGPUTexture methods
  -- * \brief Functions whose first argument has type WGPUTexture.
  -- *
  -- * @{
  --

   function wgpuTextureCreateView (texture : WGPUTexture; descriptor : access constant WGPUTextureViewDescriptor) return WGPUTextureView  -- webgpu.h:3832
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureCreateView";

   procedure wgpuTextureDestroy (texture : WGPUTexture)  -- webgpu.h:3833
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureDestroy";

   function wgpuTextureGetDepthOrArrayLayers (texture : WGPUTexture) return bits_stdint_uintn_h.uint32_t  -- webgpu.h:3834
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureGetDepthOrArrayLayers";

   function wgpuTextureGetDimension (texture : WGPUTexture) return WGPUTextureDimension  -- webgpu.h:3835
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureGetDimension";

   function wgpuTextureGetFormat (texture : WGPUTexture) return WGPUTextureFormat  -- webgpu.h:3836
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureGetFormat";

   function wgpuTextureGetHeight (texture : WGPUTexture) return bits_stdint_uintn_h.uint32_t  -- webgpu.h:3837
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureGetHeight";

   function wgpuTextureGetMipLevelCount (texture : WGPUTexture) return bits_stdint_uintn_h.uint32_t  -- webgpu.h:3838
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureGetMipLevelCount";

   function wgpuTextureGetSampleCount (texture : WGPUTexture) return bits_stdint_uintn_h.uint32_t  -- webgpu.h:3839
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureGetSampleCount";

   function wgpuTextureGetUsage (texture : WGPUTexture) return WGPUTextureUsage  -- webgpu.h:3840
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureGetUsage";

   function wgpuTextureGetWidth (texture : WGPUTexture) return bits_stdint_uintn_h.uint32_t  -- webgpu.h:3841
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureGetWidth";

   procedure wgpuTextureSetLabel (texture : WGPUTexture; label : WGPUStringView)  -- webgpu.h:3842
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureSetLabel";

   procedure wgpuTextureAddRef (texture : WGPUTexture)  -- webgpu.h:3843
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureAddRef";

   procedure wgpuTextureRelease (texture : WGPUTexture)  -- webgpu.h:3844
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureRelease";

  --* @}
  --*
  -- * \defgroup WGPUTextureViewMethods WGPUTextureView methods
  -- * \brief Functions whose first argument has type WGPUTextureView.
  -- *
  -- * @{
  --

   procedure wgpuTextureViewSetLabel (textureView : WGPUTextureView; label : WGPUStringView)  -- webgpu.h:3855
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureViewSetLabel";

   procedure wgpuTextureViewAddRef (textureView : WGPUTextureView)  -- webgpu.h:3856
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureViewAddRef";

   procedure wgpuTextureViewRelease (textureView : WGPUTextureView)  -- webgpu.h:3857
   with Import => True,
        Convention => C,
        External_Name => "wgpuTextureViewRelease";

  --* @}
  --* @}
  -- extern "C"
end webgpu_h;

pragma Style_Checks (On);
pragma Warnings (On, "-gnatwu");
