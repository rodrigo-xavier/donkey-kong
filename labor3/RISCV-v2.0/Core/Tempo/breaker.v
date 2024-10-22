// megafunction wizard: %LPM_CONSTANT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_CONSTANT 

// ============================================================
// File Name: breaker.v
// Megafunction Name(s):
// 			LPM_CONSTANT
//
// Simulation Library Files(s):
// 			
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 18.1.0 Build 625 09/12/2018 SJ Lite Edition
// ************************************************************


//Copyright (C) 2018  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


//lpm_constant CBX_AUTO_BLACKBOX="ALL" ENABLE_RUNTIME_MOD="YES" INSTANCE_NAME="BRK0" LPM_CVALUE=00000000 LPM_WIDTH=32 result
//VERSION_BEGIN 18.1 cbx_lpm_constant 2018:09:12:13:04:24:SJ cbx_mgl 2018:09:12:13:10:36:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = sld_mod_ram_rom 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  breaker_lpm_constant_kva
	( 
	result) ;
	output   [31:0]  result;

	wire  [31:0]   wire_mgl_prim1_data_write;

	sld_mod_ram_rom   mgl_prim1
	( 
	.data_write(wire_mgl_prim1_data_write));
	defparam
		mgl_prim1.cvalue = 32'b00000000000000000000000000000000,
		mgl_prim1.is_data_in_ram = 0,
		mgl_prim1.is_readable = 0,
		mgl_prim1.node_name = 1112689456,
		mgl_prim1.numwords = 1,
		mgl_prim1.shift_count_bits = 6,
		mgl_prim1.width_word = 32,
		mgl_prim1.widthad = 1;
	assign
		result = wire_mgl_prim1_data_write;
endmodule //breaker_lpm_constant_kva
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module breaker (
	result);

	output	[31:0]  result;

	wire [31:0] sub_wire0;
	wire [31:0] result = sub_wire0[31:0];

	breaker_lpm_constant_kva	breaker_lpm_constant_kva_component (
				.result (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "1"
// Retrieval info: PRIVATE: JTAG_ID STRING "BRK0"
// Retrieval info: PRIVATE: Radix NUMERIC "16"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: Value NUMERIC "0"
// Retrieval info: PRIVATE: nBit NUMERIC "32"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_CVALUE NUMERIC "0"
// Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=YES, INSTANCE_NAME=BRK0"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_CONSTANT"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "32"
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: GEN_FILE: TYPE_NORMAL breaker.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL breaker.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL breaker.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL breaker.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL breaker_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL breaker_bb.v FALSE
