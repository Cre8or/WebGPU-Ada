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





with Ada.Text_IO;

with Cre8or_Glfw.Context;

with Cre8or_WebGPU.Commands;
with Cre8or_WebGPU.Types;



pragma Elaborate_All (Ada.Text_IO);

pragma Elaborate_All (Cre8or_Glfw.Context);

pragma Elaborate_All (Cre8or_WebGPU.Commands);
pragma Elaborate_All (Cre8or_WebGPU.Types);





package body Example_Application is



	-- Use clauses
	use Ada;

	use Cre8or_WebGPU.Commands;



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Application
	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Run (This : in out T_Application) is
	begin

		if This.m_Initialised then
			return;
		end if;

		if G_Counter = 0 then
			Cre8or_Glfw.Context.Initialise;
		end if;
		G_Counter := G_Counter + 1;

		This.m_Initialised := true;

		This.Initialise_WebGPU_Data;
		This.Main_Loop;

	end Run;



-- PRIVATE



	-- Primitives
	---------------------------------------------------------------------------------------------------------------------
	-- T_Application
	---------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Application) is
	begin

		if not This.m_Initialised then
			return;
		end if;

		This.m_Window.Destroy;

		G_Counter := G_Counter - 1;
		if G_Counter = 0 then
			Cre8or_Glfw.Context.Shut_Down;
		end if;

		This.m_Initialised := false;

	end Finalize;

	-----------------------------------------------------------------------------------------------------------------
	not overriding procedure Initialise_WebGPU_Data (This : in out T_Application) is

		C_Width  : constant := 640;
		C_Height : constant := 480;

		Capabilities : T_Surface_Capabilities;

	begin

		-- Initialise the Glfw window
		This.m_Window.Initialise (C_Width, C_Height, "WebGPU Example");

		This.m_Instance := Create_Instance;
		if not This.m_Instance.Is_Initialised then
			Text_IO.Put_Line ("ERROR: Instance is null");
			raise EX_APPLICATION_BROKE;
		end if;

		This.m_Surface := This.m_Instance.Create_Window_Surface (This.m_Window.Get_Raw_Handle);
		if not This.m_Surface.Is_Initialised then
			Text_IO.Put_Line ("ERROR: Surface is null");
			raise EX_APPLICATION_BROKE;
		end if;

		-- Initialise WebGPU and use the Glfw window as our surface
		This.m_Adapter := This.m_Instance.Request_Adapter (
			Compatible_Surface => This.m_Surface
		);

		if not This.m_Adapter.Is_Initialised then
			Text_IO.Put_Line ("ERROR: Adapter is null");
			raise EX_APPLICATION_BROKE;
		end if;

		This.m_Device := This.m_Adapter.Request_Device;
		if not This.m_Device.Is_Initialised then
			Text_IO.Put_Line ("ERROR: Device is null");
			raise EX_APPLICATION_BROKE;
		end if;

		-- Surface capabilities
		Capabilities := This.m_Surface.Get_Capabilities (This.m_Adapter);

		Text_IO.Put_Line ("Surface capabilities:");
		Text_IO.Put_Line ("Formats:       " & Capabilities.Formats_Last'Img);
		Text_IO.Put_Line ("Present modes: " & Capabilities.Present_Modes_Last'Img);
		Text_IO.Put_Line ("Alpha modes:   " & Capabilities.Alpha_Modes_Last'Img);

		if Capabilities.Formats_Last = 0 or else Capabilities.Formats (1) = E_Undefined then
			Text_IO.Put_Line ("ERROR: Surface has no supported formats!");
			raise EX_APPLICATION_BROKE;
		end if;

		if Capabilities.Present_Modes_Last = 0 then
			Text_IO.Put_Line ("ERROR: Surface has no supported present modes!");
			raise EX_APPLICATION_BROKE;
		end if;

		if Capabilities.Alpha_Modes_Last = 0 then
			Text_IO.Put_Line ("ERROR: Surface has no supported alpha modes!");
			raise EX_APPLICATION_BROKE;
		end if;

		This.m_Surface.Configure (
			Device       => This.m_Device,
			Width        => C_Width,
			Height       => C_Height,
			Format       => Capabilities.Formats (1),
			Usage        => Capabilities.Usages,
--			View_Formats => , -- No clue what to use here (maybe for sRGB?)
			Alpha_Mode   => Capabilities.Alpha_Modes (1),
			Present_Mode => Capabilities.Present_Modes (1)
		);

	end Initialise_WebGPU_Data;

	---------------------------------------------------------------------------------------------------------------------
	not overriding procedure Main_Loop (This : in out T_Application) is

		Command_Buffer  : T_Command_Buffer;
		Command_Encoder : T_Command_Encoder;

	begin

		while not This.m_Window.Should_Close loop

			This.m_Queue := This.m_Device.Get_Queue;
			if not This.m_Queue.Is_Initialised then
				Text_IO.Put_Line ("ERROR: Queue is null");
			raise EX_APPLICATION_BROKE;
			end if;

			Command_Encoder := This.m_Device.Create_Command_Encoder ("test");
			if not Command_Encoder.Is_Initialised then
				Text_IO.Put_Line ("ERROR: Command encoder is null");
				raise EX_APPLICATION_BROKE;
			end if;

			Command_Encoder.Insert_Debug_Marker ("debug marker 1");
			Command_Encoder.Insert_Debug_Marker ("debug marker 2");
			Command_Buffer := Command_Encoder.Finish ("command buffer");
			This.m_Queue.Submit (Command_Buffer);

			This.m_Device.Poll;
			Cre8or_Glfw.Context.Poll_Events;

			delay 0.01;

		end loop;

	end Main_Loop;



end Example_Application;
