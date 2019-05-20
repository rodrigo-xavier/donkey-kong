.data
.include "pizzas.s"

.text

CALL_TESTS:
	# Testa a função INIT
	call TEST_INIT
	addi a1, zero, 1
	beq  a0, zero, DEBUG
	
	call TEST_SORTEIO
	addi a1, zero, 1
	beq  a0, zero, DEBUG
	
	call FIM

# Funções devem retornar (TRUE = 1) se não houve nenhum erro (FALSE = 0) se houveram erros.
TEST_INIT: 
	call INIT
	

TEST_SORTEIO:
	call SORTEIO

# Deve mostrar na tela qual função está errada
DEBUG:
	call FIM

FIM:
	li a7, 10
	ecall