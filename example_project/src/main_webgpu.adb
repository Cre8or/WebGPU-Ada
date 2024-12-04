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

with Cre8or_Glfw.Windows;

with Cre8or_WebGPU.Adapters;
with Cre8or_WebGPU.Commands;
with Cre8or_WebGPU.Devices;
with Cre8or_WebGPU.Instances;
with Cre8or_WebGPU.Queues;
with Cre8or_WebGPU.Surfaces;
with Cre8or_WebGPU.Types;



pragma Elaborate_All (Ada.Text_IO);

pragma Elaborate_All (Cre8or_Glfw.Windows);

pragma Elaborate_All (Cre8or_WebGPU.Adapters);
pragma Elaborate_All (Cre8or_WebGPU.Commands);
pragma Elaborate_All (Cre8or_WebGPU.Devices);
pragma Elaborate_All (Cre8or_WebGPU.Instances);
pragma Elaborate_All (Cre8or_WebGPU.Queues);
pragma Elaborate_All (Cre8or_WebGPU.Surfaces);
pragma Elaborate_All (Cre8or_WebGPU.Types);





procedure Main_WebGPU is



	-- Use clauses
	use Ada;

	use Cre8or_WebGPU.Adapters;
	use Cre8or_WebGPU.Commands;
	use Cre8or_WebGPU.Devices;
	use Cre8or_WebGPU.Instances;
	use Cre8or_WebGPU.Queues;
	use Cre8or_WebGPU.Surfaces;
	use Cre8or_WebGPU.Types;



	-- Variables
	Instance : T_Instance;
	Adapter  : T_Adapter;
	Device   : T_Device;
	Limits   : T_Device_Limits;
	Queue    : T_Queue;

	Window : Cre8or_Glfw.Windows.T_Window;

	Surface         : T_Surface;
	Command_Buffer  : T_Command_Buffer;
	Command_Encoder : T_Command_Encoder;



begin



	Instance := Create_Instance;
	if not Instance.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Instance is null");
		return;
	end if;

	Adapter := Instance.Request_Adapter;
	if not Adapter.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Adapter is null");
		return;
	end if;

	Device := Adapter.Request_Device;
	if not Device.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Device is null");
		return;
	end if;

	Limits := Device.Get_Limits;

	Cre8or_Glfw.Initialise;
	Window.Initialise (640, 480, "WebGPU Example");

	Surface := Instance.Create_Window_Surface (Window.Get_Raw_Handle);
	if not Surface.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Surface is null");
		return;
	end if;

	Queue := Device.Get_Queue;
	if not Queue.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Queue is null");
		return;
	end if;

	Command_Encoder := Device.Create_Command_Encoder ("test");
	if not Command_Encoder.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Command encoder is null");
		return;
	end if;

	Command_Encoder.Insert_Debug_Marker ("debug marker 1");
	Command_Encoder.Insert_Debug_Marker ("debug marker 2");
	Command_Buffer := Command_Encoder.Finish ("command buffer");
	Queue.Submit (Command_Buffer);

	for I in 1 .. 10 loop
		Device.Poll;

		delay 0.01;
	end loop;

	Cre8or_Glfw.Shut_Down;

	Text_IO.Put_Line ("SUCCESS");



end Main_WebGPU;
