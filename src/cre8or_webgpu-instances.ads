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

        with Cre8or_Raw_Window_Handle;

        with Cre8or_WebGPU.Adapters;
private with Cre8or_WebGPU.API;
        with Cre8or_WebGPU.Surfaces;
        with Cre8or_WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (Cre8or_Raw_Window_Handle);

pragma Elaborate_All (Cre8or_WebGPU.Adapters);
pragma Elaborate_All (Cre8or_WebGPU.API);
pragma Elaborate_All (Cre8or_WebGPU.Surfaces);
pragma Elaborate_All (Cre8or_WebGPU.Types);





package Cre8or_WebGPU.Instances is



	-- Use clauses
	use Cre8or_WebGPU.Adapters;
	use Cre8or_WebGPU.Surfaces;
	use Cre8or_WebGPU.Types;



	-- Types
	---------------------------------------------------------------------------------------------------------------------
	-- Wrapper handle for WebGPU instances. Performs automatic reference counting.
	---------------------------------------------------------------------------------------------------------------------
	type T_Instance is tagged private;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		-- Returns true if the instance has been initialised (is not null), otherwise false.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Is_Initialised (This : in T_Instance) return Boolean
		with Inline;

		-----------------------------------------------------------------------------------------------------------------
		-- Requests and returns an adapter for use with this instance.
		-- If the instance isn't initialised, the exception EX_INSTANCE_NOT_INITIALISED is raised.
		-- Arguments:
		-- Power_Preference sets which to choose, if multiple adapters are present, based on their power profile.
		-- High-performance often correponds to a discrete GPU, while low-power often corresponds to an integrated GPU.
		-- Backend_Type sets the particular backend the adapter should use. If this is not possible, an empty handle is
		-- returned.
		-- If Force_Fallback_Adapter is true, requires the adapter to have a particular backend type. If this is not
		-- possible, an empty adapter handle is returned.
		-- Compatibility_Mode allows backends that aren't 100% compliant to be used (in particular OpenGL/OpenGLES).
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Request_Adapter (
			This                   : in T_Instance;
			Power_Preference       : in T_Power_Preference := E_Undefined;
			Backend_Type           : in T_Backend_Type     := E_Undefined;
			Force_Fallback_Adapter : in Boolean            := false;
			Compatibility_Mode     : in Boolean            := false;
			Compatible_Surface     : in T_Surface          := C_Null_Surface
		) return T_Adapter;

		-----------------------------------------------------------------------------------------------------------------
		-- Creates a WebGPU window surface from the specified raw window handle. Intended to enable compatibility with
		-- external libraries that supply windows, such as Glfw.
		-----------------------------------------------------------------------------------------------------------------
		not overriding function Create_Window_Surface (
			This              : in T_Instance;
			Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
		) return T_Surface
		with Inline;



	-- Specifications
	---------------------------------------------------------------------------------------------------------------------
	-- Creates a new WebGPU instance.
	---------------------------------------------------------------------------------------------------------------------
	function Create_Instance return T_Instance;



private



	-- Use clauses
	use Cre8or_WebGPU.API;



	-- Types
	type T_Request_Userdata is record
		Adapter       : T_WGPUAdapter;
		Request_Ended : Boolean := false;
	end record
	with Convention => C_Pass_By_Copy;

	type T_Instance is new Ada.Finalization.Controlled with record
		m_Instance : T_WGPUInstance;
	end record;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Instance);

		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Instance);



	-- Specifications
	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_AppKit (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface;

	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_Windows (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface;

	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_Xlib (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface;

	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_Xcb (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface;

	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_Wayland (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface;

	---------------------------------------------------------------------------------------------------------------------
	procedure Request_Instance_Callback (
		status   : T_Request_Adapter_Status;
		adapter  : T_WGPUAdapter;
		message  : T_WGPUStringView;
		userdata : T_Address := C_Null_Address
	) with Convention => C;



end Cre8or_WebGPU.Instances;
