module ADC_Interface(
    input         iCLK_50,
    input         iCLK,
    input         Reset,
    inout         ADC_CS_N,
    output        ADC_DIN,
    input         ADC_DOUT,
    output        ADC_SCLK,
    //  Barramento de IO
    input         wReadEnable, wWriteEnable,
    input  [3:0]  wByteEnable,
    input  [31:0] wAddress, wWriteData,
    output [31:0] wReadData
);



	
// Fazer :)




endmodule



