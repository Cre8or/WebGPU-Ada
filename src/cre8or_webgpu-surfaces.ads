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





private with Ada.Finalization;

        with Cre8or_WebGPU.Adapters;
private with Cre8or_WebGPU.API;
        with Cre8or_WebGPU.Devices;
        with Cre8or_WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (Cre8or_WebGPU.Adapters);
pragma Elaborate_All (Cre8or_WebGPU.API);
pragma Elaborate_All (Cre8or_WebGPU.Devices);
pragma Elaborate_All (Cre8or_WebGPU.Types);


pragma Elaborate_All (Ada.Finalization);





package Cre8or_WebGPU.Surfaces is



	-- Use clauses
	use Cre8or_WebGPU.Adapters;
	use Cre8or_WebGPU.Devices;
	use Cre8or_WebGPU.Types;



	-- Types
	---------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU surfaces. Performs automatic reference counting.
	---------------------------------------------------------------------------------------------------------------------
	type T_Surface is tagged private;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		-- Returns true if the surface has been initialised (is not null), otherwise false.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Surface) return Boolean
		with Inline;

		-----------------------------------------------------------------------------------------------------------------
		-- Helper function to retrieve the surface's raw pointer. For internal use only.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Get_Raw_Internal (This : in T_Surface) return T_WGPUSurface
		with Inline;

		-----------------------------------------------------------------------------------------------------------------
		-- Helper function to set the surface's raw pointer. For internal use only.
		-----------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Surface;
			Raw  : in     T_WGPUSurface
		);

		-----------------------------------------------------------------------------------------------------------------
		-- Returns the capabilities of the surface when used with the given adapter. The surface and adapter must both be
		-- initialised.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Get_Capabilities (
			This    : in T_Surface;
			Adapter : in T_Adapter'Class
		) return T_Surface_Capabilities;

		-----------------------------------------------------------------------------------------------------------------
		-- Configures the surface for use with the specified device. The surface and device must both be initialised.
		-----------------------------------------------------------------------------------------------------------------
		not overriding procedure Configure (
			This         : in out T_Surface;
			Device       : in out T_Device'Class;
			Width        : in     T_Positive;
			Height       : in     T_Positive;
			Format       : in     T_Texture_Format       := E_Undefined;
			Usage        : in     T_Texture_Usage        := C_Texture_Usage_Undefined;
			View_Formats : in     T_Texture_Format_Arr   := (1 .. 0 => E_Undefined);
			Alpha_Mode   : in     T_Composite_Alpha_Mode := E_Auto;
			Present_Mode : in     T_Present_Mode         := E_Fifo
		);



	-- Constants
	C_Null_Surface : constant T_Surface;



private



	-- Use clauses
	use Cre8or_WebGPU.API;



	-- Types
	type T_Surface is new Ada.Finalization.Controlled with record
		m_Surface : T_WGPUSurface;
	end record;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Surface);

		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Surface);



	-- Specifications
	---------------------------------------------------------------------------------------------------------------------
	function Convert (Capabilities : in T_WGPUSurfaceCapabilities) return T_Surface_Capabilities;



	-- Constants
	C_Null_Surface : constant T_Surface := (Ada.Finalization.Controlled with others => <>);



end Cre8or_WebGPU.Surfaces;
