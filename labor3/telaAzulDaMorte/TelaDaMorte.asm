.data

ERROR:  .string "Error: "
SPACE:  .string " "

ERROR0: .string "Instruction address misaligned"
ERROR1: .string "Instruction access fault"
ERROR2: .string "Ilegal Instruction"
ERROR4: .string "Load address misaligned"
ERROR5: .string "Load access fault"
ERROR6: .string "Store address misaligned"
ERROR7: .string "Store access fault"
ERROR8: .string "environment call"

PC:	.string "PC: "


.include "macros2.s"

.text


	M_SetEcall(exceptionHandling) # Configuração para iniciar a macro2 e SYSTEMv13


	li a0, 200 		# AZUL da MORTE
	li a1, 0		# Em qual FRAME adicionar a informação
	li a7, 148		# Informações de limpa tela 		
	M_Ecall			# Execusão das informaçoes

	la a0, ERROR
	li a1, 0
	li a2, 0
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall



#############################################
#  Printa exceção                           #
#  s0    =  valor PC                        #
#  s1    =  Tipo de error (0,1,2,4,5,6,7,8) #
#############################################
	
TIPODEERRO:
			addi s1, zero, 8	#teste para acessar os tipos de erros
	
	
	
	li t0, 0
	li t1, 1
	li t2, 2
	li t3, 4
	li t4, 5
	li t5, 6
	li t6, 7	
	li s8, 8
	beq s1, t0, ERRO0
	beq s1, t1, ERRO1
	beq s1, t2, ERRO2
	beq s1, t3, ERRO4
	beq s1, t4, ERRO5
	beq s1, t5, ERRO6
	beq s1, t6, ERRO7
	beq s1, s8, ERRO8
	jal FIM
	
#---------------------------------------------------------------------------------------

ERRO0:
	li a0, 0	# ERRO tipo 0
	li a1, 50
	li a2, 0
	li a3, 0x0000c8ff
	li a7, 101
	M_Ecall
	
	
	
	la a0, ERROR0
	li a1, 65
	li a2, 0
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	la a0, PC
	li a1, 0
	li a2, 10
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	add a0, zero, s0
	li a1,25
	li a2,10
	li a3,0x0000c8ff
	li a4,0
	li a7,134
	M_Ecall
	jal FIM

#-------------------------------------------------------------------------------

ERRO1:

	li a0, 1	# ERRO tipo 1
	li a1, 50
	li a2, 0
	li a3, 0x0000c8ff
	li a7, 101
	M_Ecall
	
	
	
	la a0, ERROR1
	li a1, 65
	li a2, 0
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	la a0, PC
	li a1, 0
	li a2, 10
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	add a0, zero, s0
	li a1,25
	li a2,10
	li a3,0x0000c8ff
	li a4,0
	li a7,134
	M_Ecall
	jal FIM
	
#------------------------------------------------------------------------------------

ERRO2:

	li a0, 2	# ERRO tipo 2
	li a1, 50
	li a2, 0
	li a3, 0x0000c8ff
	li a7, 101
	M_Ecall
	
	
	
	la a0, ERROR2
	li a1, 65
	li a2, 0
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	la a0, PC
	li a1, 0
	li a2, 10
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	add a0, zero, s0
	li a1,25
	li a2,10
	li a3,0x0000c8ff
	li a4,0
	li a7,134
	M_Ecall
	jal FIM

#----------------------------------------------------------------------

ERRO4:

	li a0, 4	# ERRO tipo 4
	li a1, 50
	li a2, 0
	li a3, 0x0000c8ff
	li a7, 101
	M_Ecall
	
	
	
	la a0, ERROR4
	li a1, 65
	li a2, 0
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	la a0, PC
	li a1, 0
	li a2, 10
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	add a0, zero, s0
	li a1,25
	li a2,10
	li a3,0x0000c8ff
	li a4,0
	li a7,134
	M_Ecall
	jal FIM
	
#---------------------------------------------------------------------------------

ERRO5:

	li a0, 5	# ERRO tipo 5
	li a1, 50
	li a2, 0
	li a3, 0x0000c8ff
	li a7, 101
	M_Ecall
	
	
	
	la a0, ERROR5
	li a1, 65
	li a2, 0
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	la a0, PC
	li a1, 0
	li a2, 10
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	add a0, zero, s0
	li a1,25
	li a2,10
	li a3,0x0000c8ff
	li a4,0
	li a7,134
	M_Ecall
	jal FIM

#------------------------------------------------------------------------------------


ERRO6:

	li a0, 6	# ERRO tipo 6
	li a1, 50
	li a2, 0
	li a3, 0x0000c8ff
	li a7, 101
	M_Ecall
	
	
	
	la a0, ERROR6
	li a1, 65
	li a2, 0
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	la a0, PC
	li a1, 0
	li a2, 10
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	add a0, zero, s0
	li a1,25
	li a2,10
	li a3,0x0000c8ff
	li a4,0
	li a7,134
	M_Ecall
	jal FIM
	
#----------------------------------------------------------------------------------------


ERRO7:

	li a0, 7	# ERRO tipo 7
	li a1, 50
	li a2, 0
	li a3, 0x0000c8ff
	li a7, 101
	M_Ecall
	
	
	
	la a0, ERROR7
	li a1, 65
	li a2, 0
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	la a0, PC
	li a1, 0
	li a2, 10
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	add a0, zero, s0
	li a1,25
	li a2,10
	li a3,0x0000c8ff
	li a4,0
	li a7,134
	M_Ecall
	jal FIM
	
#------------------------------------------------------------------------------

ERRO8:

	li a0, 8	# ERRO tipo 8
	li a1, 50
	li a2, 0
	li a3, 0x0000c8ff
	li a7, 101
	M_Ecall
	
	
	
	la a0, ERROR8
	li a1, 65
	li a2, 0
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	la a0, PC
	li a1, 0
	li a2, 10
	li a3, 0x0000c8ff
	li a4, 0
	li a7, 104
	M_Ecall
	
	add a0, zero, s0
	li a1,25
	li a2,10
	li a3,0x0000c8ff
	li a4,0
	li a7,134
	M_Ecall
	jal FIM





FIM:
li a7, 10
ecall




.include "SYSTEMv13.s"