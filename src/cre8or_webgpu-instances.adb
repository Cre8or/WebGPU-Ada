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





package body Cre8or_WebGPU.Instances is



	-- Use clauses
	use Cre8or_WebGPU.Exceptions;



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Instance
	---------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Instance) return Boolean is
	begin

		return This.m_Instance /= null;

	end Is_Initialised;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Request_Adapter (
		This                   : in T_Instance;
		Power_Preference       : in T_Power_Preference := E_Undefined;
		Backend_Type           : in T_Backend_Type     := E_Undefined;
		Force_Fallback_Adapter : in Boolean            := false;
		Compatibility_Mode     : in Boolean            := false;
		Compatible_Surface     : in T_Surface          := C_Null_Surface
	) return T_Adapter is

		Adapter   : T_Adapter;
		Options   : aliased T_WGPURequestAdapterOptions;
		User_Data : aliased T_Request_Userdata;

	begin

		if This.m_Instance = null then
			raise EX_INSTANCE_NOT_INITIALISED;
		end if;

		Options := (
			powerPreference      => Power_Preference,
			backendType          => Backend_Type,
			forceFallbackAdapter => T_WGPUBool (Force_Fallback_Adapter),
			compatibilityMode    => T_WGPUBool (Compatibility_Mode),
			compatibleSurface    => Compatible_Surface.Get_Raw_Internal,
			others               => <>
		);

		wgpuInstanceRequestAdapter (
			instance => This.m_Instance,
			options  => Options'Access,
			callback => Request_Instance_Callback'Access,
			userdata => User_Data'Address
		);

		-- Safeguard against potential Dawn issues (this should never happen, so we need to know about it)
		if not User_Data.Request_Ended then
			raise EX_REQUEST_ERROR with "wgpuInstanceRequestAdapter callback failed";
		end if;

		Adapter.Set_Raw_Internal (User_Data.Adapter);

		return Adapter;

	end Request_Adapter;

	---------------------------------------------------------------------------------------------------------------------
	not overriding function Create_Window_Surface (
		This              : in T_Instance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_Surface is

		use Cre8or_Raw_Window_Handle;

		Surface          : T_Surface;
		Surface_Internal : T_WGPUSurface;

	begin

		if This.m_Instance = null then
			raise EX_INSTANCE_NOT_INITIALISED;
		end if;

		Surface_Internal := (case Raw_Window_Handle.Kind is
			when E_AppKit  => Create_Window_Surface_AppKit  (This.m_Instance, Raw_Window_Handle),
			when E_Win32   => Create_Window_Surface_Windows (This.m_Instance, Raw_Window_Handle),
			when E_Xlib    => Create_Window_Surface_Xlib    (This.m_Instance, Raw_Window_Handle),
			when E_Xcb     => Create_Window_Surface_Xcb     (This.m_Instance, Raw_Window_Handle),
			when E_Wayland => Create_Window_Surface_Wayland (This.m_Instance, Raw_Window_Handle)
		);

		Surface.Set_Raw_Internal (Surface_Internal);

		return Surface;

	end Create_Window_Surface;



	-- Bodies
	---------------------------------------------------------------------------------------------------------------------
	function Create_Instance return T_Instance is
	begin

		return (Ada.Finalization.Controlled with
			m_Instance => wgpuCreateInstance (C_Null_Address)
		);

	end Create_Instance;



-- PRIVATE



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Instance
	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Instance) is
	begin

		if This.m_Instance = null then
			return;
		end if;

		wgpuInstanceAddRef (This.m_Instance);

	end Adjust;

	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Instance) is
	begin

		if This.m_Instance = null then
			return;
		end if;

		wgpuInstanceRelease (This.m_Instance);
		This.m_Instance := null;

	end Finalize;



	-- Bodies
	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_AppKit (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface is

		Source_Layer       : aliased T_WGPUSurfaceSourceMetalLayer;
		Surface_Descriptor : aliased T_WGPUSurfaceDescriptor_AppKit;

	begin

		Source_Layer.chain.sType := E_Surface_Source_Metal_Layer;
		Source_Layer.layer       := Raw_Window_Handle.appkit_ns_view;

		Surface_Descriptor.nextInChain := Source_Layer'Unchecked_Access;

		return wgpuInstanceCreateSurface_AppKit (Instance, Surface_Descriptor'Access);

	end Create_Window_Surface_AppKit;

	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_Windows (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface is

		Source_Layer       : aliased T_WGPUSurfaceSourceWindowsHWND;
		Surface_Descriptor : aliased T_WGPUSurfaceDescriptor_Windows;

	begin

		Source_Layer.chain.sType := E_Surface_Source_Windows_HWND;
		Source_Layer.hinstance   := Raw_Window_Handle.win32_hinstance;
		Source_Layer.hwnd        := Raw_Window_Handle.win32_hwnd;

		Surface_Descriptor.nextInChain := Source_Layer'Unchecked_Access;

		return wgpuInstanceCreateSurface_Windows (Instance, Surface_Descriptor'Access);

	end Create_Window_Surface_Windows;

	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_Xlib (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface is

		Source_Layer       : aliased T_WGPUSurfaceSourceXlibWindow;
		Surface_Descriptor : aliased T_WGPUSurfaceDescriptor_Xlib;

	begin

		Source_Layer.chain.sType := E_Surface_Source_Xlib_Window;
		Source_Layer.display     := Raw_Window_Handle.xlib_display;
		Source_Layer.window      := T_UInt64 (Raw_Window_Handle.xlib_window);

		Surface_Descriptor.nextInChain := Source_Layer'Unchecked_Access;

		return wgpuInstanceCreateSurface_Xlib (Instance, Surface_Descriptor'Access);

	end Create_Window_Surface_Xlib;

	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_Xcb (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface is

		Source_Layer       : aliased T_WGPUSurfaceSourceXCBWindow;
		Surface_Descriptor : aliased T_WGPUSurfaceDescriptor_Xcb;

	begin

		Source_Layer.chain.sType := E_Surface_Source_XCB_Window;
		Source_Layer.connection  := Raw_Window_Handle.xcb_connection;
		Source_Layer.window      := T_UInt32 (Raw_Window_Handle.xcb_window_id);

		Surface_Descriptor.nextInChain := Source_Layer'Unchecked_Access;

		return wgpuInstanceCreateSurface_Xcb (Instance, Surface_Descriptor'Access);

	end Create_Window_Surface_Xcb;

	---------------------------------------------------------------------------------------------------------------------
	function Create_Window_Surface_Wayland (
		Instance          : in T_WGPUInstance;
		Raw_Window_Handle : in Cre8or_Raw_Window_Handle.T_Handle
	) return T_WGPUSurface is

		Source_Layer       : aliased T_WGPUSurfaceSourceWaylandSurface;
		Surface_Descriptor : aliased T_WGPUSurfaceDescriptor_Wayland;

	begin

		Source_Layer.chain.sType := E_Surface_Source_Wayland_Surface;
		Source_Layer.display     := Raw_Window_Handle.wayland_display;
		Source_Layer.surface     := Raw_Window_Handle.wayland_surface;

		Surface_Descriptor.nextInChain := Source_Layer'Unchecked_Access;

		return wgpuInstanceCreateSurface_Wayland (Instance, Surface_Descriptor'Access);

	end Create_Window_Surface_Wayland;

	---------------------------------------------------------------------------------------------------------------------
	procedure Request_Instance_Callback (
		status   : T_Request_Adapter_Status;
		adapter  : T_WGPUAdapter;
		message  : T_WGPUStringView;
		userdata : T_Address := C_Null_Address
	) is

		pragma Unreferenced (status);
		pragma Unreferenced (message);

		User_Data : aliased T_Request_Userdata
		with Import, Address => userdata;

	begin

		User_Data.Adapter       := adapter;
		User_Data.Request_Ended := true;

	end Request_Instance_Callback;



end Cre8or_WebGPU.Instances;
