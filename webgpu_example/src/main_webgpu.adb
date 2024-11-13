pragma License (Unrestricted);




with Ada.Text_IO;

with WebGPU.Instances;



pragma Elaborate_All (Ada.Text_IO);

pragma Elaborate_All (WebGPU.Instances);





procedure Main_WebGPU is



	-- Use clauses
	use Ada;
	use WebGPU.Instances;



	-- Variables
	Instance : T_WGPU_Instance;



begin



	Instance := Create_Instance;

	if Instance.Is_Initialised then
		Text_IO.Put_Line ("SUCCESS");
	else
		Text_IO.Put_Line ("ERROR: Instance is null");
	end if;



end Main_WebGPU;
