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





package Cre8or_WebGPU is



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

	type T_WGPUQueueImpl is private;
	type T_WGPUQueue is access all T_WGPUQueueImpl;

	type T_WGPUCommandBufferImpl is private;
	type T_WGPUCommandBuffer is access all T_WGPUCommandBufferImpl;

	type T_WGPUCommandEncoderImpl is private;
	type T_WGPUCommandEncoder is access all T_WGPUCommandEncoderImpl;



private



	-- Types
	type T_WGPUInstanceImpl is null record;

	type T_WGPUAdapterImpl is null record;

	type T_WGPUSurfaceImpl is null record;

	type T_WGPUDeviceImpl is null record;

	type T_WGPUQueueImpl is null record;

	type T_WGPUCommandBufferImpl is null record;

	type T_WGPUCommandEncoderImpl is null record;



end Cre8or_WebGPU;
