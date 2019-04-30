.data

N: .word 21 	# Numero de Casas/Clientes
C: .space 160	# Espaço em bytes correspondente a 2 coordenadas x 20 casas (max) x 4 bytes, 

.text

	la t0, N		#Le o endereço de N (clientes)
	lw a0, 0(t0)		#Le o conteudo de N (clientes)
	la a1, C		#le o endereçe de C (espaço dos endereços dos clientes)

SORTEIO: 
	mv t1, a0 		# Salva o valor de a0(N)
	mv t2, a1 		# Salva o valor de a1(C)
	
	addi a1, zero, 310	# Adiciona o Limite (X < 310) de alcance do aleatório
	li a7, 42		# chama o ecall do aleatório limitado
	ecall			# pega o valor aleatório de X.
	mv a1, t2 		# Recupero o valor do endereço do espaço de memoria
	sw a0, 0(a1)		# salva o valor de x no ponto zero de a1
	
	mv t2, a1 		# Salva novamente o valor de a1(C)
	
	addi a1, zero, 230	# Adiciona o Limite (Y < 230) de alcance do aleatório
	li a7, 42		# chama o ecall do aleatório limitado
	ecall			# pega o valor aleatório de Y.
	mv a1, t2		# Recupero o valor do endereço do espaço de memoria
	sw a0, 4(a1)		# salva o valor de y no ponto 4 bytes a frente de a1
	
	mv a0, t1		# Recupero o valor de a0(N)
	addi a1, a1, 8		# desloca 8 bytes do endereço de memoria do Espaço dos Clientes
	addi a0, a0, -1		# decrementa o numero de clientes
	blt zero, a0, SORTEIO	# Se não foram todos os clientes volta ao endereçamento(sorteio) dos clientes
	call FIM		# Vai para o fim


FIM:
	li a7, 10
	ecall
