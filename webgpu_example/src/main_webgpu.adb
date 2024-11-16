pragma License (Unrestricted);




with Ada.Text_IO;

with WebGPU.Adapters;
with WebGPU.Devices;
with WebGPU.Instances;
with WebGPU.Types;



pragma Elaborate_All (Ada.Text_IO);

pragma Elaborate_All (WebGPU.Adapters);
pragma Elaborate_All (WebGPU.Devices);
pragma Elaborate_All (WebGPU.Instances);
pragma Elaborate_All (WebGPU.Types);





procedure Main_WebGPU is



	-- Use clauses
	use Ada;
	use WebGPU.Adapters;
	use WebGPU.Devices;
	use WebGPU.Instances;
	use WebGPU.Types;



	-- Variables
	Instance : T_Instance;
	Adapter  : T_Adapter;
	Device   : T_Device;



begin



	Instance := Create_Instance;
	Adapter  := Instance.Request_Adapter;
	Device   := Adapter.Request_Device (
		(E_Timestamp_Query, E_Clip_Distances)
	);

	if not Instance.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Instance is null");
		return;
	end if;

	if not Adapter.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Adapter is null");
		return;
	end if;

	if not Device.Is_Initialised then
		Text_IO.Put_Line ("ERROR: Device is null");
		return;
	end if;

	Text_IO.Put_Line ("SUCCESS");



end Main_WebGPU;
