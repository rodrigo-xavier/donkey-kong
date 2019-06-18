# ####################################### #
# #  Teste da interface ADC		# #
# #   Endere�oos de Acesso:		# #
# #  CH0: 0xFF20 0200			# #
# #  ..					# #
# #  CH7: 0xFF20 021C			# #
# ####################################### #

.data

.text

# Carrega ADC
li t0, 0xFF200200		# endereco do CH0

# Carrega a imagem
li t1, 0xFF000000		# endereco inicial da Memoria VGA
li t2, 0xFF012C00		# endereco final

BLACKWINDOW: 	
    beq t1, t2, JOYLOOP
    beq t1, t3, SETPIXEL
	sw zero, 0(t1)		        # escreve a word na mem�ria VGA
	addi t1, t1, 4		        # soma 4 ao endere�o
	j BLACKWINDOW			        # volta a verificar

SETPIXEL: 	
    li t4, 0xffffffff           # escolhe a cor do pixel
	sw t4, 0(t1)		        # escreve a word na mem�ria VGA
	addi t1, t1, 4		        # soma 4 ao endere�o
	j BLACKWINDOW			        # volta a verificar

JOYLOOP:
    li t1, 0xFF000000		# Seta a imagem para o endereço inicial

    li t5, 0xffffffff       # escolhe o valor do potenciômetro que define cima
    li t6, 0x00000000       # escolhe o valor do potenciômetro que define baixo
    lw x8,0(t0)
    beq t5, x8, UP
    beq t6, x8, DOWN

    li t5, 0xffffffff       # escolhe o valor do potenciômetro que define direita
    li t6, 0x00000000       # escolhe o valor do potenciômetro que define esquerda
    lw x9,4(t0)
    beq t5, x9, RIGHT
    beq t6, x9, LEFT

    # lw x10,8(t0)
    # lw x11,12(t0)     
    # lw x12,16(t0)
    # lw x13,20(t0)
    # lw x14,24(t0)
    # lw x15,28(t0)
    j JOYLOOP

CENTER:
    li t3, 0xFF0096A0       # endereco do pixel central
    j BLACKWINDOW

UP:
    li t3, 0xFF0000A0       # endereco do pixel acima
    j BLACKWINDOW

DOWN:
    li t3, 0xFF012b60       # endereco do pixel abaixo
    j BLACKWINDOW

LEFT:
    li t3, 0xFF009600       # endereco do pixel esquerdo
    j BLACKWINDOW

RIGHT:
    li t3, 0xFF00973f       # endereco do pixel direito
    j BLACKWINDOW

	
# devolve o controle ao sistema operacional
FIM:	
    li a7, 10		# syscall de exit
	ecall