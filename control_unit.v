module control_unit (
	output reg Gra, Grb, Grc, Rin, Rout, BAout,
	HIout, HIin, LOout, LOin, Zhighout, Zlowout, 
	Zin, Yin, MDRout, MDRin, MARin, PCout, CONin, 
	PCin, IRin, Out_portIn, conIn, Read, Write, Run, Clear,
	input [31:0] IR,
	input Clock, Reset, Stop, conOut
);

parameter reset_state = 8'b00000000, fetch0 = 8'b00000001, fetch1 = 8'b00000010, fetch2 = 8'b00000011,
			add3 = 