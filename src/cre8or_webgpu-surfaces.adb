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





with Cre8or_WebGPU.API;



pragma Elaborate_All (Cre8or_WebGPU.API);





package body Cre8or_WebGPU.Surfaces is



	-- Use clauses
	use Cre8or_WebGPU.API;



	-- Types
	---------------------------------------------------------------------------------------------------------------------
	-- T_Surface
	---------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Surface) return Boolean is
	begin

		return This.m_Surface /= null;

	end Is_Initialised;

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



end Cre8or_WebGPU.Surfaces;
