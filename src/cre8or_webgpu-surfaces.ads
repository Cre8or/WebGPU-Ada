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



pragma Elaborate_All (Ada.Finalization);





package Cre8or_WebGPU.Surfaces is



	-- Use clauses
	--use Cre8or_WebGPU.Commands;



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
		-- Helper function to set the surface's raw pointer. For internal use only.
		-----------------------------------------------------------------------------------------------------------------
		not overriding procedure Set_Raw_Internal (
			This : in out T_Surface;
			Raw  : in     T_WGPUSurface
		);



private



	-- Types
	type T_Surface is new Ada.Finalization.Controlled with record
		m_Surface : T_WGPUSurface;
	end record;

		-- Primitives
		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Adjust (This : in out T_Surface);

		-----------------------------------------------------------------------------------------------------------------
		overriding procedure Finalize (This : in out T_Surface);



end Cre8or_WebGPU.Surfaces;
