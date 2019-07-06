.include "macros2.s"



.data 

.include "img/title/Donkey_kong.s"
.include "img/menu/Menu.s"
.include "img/menu/menu_1.s"
.include "img/menu/menu_2.s"
.include "img/mario/mario.s"
#.include "fase_1.asm"
New_Game: .string "NEW GAME"
Controls: .string "CONTROLS"
EXIT:     .string "EXIT GAME"
SPACE:    .string "\n"




.text

M_SetEcall(exceptionHandling) # Configuração para iniciar a macro2 e SYSTEMv13


#LIMPAR TELA
	li a0, 0  		# a0 = 0 preto a0 = 255 branco  MUDANÇA DE COR 
	li a1, 0		# Em qual FRAME adicionar a informação		
	li a7, 148		# Informações de limpa tela
	M_Ecall			# Execusão das informaçoes
	j DONKEY
	
DONKEY: li t1,0xFF00007C		# endereco inicial da Memoria VGA 
	li t2,0xFF003EFC		# endereco final da memoria VGA 0xFF012C00	0xFF0040C9
	li t4,0xFF0000C4		# Endereco final das colunas da VGA	0xFF00009B
	la s1, Donkey_kong		# endere�o dos dados da tela na memoria
	addi s1, s1, 8		# primeiro pixels depois das informa��es de nlin ncol

LOOP: 	bge t1, t2, MENU		# Se for o �ltimo endere�o ent�o sai do loop
	lw t3, 0(s1)		# le um conjunto de 4 pixels : word
	sw t3, 0(t1)		# escreve a word na mem�ria VGA
	addi t1, t1, 4		# soma 4 ao endere�o
	addi s1, s1, 4
	beq t1, t4, PROXIMALINHA
	j LOOP			# volta a verificar


PROXIMALINHA: 	addi t1, t1, 248
		addi t4, t4, 320
		j LOOP


MENU:	la a0, New_Game
	li a1, 130
	li a2, 170
	li a3, 255
	li a7, 104
	M_Ecall
	
	la a0, Controls
	li a1, 130
	li a2, 190
	li a3, 255
	li a7, 104
	M_Ecall
	
	la a0, EXIT
	li a1, 128
	li a2, 210
	li a3, 255
	li a7, 104
	M_Ecall
	
PONTOSINICIO: 	li s0, 0
		li t1,0xFF00C83C		# endereco inicial da Memoria VGA 5622 				D509
		li t2,0xFF00DDBD		# endereco final da memoria VGA 572A	63A2			E289		15AF
		li t4,0xFF00C864		# Endereco final das colunas da VGA	563A	563A		D521		28
		
		
		
		li s7,0x00001900		# Variaveis de manipulações para movimentação
		li s8,0x0000193C
		
		li s9, 0xFF00C83C		
		li s10,0xFF00DDBD
		li s11,0xFF00C864
		
		li s2, 0xFF00C83C	#t1
		li s3, 0xFF00DDBD	#t2
		li s4, 0xFF00C864	#t4
		
		j MARIO

#################################################################
	
MARIO:  	la s1, mario		
		addi s1, s1, 8		# primeiro pixels depois das informa��es de nlin ncol

LOOPMARIO: 	bge t1, t2, PAUSE		# Se for o �ltimo endere�o ent�o sai do loop
		lw t3, 0(s1)		# le um conjunto de 4 pixels : word
		sw t3, 0(t1)		# escreve a word na mem�ria VGA
		addi t1, t1, 4		# soma 4 ao endere�o
		addi s1, s1, 4
		beq t1, t4, PROXIMALINHAMARIO
		j LOOPMARIO			# volta a verificar


PROXIMALINHAMARIO: 	addi t1, t1, 280
		addi t4, t4, 320
		j LOOPMARIO
		
################################################################

MACACO:	li t1,0xFF003EA8		# endereco inicial da Memoria VGA 
	li t2,0xFF00AECF		# endereco final da memoria VGA 0xFF012C00	0xFF0040C9
	li t4,0xFF003F98		# Endereco final das colunas da VGA	0xFF00009B
	addi s1, s1, 8		# primeiro pixels depois das informa��es de nlin ncol

LOOPM: 	bge t1, t2, SOUND		# Se for o �ltimo endere�o ent�o sai do loop
	lw t3, 0(s1)		# le um conjunto de 4 pixels : word
	sw t3, 0(t1)		# escreve a word na mem�ria VGA
	addi t1, t1, 4		# soma 4 ao endere�o
	addi s1, s1, 4
	beq t1, t4, PROXIMALINHAM
	j LOOPM			# volta a verificar


PROXIMALINHAM: 	addi t1, t1, 80
		addi t4, t4, 320
		j LOOPM


################################################################




PAUSE:	li a0,1000   # 1 segundo
	li a7,132
	M_Ecall
	
	li a0, 0xFF200000 		# Endereço do KAYBOARD Mudar para o do TECLADO
	lw a1, 0(a0) 
	li a0, 1
	beq a0, a1, READ
	
	beq t0, zero, MENU1
	bne t0, zero, MENU2
	
MENU1:	li a0, 0xFF200000 		# Endereço do KAYBOARD Mudar para o do TECLADO
	lw a1, 0(a0) 
	li a0, 1
	beq a0, a1, READ
	
	li t0, 1
	la s1, menu_1
	j MACACO	
	
MENU2:	li a0, 0xFF200000 		# Endereço do KAYBOARD Mudar para o do TECLADO
	lw a1, 0(a0) 
	li a0, 1
	beq a0, a1, READ
	
	li t0, 0
	la s1, menu_2
	j MACACO			
		

SOUND:	li a0, 72
	li a1, 200
	li a2, 124
	li a3, 127
	li a7, 33
	M_Ecall
	j PAUSE


#########################################################################################

READ:	li t1,0xFF00C83C		# endereco inicial da Memoria VGA 5622 				D509
	li t2,0xFF00DDBD		# endereco final da memoria VGA 572A	63A2			E289		15AF
	li t4,0xFF00C864		# Endereco final das colunas da VGA	563A	563A		D521		28
		
	# INFORMAÇÂO do TECLADO 
	li a2, 119	# W
	li a3, 115 	# S
	li a4, 90	# ENTER
	
	li a0, 0xFF200004
	lw a1, 0(a0)
	beq a1, a3, DESCE
	beq a1, a2, SOBE
	beq a1, a4, ENTRAR
	ret

ENTRAR:	#li  a1, 0
	#beq a1, s0, FASE
	li  a1, 2
	beq s0, a4, FIM
	ret

#FASE: call MAPA

DESCE: 		li a1, 2
		beq a1, s0, PAUSE
		
		addi s0, s0, 1
		add t1, zero, s2
		add t2, zero, s3
		add t4, zero, s4
		j LOOPLIMPA
	
NOVODESCE:	mul a0, s0, s7
		mul a1, s0, s8
		
		add t1, s9, a0
		add t2, s10, a1
		add t4, s11, a0
		
		add s2,	zero, t1
		add s3, zero, t2
		add s4, zero, t4
		
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

#######################################################################

SOBE:		li a1, 0
		beq s0, a1, PAUSE
		
		li a1, 1
		sub s0, s0, a1
		add t1, zero, s2
		add t2, zero, s3
		add t4, zero, s4
		j LOOPLIMPASOBE

NOVOSOBE:	mul a0, s0, s7
		mul a1, s0, s8
		
		add t1, s9, a0
		add t2, s10, a1
		add t4, s11, a0
		
		add s2,	zero, t1
		add s3, zero, t2
		add s4, zero, t4
		
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





FIM:	li a7, 10		# syscall de exit
	ecall

.include "SYSTEMv13.s"
