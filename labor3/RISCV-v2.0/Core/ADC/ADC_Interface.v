<<<<<<< HEAD
=======
`ifndef PARAM
	`include "../Parametros.v"
`endif

>>>>>>> origin/joystick_exceptions
module ADC_Interface(
    input         iCLK_50,
    input         iCLK,
    input         Reset,
    inout         ADC_CS_N,
    output        ADC_DIN,
    input         ADC_DOUT,
    output        ADC_SCLK,
<<<<<<< HEAD
=======

>>>>>>> origin/joystick_exceptions
    //  Barramento de IO
    input         wReadEnable, wWriteEnable,
    input  [3:0]  wByteEnable,
    input  [31:0] wAddress, wWriteData,
    output [31:0] wReadData
);

<<<<<<< HEAD


	
// Fazer :)




endmodule



=======
wire [11:0] CH [7:0];

joystick joystick0(  
    .CLOCK    (iCLK_50),
    .ADC_SCLK (ADC_SCLK),
    .ADC_CS_N (ADC_CS_N),
    .ADC_DOUT (ADC_DOUT),
    .ADC_DIN  (ADC_DIN),
    .CH0      (CH[0]),
    .CH1      (CH[1]),
    .CH2      (CH[2]),
    .CH3      (CH[3]),
    .CH4      (CH[4]),
    .CH5      (CH[5]),
    .CH6      (CH[6]),
    .CH7      (CH[7]),
    .RESET    (Reset),
);

reg[31:0] ch_register[7:0];

always @(posedge iCLK)
begin
    ch_register[0] <= {20'b0, CH[0]};
    ch_register[1] <= {20'b0, CH[1]};
    ch_register[2] <= {20'b0, CH[2]};
    ch_register[3] <= {20'b0, CH[3]};
    ch_register[4] <= {20'b0, CH[4]};
    ch_register[5] <= {20'b0, CH[5]};
    ch_register[6] <= {20'b0, CH[6]};
    ch_register[7] <= {20'b0, CH[7]};
end

always @(*)
	if(wReadEnable)
        case(wAddress)
            ADC_CH0_ADDRESS: wReadData <= ch_register[0];
            ADC_CH1_ADDRESS: wReadData <= ch_register[1];
            ADC_CH2_ADDRESS: wReadData <= ch_register[2];
            ADC_CH3_ADDRESS: wReadData <= ch_register[3];
            ADC_CH4_ADDRESS: wReadData <= ch_register[4];
            ADC_CH5_ADDRESS: wReadData <= ch_register[5];
            ADC_CH6_ADDRESS: wReadData <= ch_register[6];
            ADC_CH7_ADDRESS: wReadData <= ch_register[7];
            default: wReadData <= 32'hzzzzzzzz;
        endcase
	else	
		wReadData <= 32'hzzzzzzzz;

endmodule
>>>>>>> origin/joystick_exceptions
