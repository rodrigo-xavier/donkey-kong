

.include "fase1_nova.s"
.include "Kong_final.s"
.include "kong_1.s"


.macro MAPA


SEMFIM:	li t1, 0xFF000000		# endereco inicial da Memoria VGA
	li t2, 0xFF012C00		# endereco final 
	la s1, fase1_nova			# endere�o dos dados da tela na memoria
	addi s1, s1, 8			# primeiro pixels depois das informa��es de nlin ncol

LOOPMAPA: 	beq t1, t2, KONG	# Se for o �ltimo endere�o ent�o sai do loop
		lw t3, 0(s1)		# le um conjunto de 4 pixels : word
		sw t3, 0(t1)		# escreve a word na mem�ria VGA
		addi t1, t1, 4		# soma 4 ao endere�o
		addi s1, s1, 4
		j LOOPMAPA			# volta a verificar
	


KONG: 	li t1, 0xFF002511		# endereco inicial da Memoria VGA
	li t2, 0xFF005382		# endereco final 
	li t4, 0xFF002542
	la s1, kong_1		# endere�o dos dados da tela na memoria
	addi s1, s1, 8	


LOOPKONG: 	bge t1, t2, SEMFIM	# Se for o �ltimo endere�o ent�o sai do loop
		lb t3, 0(s1)		# le um conjunto de 4 pixels : word
		sb t3, 0(t1)		# escreve a word na mem�ria VGA
		addi t1, t1, 1		# soma 4 ao endere�o
		addi s1, s1, 1
		beq t1, t4, LINHAKONG
		j LOOPKONG			# volta a verificar

LINHAKONG:	addi t1, t1, 271
		addi t4, t4, 320
		j LOOPKONG

FIM_GAME: 	li a7, 10		# syscall de exit
		ecall

.end_macro 
