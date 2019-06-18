`ifndef PARAM
 `include "../Parametros.v"
`endif


module CSRegisters (
    input wire    iCLK, iRST, iRegWrite,
	 input			iDesaligned,
	 input   		iUcause,
	 input   		TOreadCSR,
	 input   		writeDataCSR,
	 output			readCSR,
	 output 			oPCExp
   
    );

/* CSRegister file */
reg [31:0] registers[68:0];

parameter  SPR=5'd2;                    // SP


reg [7:0] i;

//initial
// begin
//	  for (i = 0; i <= 68; i = i + 1'b1)
//	   begin
//			registers[i] <= 32'b0;
//			if(i == 5)
//				begin
//					i <= i + 7'b0111011;
//				end
//		end
//	registers[SPR] = STACK_ADDRESS;
// end

initial
 begin
  for (i = 0; i <= 5; i = i + 1'b1)
   registers[i] = 32'b0;
  
  for (i = 64; i <= 68; i = i + 1'b1)
   registers[i] = 32'b0;
 end



assign oPCExp = registers[iUcause];


															`ifdef PIPELINE
																 always @(negedge iCLK or posedge iRST)
															`else
																 always @(posedge iCLK or posedge iRST)
															`endif
begin
    if (iRST)
		 begin // reseta o banco de registradores
				for (i = 0; i <= 5; i = i + 1'b1)
					registers[i] = 32'b0;
	  
				for (i = 64; i <= 68; i = i + 1'b1)
					registers[i] = 32'b0;
		 end
    else
	  begin
		  i<=6'bx; // para não dar warning
		  if(iRegWrite)
			 registers[iUcause] <= iDesaligned;
	  end
	 end

endmodule