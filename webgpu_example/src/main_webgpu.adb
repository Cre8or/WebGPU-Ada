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
	Descriptor : aliased T_WGPUInstanceDescriptor;
	Instance   : T_WGPUInstance;



begin



	Instance := wgpuCreateInstance (Descriptor'Access);

	if Instance /= null then
		Text_IO.Put_Line ("SUCCESS");
	else
		Text_IO.Put_Line ("ERROR: Instance is null");
	end if;

	wgpuInstanceRelease (Instance);



end Main_WebGPU;
