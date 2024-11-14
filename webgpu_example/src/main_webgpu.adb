pragma License (Unrestricted);




with Ada.Text_IO;

with WebGPU.Adapters;
with WebGPU.Instances;



pragma Elaborate_All (Ada.Text_IO);

pragma Elaborate_All (WebGPU.Adapters);
pragma Elaborate_All (WebGPU.Instances);





procedure Main_WebGPU is



	-- Use clauses
	use Ada;
	use WebGPU.Adapters;
	use WebGPU.Instances;



	-- Variables
	Instance : T_Instance;
	Adapter  : T_Adapter;


begin



	Instance := Create_Instance;
	Adapter  := Instance.Request_Adapter;

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
