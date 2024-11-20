pragma License (Unrestricted);





with WebGPU.API;
with WebGPU.Exceptions;



pragma Elaborate_All (WebGPU.API);
pragma Elaborate_All (WebGPU.Exceptions);





package body WebGPU.Commands is



	-- Use clauses
	use WebGPU.API;
	use WebGPU.Exceptions;



	-- Types
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Command_Buffer
	--------------------------------------------------------------------------------------------------------------------------------
	not overriding function Is_Initialised (This : in T_Command_Buffer) return Boolean is
	begin

		return This.m_Buffer /= null;

	end Is_Initialised;

	--------------------------------------------------------------------------------------------------------------------------------
	not overriding procedure Set_Raw_Internal (
		This : in out T_Command_Buffer;
		Raw  : in     T_WGPUCommandBuffer
	) is
	begin

		This.m_Buffer := Raw;

	end Set_Raw_Internal;



	-- Bodies



-- PRIVATE



	-- Primitives
	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Command_Buffer
	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Command_Buffer) is
	begin

		if This.m_Buffer = null then
			return;
		end if;

		wgpuCommandBufferAddRef (This.m_Buffer);

	end Adjust;

	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Command_Buffer) is
	begin

		if This.m_Buffer = null then
			return;
		end if;

		wgpuCommandBufferRelease (This.m_Buffer);
		This.m_Buffer := null;

	end Finalize;

	--------------------------------------------------------------------------------------------------------------------------------
	-- T_Command_Encoder
	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Adjust (This : in out T_Command_Encoder) is
	begin

		if This.m_Encoder = null then
			return;
		end if;

		wgpuCommandEncoderAddRef (This.m_Encoder);

	end Adjust;

	--------------------------------------------------------------------------------------------------------------------------------
	overriding procedure Finalize (This : in out T_Command_Encoder) is
	begin

		if This.m_Encoder = null then
			return;
		end if;

		wgpuCommandEncoderRelease (This.m_Encoder);
		This.m_Encoder := null;

	end Finalize;




end WebGPU.Commands;
