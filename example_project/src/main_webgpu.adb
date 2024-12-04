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

with Example_Application;



pragma Elaborate_All (Ada.Text_IO);

pragma Elaborate_All (Example_Application);





procedure Main_WebGPU is



	-- Use clauses
	use Ada;



	-- Variables
	Application : Example_Application.T_Application;



begin



	Text_IO.Put_Line ("Starting example application...");

	Application.Run;

	Text_IO.Put_Line ("SUCCESS");



end Main_WebGPU;
