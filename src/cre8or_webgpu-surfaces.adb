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





with Cre8or_WebGPU.Exceptions;



pragma Elaborate_All (Cre8or_WebGPU.Exceptions);





package body Cre8or_WebGPU.Surfaces is



	-- Use clauses
	use Cre8or_WebGPU.Exceptions;



	-- Types
	---------------------------------------------------------------------------------------------------------------------
	-- T_Surface
	---------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Surface) return Boolean is
	begin

		return This.m_Surface /= null;

	end Is_Initialised;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Get_Raw_Internal (This : in T_Surface) return T_WGPUSurface is
	begin

		return This.m_Surface;

	end Get_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This : in out T_Surface;
		Raw  : in     T_WGPUSurface
	) is
	begin

		This.Finalize;
		This.m_Surface := Raw;
		This.Adjust;

	end Set_Raw_Internal;

	---------------------------------------------------------------------------------------------------------------------
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
	) is

		Config              : aliased T_WGPUSurfaceConfiguration;
		View_Formats_Ref    : access T_Texture_Format;
		View_Formats_Length : constant T_Size := View_Formats'Length;

	begin

		if This.m_Surface = null then
			raise EX_SURFACE_NOT_INITIALISED;
		end if;

		if not Device.Is_Initialised then
			raise EX_DEVICE_NOT_INITIALISED;
		end if;

		if View_Formats_Length > 0 then
			View_Formats_Ref := View_Formats (View_Formats'First)'Unrestricted_Access;
		end if;

		Config := (
			device          => Device.Get_Raw_Internal,
			format          => Format,
			usage           => Usage,
			viewFormatCount => View_Formats_Length,
			viewFormats     => View_Formats_Ref,
			alphaMode       => Alpha_Mode,
			width           => T_UInt32 (Width),
			height          => T_UInt32 (Height),
			presentMode     => Present_Mode,
			others          => <>
		);

		wgpuSurfaceConfigure (This.m_Surface, Config'Access);

	end Configure;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Get_Capabilities (
		This    : in T_Surface;
		Adapter : in T_Adapter'Class
	) return T_Surface_Capabilities is

		Capabilities_Internal : aliased T_WGPUSurfaceCapabilities;
		Status : T_Status;

	begin

		if This.m_Surface = null then
			raise EX_SURFACE_NOT_INITIALISED;
		end if;

		if not Adapter.Is_Initialised then
			raise EX_ADAPTER_NOT_INITIALISED;
		end if;

		Status := wgpuSurfaceGetCapabilities (This.m_Surface, Adapter.Get_Raw_Internal, Capabilities_Internal'Access);

		if Status /= E_Success then
			raise EX_REQUEST_ERROR;
		end if;

		-- Convert the internal data and deallocate it before returning
		return Result : constant T_Surface_Capabilities := Convert (Capabilities_Internal) do
			wgpuSurfaceCapabilitiesFreeMembers (Capabilities_Internal);
		end return;

	end Get_Capabilities;



-- PRIVATE



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Surface
	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Surface) is
	begin

		if This.m_Surface = null then
			return;
		end if;

		wgpuSurfaceAddRef (This.m_Surface);

	end Adjust;

	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Surface) is
	begin

		if This.m_Surface = null then
			return;
		end if;

		wgpuSurfaceRelease (This.m_Surface);
		This.m_Surface := null;

	end Finalize;



	-- Bodies
	---------------------------------------------------------------------------------------------------------------------
	function Convert (Capabilities : in T_WGPUSurfaceCapabilities) return T_Surface_Capabilities is

		use type T_Address;

		Formats_Length       : constant T_Natural := T_Natural (Capabilities.formatCount);
		Present_Modes_Length : constant T_Natural := T_Natural (Capabilities.presentModeCount);
		Alpha_Modes_Length   : constant T_Natural := T_Natural (Capabilities.alphaModeCount);

		Result : T_Surface_Capabilities;

	begin

		Result.Formats_Last       := T_Natural'Min (C_Max_Capability_Array_Length, Formats_Length);
		Result.Present_Modes_Last := T_Natural'Min (C_Max_Capability_Array_Length, Present_Modes_Length);
		Result.Alpha_Modes_Last   := T_Natural'Min (C_Max_Capability_Array_Length, Alpha_Modes_Length);

		-- Usages
		Result.Usages := Result.Usages or (Capabilities.usages and C_Texture_Usage_Copy_Src);
		Result.Usages := Result.Usages or (Capabilities.usages and C_Texture_Usage_Copy_Dst);
		Result.Usages := Result.Usages or (Capabilities.usages and C_Texture_Usage_Texture_Binding);
		Result.Usages := Result.Usages or (Capabilities.usages and C_Texture_Usage_Storage_Binding);
		Result.Usages := Result.Usages or (Capabilities.usages and C_Texture_Usage_Render_Attachment);

		-- Formats
		if Formats_Length > 0 and Capabilities.formats /= C_Null_Address then
			declare
				Formats : T_Texture_Format_Arr (1 .. Formats_Length)
				with Address => Capabilities.formats;

			begin
				for I in Formats'Range loop
					Result.Formats (I) := Formats (I);
				end loop;
			end;
		end if;

		-- Present modes
		if Present_Modes_Length > 0 and Capabilities.presentModes /= C_Null_Address then
			declare
				Present_Modes : T_Present_Mode_Arr (1 .. Present_Modes_Length)
				with Address => Capabilities.presentModes;

			begin
				for I in Present_Modes'Range loop
					Result.Present_Modes (I) := Present_Modes (I);
				end loop;
			end;
		end if;

		-- Alpha modes
		if Alpha_Modes_Length > 0 and Capabilities.alphaModes /= C_Null_Address then
			declare
				Alpha_Modes : T_Composite_Alpha_Mode_Arr (1 .. Alpha_Modes_Length)
				with Address => Capabilities.alphaModes;

			begin
				for I in Alpha_Modes'Range loop
					Result.Alpha_Modes (I) := Alpha_Modes (I);
				end loop;
			end;
		end if;

		return Result;

	end Convert;



end Cre8or_WebGPU.Surfaces;
