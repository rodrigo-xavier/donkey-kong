.data

N: .word 6 	# Numero de Casas/Clientes
C: .space 160	# Espaço em bytes correspondente a 2 coordenadas x 20 casas (max) x 4 bytes, 
D: .space 1600  # máximo de 20x20 casas x 4 bytes (float precisão simples)
L1: .string "\n"
L2: .string "   "


.include "macros2.s"

.text
	la s2, D		# Inicio da matriz de distancias
	la t0, N		#Le o endereço de N (clientes)
	lw s0, 0(t0)		#Le o conteudo de N (clientes)
	la s1, C		#le o endereçe de C (espaço dos endereços dos clientes)
	mv a0, s0
	mv a1, s1
	jal SORTEIO

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
	addi a2, a2, 1		#recuperação do numero de clientes
	addi a3, a3, 8		# Variavel de retorno ao primeiro da pilha
	blt zero, a0, SORTEIO	# Se não foram todos os clientes volta ao endereçamento(sorteio) dos clientes
	add a0, a0, a2		# Retornando a0 ao valor inicial
	sub a1, a1, a3		# retorno para o inicio da pilha
	jal DESENHA
	
#--------------------------------------------------------------------------------------------------------------------------------

DESENHA:
	M_SetEcall(exceptionHandling) # Configuração para iniciar a macro2 e SYSTEMv13
	
	mv t0, a0		#salva os valores de a0 e a1
	mv t1, a1
	
#--------------------------------------------------------------------------------------------------------------------
	
	li a0, 255  		# a0 = 0 preto a0 = 255 branco  MUDANÇA DE COR
	li a7, 148		# Informações de limpa tela 
	li a1, 0		# Em qual FRAME adicionar a informação		
	M_Ecall			# Execusão das informaçoes
	addi t3, zero, 64	# temporaria para determinar a o inicio da letra do ASCII
			
	
	
TODASCASAS:	addi t0, t0, 64		# soma para dizer qual casa é, no ASCC
		add a0,zero, t0		# Caracter a ser printado do ASCII
		lw a1, 0(t1)		# Posição X a ser pintado
		lw a2, 4(t1)		# Posição Y a ser pintado	
		li a3, 0x00003200	# a cor hex: 0x0000bbff b=fundo f=frente | 32= verde | 00= preto
		li a4, 0		# FRAME	
		li a7, 111		# Codigo de printChar
		M_Ecall
		
		sub t0, t0, t3		# recupera o numero de casas
		
		
		addi t1, t1,8		# desloca 8 bytes do endereço de memoria do Espaço dos Clientes
		addi t0, t0,-1		# decrementa o numero de clientes
		addi a2, a2,1		# recuperação do numero de clientes
		addi a3, a3,8		# Variavel de retorno ao primeiro da pilha
		blt zero, t0,TODASCASAS	# Se não foram todos os clientes volta ao desenho dos endereços dos clientes
		add t0, t0, a2		# Retornando a0 ao valor inicial
		sub t1, t1, a3		# retorno para o inicio da pilha
	
			
		mv a0, s0		#recupera os valores de a0 e a1
		mv a1, s1
		jal ROTAS
		
#----------------------------------------------------------------------------------------------------------------------------------		

ROTAS:
		mv t5, s2		# Pegando o endereço inicial de da Matriz
		li t6, 999	 

		mv t0, a0		# Guada o valor de a0 
		mv t4, t0		# Inicia t4 com o mesmo valor de t0  
		mv t1, a1		# Guada o valor de a1
		mv t2, t1		# Apontando em t1 e em t2 o inicio da pilha 
		addi t3, zero, 1	# Variavel de limite
		jal LINHAPARAN

LINHAPARAN:	beq t2, t1, SAOIGUAIS		# Verifica se os endereços de t0 e t1 são iguais, se são vão para SAO IGUAIS
		lw a0, 0(t1)			# Posição X inicial   
		lw a1, 4(t1)			# Posição Y inicial
		lw a2, 0(t2)			# Posição X final
		lw a3, 4(t2)			# Posição Y final
		li a4, 0			# Cor da linha
		li a5, 0			# Frame
		li a7, 47			# Codigo de DrawLine
		M_Ecall
		
		sub a0, a0, a2			# Variações de X do cliente atual e do proximo
		sub a1, a1, a3			# Variações de Y do Cliente atual e do proximo
		mul a0, a0, a0			# dX ao quadrado
		mul a1, a1, a1			# dY ao quadrado
		add a0, a0, a1			# Soma de dX e dY ao quadrado 
		fcvt.s.w fa0,a0			# Converte o valor de a0 para Ponto Flutuante
		fsqrt.s fa0,fa0 		# a raiz quadada da SOMA 
				
		fsw fa0, 0(t5)			# Guarda a distância entre os clientes na matriz D
		addi t5, t5, 4			# Pula para a proxima posição da MATRIZ
						
		addi t0, t0, -1			# Diminui uma casa
		addi t2, t2, 8			# Pula para o enereço do proximo cliente
		bne t0, t3, LINHAPARAN		# Verifica se foram todos os clientes
		bne t4, t3, PARATODASCASAS	# Verifica se foram todos os clientes 
		
		call FIM			# Vai para o fim

PARATODASCASAS:
		sub t4, t4, t3			# Pula para proximo cliente para ligar os endereçamentos comos outros clientes
		mv t0, s0			# Retorna a quantidade de clientes total
		mv t2, s1			# Retorna ao inicio da pilha
		addi t1, t1, 8  		# Pula para o proximo Clinte a ligar os enedereços
		jal LINHAPARAN			# Retorna ao endereçamento
		

SAOIGUAIS: 	
		fcvt.s.w fa0, t6		# Se é iguais converte um numero muito grande para Ponto Flutuante
		fsw fa0, 0(t5)			# Guarda a distância entre os clientes na matriz D
		addi t5, t5, 4			# Pula para a proxima posição da MATRIZ
		addi t2, t2, 8			# Se forem iguais o endereço t2 pula para proxima Casa
		jal LINHAPARAN
	


FIM:

	li a7, 10
	ecall
	
.include "SYSTEMv13.s"
