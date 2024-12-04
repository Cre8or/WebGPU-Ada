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

private with Cre8or_Glfw.Windows;

private with Cre8or_WebGPU.Adapters;
private with Cre8or_WebGPU.Devices;
private with Cre8or_WebGPU.Instances;
private with Cre8or_WebGPU.Queues;
private with Cre8or_WebGPU.Surfaces;
private with Cre8or_WebGPU.Types;



pragma Elaborate_All (Ada.Finalization);

pragma Elaborate_All (Cre8or_Glfw.Windows);

pragma Elaborate_All (Cre8or_WebGPU.Adapters);
pragma Elaborate_All (Cre8or_WebGPU.Devices);
pragma Elaborate_All (Cre8or_WebGPU.Instances);
pragma Elaborate_All (Cre8or_WebGPU.Queues);
pragma Elaborate_All (Cre8or_WebGPU.Surfaces);
pragma Elaborate_All (Cre8or_WebGPU.Types);





package Example_Application is



	-- Exception
	EX_APPLICATION_BROKE : exception;



	-- Types
	type T_Application is tagged limited private;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		-- Starts the example application.
		-----------------------------------------------------------------------------------------------------------------
		not overriding procedure Run (This : in out T_Application);


private



	-- Use clauses
	use Cre8or_WebGPU.Adapters;
	use Cre8or_WebGPU.Devices;
	use Cre8or_WebGPU.Instances;
	use Cre8or_WebGPU.Queues;
	use Cre8or_WebGPU.Surfaces;
	use Cre8or_WebGPU.Types;



	-- Types
	type T_Application is new Ada.Finalization.Limited_Controlled with record
		m_Initialised : Boolean := false;

		m_Window : Cre8or_Glfw.Windows.T_Window;

		m_Instance : T_Instance;
		m_Adapter  : T_Adapter;
		m_Device   : T_Device;
		m_Limits   : T_Device_Limits;
		m_Queue    : T_Queue;
		m_Surface  : T_Surface;

	end record;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Application);

		-----------------------------------------------------------------------------------------------------------------
		-- Handles the initialisation of all WebGPU specific data during application startup.
		-----------------------------------------------------------------------------------------------------------------
		not overriding procedure Initialise_WebGPU_Data (This : in out T_Application);

		-----------------------------------------------------------------------------------------------------------------
		-- Performs the main loop of the application.
		-----------------------------------------------------------------------------------------------------------------
		not overriding procedure Main_Loop (This : in out T_Application);



	-- Variables
	G_Counter : Natural := 0;



end Example_Application;
