pragma License (Unrestricted);




with Interfaces.C;



pragma Elaborate_All (Interfaces.C);





package WebGPU.Types is



	-- Types
	type T_Byte   is new Interfaces.C.char;
	type T_UByte  is new Interfaces.C.unsigned_char;
	type T_Short  is new Interfaces.C.short;
	type T_UShort is new Interfaces.C.unsigned_short;
	type T_Int    is new Interfaces.C.int;
	type T_UInt   is new Interfaces.C.unsigned;
	type T_Long   is new Interfaces.C.long;
	type T_ULong  is new Interfaces.C.unsigned_long;

	type T_Float  is new Interfaces.C.C_float;
	type T_Double is new Interfaces.C.double;

	type T_Size   is new Interfaces.C.size_t;

	type T_WGPUSType is new T_UInt;
	type T_WGPUBool  is new T_UInt;



end WebGPU.Types;
