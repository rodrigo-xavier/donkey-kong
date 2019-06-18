# ####################################### #
# #  Teste da interface ADC		# #
# #   Endere�oos de Acesso:		# #
# #  CH0: 0xFF20 0200			# #
# #  ..					# #
# #  CH7: 0xFF20 021C			# #
# ####################################### #

.data

.text

li t0, 0xFF200200		# endereco do CH0

JOYLOOP: 
    lw a0,0(t0)
    li a7, 34
    ecall

    lw a0,4(t0)
    li a7, 34
    ecall

    lw a0,8(t0)
    li a7, 34
    ecall

    lw a0,12(t0)     
    li a7, 34
    ecall

    lw a0,16(t0)
    li a7, 34
    ecall

    lw a0,20(t0)
    li a7, 34
    ecall

    lw a0,24(t0)
    li a7, 34
    ecall

    lw a0,28(t0)
    li a7, 34
    ecall

    j JOYLOOP

# devolve o controle ao sistema operacional
FIM:	
    li a7, 10		# syscall de exit
	ecall