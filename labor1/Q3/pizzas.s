.data

N: .word 15 	  	# Numero de Casas/Clientes
C: .space 160	  	# Espaço em bytes correspondente a 2 coordenadas x 20 casas (max) x 4 bytes, 
D: .space 1600    	# máximo de 20x20 casas x 4 bytes (float precisão simples)
ORDEM: .space 1600 	# Matriz para ordenação
L1: .string "\n"
T1: .string "t1="
T2: .string "t2="


.include "macros2.s"

.text
	la s2, D		# Inicio da matriz de distancias
	la s3, ORDEM		# Inicio da matriz de ordenação
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
		mv t5, s2		# Pegando o endereço inicial da Matriz
		mv a6, s3		# Pegando o endereço inicial da Matriz para ordenar
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
		fsw fa0, 0(a6)			# Guarda a distância entre os clientes na matriz ORDEM para ordenação
		addi t5, t5, 4			# Pula para a proxima posição da MATRIZ D
		addi a6, a6, 4			# Pula para a proxima posição da MATRIZ ORDEM
						
		addi t0, t0, -1			# Diminui uma casa
		addi t2, t2, 8			# Pula para o enereço do proximo cliente
		bne t0, t3, LINHAPARAN		# Verifica se foram todos os clientes
		bne t4, t3, PARATODASCASAS	# Verifica se foram todos os clientes 
		
		mv a0, s0			#
		mv a1, s1			#	Recuperação dos valores iniciais de a0, a1, a2 e a6
		mv a2, s2			#
		mv a6, s3			#
		
		jal ORDENA


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

#-------------------------------------------------------------------------------------------------------------------

	
ORDENA:
		mv a0, s3			# Recupera o valor de a0 e a1
		mv a1, s0			#Recupera o VAlor de N
		jal sort			# Vamos para ordenação
					
		mv a0, s0
		mv a1, s1
		mv a2, s2	
		mv a3, s3
		jal RAPIDO
				
swap:		slli t1,a1,2
		add t1,a0,t1
		lw t0,0(t1)
		lw t2,4(t1)
		sw t2,0(t1)
		sw t0,4(t1)
		ret

sort:		addi sp,sp,-20			#
		sw ra,16(sp)			#
		sw s7,12(sp)			#
		sw s6,8(sp)			#
		sw s5,4(sp)			#
		sw s4,0(sp)			#
		mv s6,a0			#
		mv s7,a1			#
		mv s4,zero			#

for1:		bge s4,s7,exit1			#
		addi s5,s4,-1			#

for2:		blt s5,zero,exit2		#
		slli t1,s5,2			#
		add t2,s6,t1			#
		lw t3,0(t2)			#
		lw t4,4(t2)			#
		bge t4,t3,exit2			#
		mv a0,s6			#
		mv a1,s5			#
		jal swap			#
		addi s5,s5,-1			#
		j for2				#

exit2:		addi s4,s4,1			#
		j for1				#

exit1: 		lw s4,0(sp)			#
		lw s5,4(sp)			#
		lw s6,8(sp)			#
		lw s7,12(sp)			#
		lw ra,16(sp)			#
		addi sp,sp,20			#
		ret
			
#-----------------------------------------------------------------------------------------------------------------------		
		
RAPIDO:		addi s7, zero, 1		# Limete aplicado
		#addi a3, a3, 4			# Na matrix ordenada pula para proxima instrução 
		add a2, s2, zero		# Retorna para o inicio da matrix desordenada
		#add t0, zero, a0		# Variavel de inicio das contagens de cliente (N)
		add t5, zero, s0		# Variavel de inicio dos clientes para contagem de casa em casa
		add t6, zero, t5		# Variavel de inicio das distancias serem iguais
		addi s8, zero, 8		# Variavel auxiliar 
		add s10, a0, zero
		jal DESTINOS			# Vamos para a primeira menor distância
				

DESTINOS:					# while de menores distancias
		mv a2, s2			# Sempre que inicia o while iniciar o ponteiro da matriz desordenada sempre no inicio
		mul s3, s3, zero		# contador I (coutI) inicia o while sempre no zero
		mul s4, s4, zero		# contador J (coutJ) inicia o while sempre no zero
		add t5, s0, zero		# Começamos a contagem (i) novamente das distancias dos clientes 
		add t6, t5, zero		# Começamos a contagem (j) novamente das distancias dos clientes
		bne s10, s7, Destino1		# verifica se todas as distancias das casas (N-1) se maior que 1, caso seja vamos para Destino 1
		jal FIM				# Se N = 1 TERMINA O PROGRAMA
		
		
Destino1:	bne t5, s7, Destino2		# For=  se (i != 1) vamos para Destino 2 

		add t5, zero, s0		# Retornamos i ao total de clientes 
		sub s10, s10, s7		# Subtraimos o total de clientes
		addi a3, a3, 8			# Pulamos para proxima distância na matriz ordenada
		jal DESTINOS			# Voltamos para o Destinos



Destino2:	bne t6, s7, OsCaminhos		#for =  J != 1 vamos para selecionar verificar as distancias  
		
		add s3, s3, s7			# coutI = coutI + 1
		mul s4, s4, zero		# coutJ = 0
		add t6, zero, s0		# retornamos o valor J ao total de clientes
		sub t5, t5, s7			# subtraimos i = i - 1
		jal Destino1			# voltamos ao destino 1

		
		
		
OsCaminhos: 					# IF
		
		flw fa2, 0(a2)			# Pegamos o float na posição a2( N[t0] ) da matriz desordenada
		flw fa3, 0(a3)			# Pegamos o float na posição a3(i,j) da matriz Ordenada
		feq.s a6, fa2, fa3		# comparamos se ela forem igual (a6 = 1) se não (a6 = 0)
		
		fadd.s fa0, fa2, ft11
		li a7, 2
		ecall
		
		mv s10, a0
		la a0, L1
		li a7, 4
		ecall
		
		mv a0, s10
		
		
		fadd.s fa0, fa3, ft11
		li a7, 2
		ecall
		
		mv s10, a0
		la a0, L1
		li a7, 4
		ecall
		
		mv a0, s10
		
		
		beq a6, s7, DesenhaVermelho	# se a6 = 1 vamos desenhar vermelho! se não pula para proxima instrução
		addi a2, a2, 4			# pula o ponteiro para a proxima distancia na matriz desordenada
		add s4, s4, s7			# coutJ = coutJ + 1
		sub t6, t6, s7			# j = (j-1) 
		jal Destino2			# Voltamos para Destino 2

		


DesenhaVermelho:mv t1, s1			# t1 Pega o inicio do vetor endereço das casas dos clientes
		add t2, t1, zero		# t2 Pega o inicio do vetor endereço das casas dos clientes
		
		
		
		
		mul t3, s3, s8			# Pego t3 = (coutI * 8)
		mul t4, s4, s8			# Pego t4 = (coutJ * 8)
		add t1, s1, t3			# Pulo no vetor endereço de acordo com o contadorI 
		add t2, s1, t4			# Pulo no vetor endereço de acordo com o contadorJ
		
		
		la a0, L1
		li a7, 4
		ecall
		
		
		mv a0, t1
		li a7, 34
		ecall
		
		la a0, L1
		li a7, 4
		ecall
		
		
		mv a0, t2
		li a7, 34
		ecall
		
		mv s5, a0			#
		mv s6, a1			#	Salva os valores a0, a1, a2 e a3
		mv s7, a2			#
		mv s9, a3 			#
		
		
		#la a0, T2
		#li a7, 4
		#ecall
		
		
		#lw a2, 0(t2)			# Posição X final
		#lw a3, 4(t2)			# Posição Y final
		
		#mv a0, a2
		#li a7, 1
		#ecall
		
		#la a0, L1
		#li a7, 4
		#ecall
		
		#mv a0, a3
		#li a7, 1
		#ecall
		
		
		lw a0, 0(t1)			# Posição X inicial   
		lw a1, 4(t1)			# Posição Y inicial
		lw a2, 0(t2)			# Posição X final
		lw a3, 4(t2)			# Posição Y final
		li a4, 15			# Cor da linha
		li a5, 0			# Frame
		li a7, 47			# Codigo de DrawLine
		M_Ecall
		
		mv a0, s7
		mv a1, s9 
		mv a2, s10
		mv a3, s11 
		
		addi a3, a3, 8			# Pula para a proxima distancia na matriz ordenada 
		mul s3, s3, zero		# zera I
		mul s4, s4, zero		# Zera J
		sub s10, s10, s7		# t0 = t0 - 1
		jal DESTINOS			# Volta para o Destino

FIM:

	li a7, 10
	ecall
	
.include "SYSTEMv13.s"
