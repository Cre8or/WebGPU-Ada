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

with WebGPU.Adapters;
with WebGPU.Commands;
with WebGPU.Devices;
with WebGPU.Instances;
with WebGPU.Queues;
with WebGPU.Types;



pragma Elaborate_All (Ada.Text_IO);

pragma Elaborate_All (WebGPU.Adapters);
pragma Elaborate_All (WebGPU.Commands);
pragma Elaborate_All (WebGPU.Devices);
pragma Elaborate_All (WebGPU.Instances);
pragma Elaborate_All (WebGPU.Queues);
pragma Elaborate_All (WebGPU.Types);





procedure Main_WebGPU is



	-- Use clauses
	use Ada;
	use WebGPU.Adapters;
	use WebGPU.Commands;
	use WebGPU.Devices;
	use WebGPU.Instances;
	use WebGPU.Queues;
	use WebGPU.Types;



	-- Variables
	Instance : T_Instance;
	Adapter  : T_Adapter;
	Device   : T_Device;
	Limits   : T_Device_Limits;
	Queue    : T_Queue;

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


	Text_IO.Put_Line ("SUCCESS");



end Main_WebGPU;
