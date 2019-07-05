.data

.include "fase1.s"

SEMFIM:

MAPA:	li t1, 0xFF000000		# endereco inicial da Memoria VGA
	li t2, 0xFF012C00		# endereco final 
	la s1, fase1			# endere�o dos dados da tela na memoria
	addi s1, s1, 8			# primeiro pixels depois das informa��es de nlin ncol

LOOPMAPA: 	beq t1, t2, SEMFIM		# Se for o �ltimo endere�o ent�o sai do loop
		lw t3, 0(s1)		# le um conjunto de 4 pixels : word
		sw t3, 0(t1)		# escreve a word na mem�ria VGA
		addi t1, t1, 4		# soma 4 ao endere�o
		addi s1, s1, 4
		j LOOPMAPA			# volta a verificar
	