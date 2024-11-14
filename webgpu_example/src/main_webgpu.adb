pragma License (Unrestricted);




with Ada.Text_IO;

with WebGPU.Instances;
with WebGPU.Types;



pragma Elaborate_All (Ada.Text_IO);

pragma Elaborate_All (WebGPU.Instances);
pragma Elaborate_All (WebGPU.Types);





procedure Main_WebGPU is



	-- Use clauses
	use Ada;
	use WebGPU.Instances;
	use WebGPU.Types;



	-- Variables
	Instance : T_Instance;
	Adapter  : T_Adapter;


begin



	Instance := Create_Instance;
	Adapter  := Instance.Request_Adapter (
		Backend_Type       => E_OpenGL,
		Compatibility_Mode => true
	);

	if not Instance.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Instance is null");
		return;
	end if;

	if not Adapter.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Adapter is null");
		return;
	end if;

	Text_IO.Put_Line ("SUCCESS");



end Main_WebGPU;
