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
	 output 			oPCExp,
	 
	 input wire [4:0]   iRegWriteCSR,		// Entrada de escrita controlada pelo controlador
	 input wire [4:0]   iInstrucaoCSR,
	
	 input [31:0]	iInst,				// Entrada da instruçao
	 input 			iPC,					//	Entrada do PC
	 input			iImmData,
	 input [7:0]   iReadRegisterCSR,	// Entrada de qual registrador a ser lido
	 input [31:0]	iRegDataToCSR,
	 output [31:0] oCSRDataToReg,
	 output [31:0] oUTVECT				// Saida da instruçao de mostrar qual o erro (Tela DA MORTE)
    
	 //descomentar para Mostrar no VGA
	 
	 /*
	 ,
	 input wire  [4:0] 	iVGASelect, iRegDispSelect,
    output reg  [31:0] 	oVGARead, oRegDisp*/	 
	 
   
    );

/* CSRegister file */
reg [31:0] registers[68:0];

// Leitura dos REGISTRADORES de CSR
//assign oReadDataCSR = registers[iReadRegisterCSR];
assign RS1 = iInst[19:15];


parameter   USTATUA = 2'd00,
				FFLAGS  = 2'd01,
				FRM	  = 2'd02,
				FCSR	  = 2'd03,
				UIE	  = 2'd04,
				UTVECT  = 2'd05,
				USCRATCH= 2'd64,
				UEPC	  = 2'd65,
				UCAUSE  = 2'd66,
				UTVAL   = 2'd67,
				UIP	  = 2'd68;
				



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
		 begin // reseta o banco de registradores e pilha
			 for (i = 0; i <= 68; i = i + 1'b1)
					begin
					registers[i] = 32'b0;
					if(i == 5)
						i = 64;
				end
			registers[UTVECT] = 32'b0;  //Instruçao inicial de erro
		 end
    
	 else
		 begin
			i<=6'bx; // para não dar warning
			if(iRegWriteCSR == 00001 && iUcause == ILLEGAL_INST)
				begin
					registers[UTVAL] = iInst;
					registers[UEPC]  = iPC;
					oUTVECT 			  = registers[UTVECT];
				end
			else if(iRegWriteCSR == 00001  && iRegDataToCSR == 0)
				begin
					registers[UTVAL] = iPC;
					registers[UEPC]  = iPC;
					oUTVECT 			  = registers[UTVECT];
				end
				
				
			if(iInstrucaoCSR == 00010   && iRegDataToCSR != 0) //CSRRW
				begin
					oCSRDataToReg <= registers[RS1];
					registers[RS1] <=  iRegDataToCSR;
				
				
				end
			else if(iInstrucaoCSR == 00011  && iRegDataToCSR != 0) //CSRRS
				begin
					oCSRDataToReg <= registers[RS1];
					registers[RS1] <=  iRegDataToCSR | registers[RS1];
				
				
				end
			else if(iInstrucaoCSR == 00100  && iRegDataToCSR != 0) //CSRRC
				begin
					oCSRDataToReg <= registers[RS1];
					registers[RS1] <=  iRegDataToCSR &! registers[RS1];
				
				
				end
			else if(iInstrucaoCSR == 00101  && iRegDataToCSR != 0) //CSRRWI
				begin
					oCSRDataToReg <= registers[RS1];
					registers[RS1] <= iImmData;
				
				
				end
			else if(iInstrucaoCSR == 00110  && iRegDataToCSR != 0) //CSRRSI
				begin
					oCSRDataToReg <= registers[RS1];
					registers[RS1] <=  iImmData | registers[RS1];
				
				
				end
			else if(iInstrucaoCSR == 00111  && iRegDataToCSR != 0) //CSRRCI
				begin
					oCSRDataToReg <= registers[RS1];
					registers[RS1] <=  iImmData &! registers[RS1];
				
				
				end
		 end
	
end

endmodule
