.include "macros2.s"


# w = 0x00000077
# a = 0x00000061
# s = 0x00000073
# d = 0x00000064
# enter = 0x0000000a

.data 

.include "img/mario/mario.s"


.text

M_SetEcall(exceptionHandling) # Configuração para iniciar a macro2 e SYSTEMv13


	li a0, 255  		# a0 = 0 preto a0 = 255 branco  MUDANÇA DE COR 
	li a1, 0		# Em qual FRAME adicionar a informação		
	li a7, 148		# Informações de limpa tela
	M_Ecall

li s2, 119	# W
li s3, 97	# A
li s4, 115 	# S
li s5, 100 	# D
li s6, 10	# ENTER

PONTOSINICIO: 	li s0, 0
		li t1,0xFF00C83C		# endereco inicial da Memoria VGA 5622 				D509
		li t2,0xFF00DDBD		# endereco final da memoria VGA 572A	63A2			E289		15AF
		li t4,0xFF00C864		# Endereco final das colunas da VGA	563A	563A		D521		28
		
		
		
		li s7,0x00001900		# Variaveis de manipulações para movimentação
		li s8,0x0000193C
		
		li s9, 0xFF00C83C		
		li s10,0xFF00DDBD
		li s11,0xFF00C864
		
		li a5, 0xFF00C83C	#t1
		li a6, 0xFF00DDBD	#t2
		li a7, 0xFF00C864	#t4
		
		j MARIO



NEW: 	li a0, 0xFF200000 		# Endereço do KAYBOARD Mudar para o do TECLADO
	lw a1, 0(a0) 
	li a0, 1
	beq a0, a1, READ
	j NEW
	

	
READ:	li a0, 0xFF200004
	lw a1, 0(a0)
	beq a1, s4, DESCE
	beq a1, s2, SOBE
	j NEW


DESCE: 		li a1, 2
		beq a1, s0, NEW
		
		addi s0, s0, 1
		add t1, zero, a5
		add t2, zero, a6
		add t4, zero, a7
		j LOOPLIMPA
	
NOVODESCE:	mul a0, s0, s7
		mul a1, s0, s8
		
		add t1, s9, a0
		add t2, s10, a1
		add t4, s11, a0
		
		add a5,	zero, t1
		add a6, zero, t2
		add a7, zero, t4
		
		j MARIO
		
LOOPLIMPA: 	bge t1, t2, NOVODESCE		
		add t3, zero, zero		
		sw t3, 0(t1)		
		addi t1, t1, 4		
		addi s1, s1, 4
		beq t1, t4, PROXIMALINHALIMPA
		j LOOPLIMPA			# volta a verificar


PROXIMALINHALIMPA: 	addi t1, t1, 280
			addi t4, t4, 320
			j LOOPLIMPA	 
#----------------------------------------------------------------------------------------------------

SOBE:		li a1, 0
		beq s0, a1, NEW
		
		li a1, 1
		sub s0, s0, a1
		add t1, zero, a5
		add t2, zero, a6
		add t4, zero, a7
		j LOOPLIMPASOBE

NOVOSOBE:	mul a0, s0, s7
		mul a1, s0, s8
		
		add t1, s9, a0
		add t2, s10, a1
		add t4, s11, a0
		
		add a5,	zero, t1
		add a6, zero, t2
		add a7, zero, t4
		
		j MARIO
		


LOOPLIMPASOBE: 	bge t1, t2, NOVOSOBE		
		add t3, zero, zero		
		sw t3, 0(t1)		
		addi t1, t1, 4		
		addi s1, s1, 4
		beq t1, t4, PROXIMALINHALIMPASOBE
		j LOOPLIMPASOBE			# volta a verificar


PROXIMALINHALIMPASOBE: 	addi t1, t1, 280
			addi t4, t4, 320
			j LOOPLIMPASOBE	 






MARIO:  	la s1, mario		
		addi s1, s1, 8		# primeiro pixels depois das informa��es de nlin ncol

LOOPMARIO: 	bge t1, t2, NEW		# Se for o �ltimo endere�o ent�o sai do loop
		lw t3, 0(s1)		# le um conjunto de 4 pixels : word
		sw t3, 0(t1)		# escreve a word na mem�ria VGA
		addi t1, t1, 4		# soma 4 ao endere�o
		addi s1, s1, 4
		beq t1, t4, PROXIMALINHAMARIO
		j LOOPMARIO			# volta a verificar


PROXIMALINHAMARIO: 	addi t1, t1, 280
		addi t4, t4, 320
		j LOOPMARIO
		




FIM:	li a7, 34		# syscall de exit
	ecall

.include "SYSTEMv13.s"
