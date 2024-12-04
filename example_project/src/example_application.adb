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

with Cre8or_WebGPU.Commands;



pragma Elaborate_All (Ada.Text_IO);

pragma Elaborate_All (Cre8or_WebGPU.Commands);





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
			Cre8or_Glfw.Initialise;
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
			Cre8or_Glfw.Shut_Down;
		end if;

		This.m_Initialised := false;

	end Finalize;

	-----------------------------------------------------------------------------------------------------------------
	not overriding procedure Initialise_WebGPU_Data (This : in out T_Application) is
	begin

		This.m_Instance := Create_Instance;
		if not This.m_Instance.Is_Initialised then
			Text_IO.Put_Line ("ERROR: Instance is null");
			raise EX_APPLICATION_BROKE;
		end if;

		This.m_Adapter := This.m_Instance.Request_Adapter;
		if not This.m_Adapter.Is_Initialised then
			Text_IO.Put_Line ("ERROR: Adapter is null");
			raise EX_APPLICATION_BROKE;
		end if;

		This.m_Device := This.m_Adapter.Request_Device;
		if not This.m_Device.Is_Initialised then
			Text_IO.Put_Line ("ERROR: Device is null");
			raise EX_APPLICATION_BROKE;
		end if;

		This.m_Window.Initialise (640, 480, "WebGPU Example");
		This.m_Surface := This.m_Instance.Create_Window_Surface (This.m_Window.Get_Raw_Handle);

		if not This.m_Surface.Is_Initialised then
			Text_IO.Put_Line ("ERROR: Surface is null");
			raise EX_APPLICATION_BROKE;
		end if;

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
			Cre8or_Glfw.Poll_Events;

			delay 0.01;

		end loop;

	end Main_Loop;



end Example_Application;
