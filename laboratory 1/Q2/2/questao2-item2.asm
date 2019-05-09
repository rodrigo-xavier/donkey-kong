	.text
	.data
	.align	2
v:
	.word	9
	.word	2
	.word	5
	.word	1
	.word	8
	.word	2
	.word	4
	.word	3
	.word	6
	.word	7
	.align	2
.LC0:
	.string	"\t"
	.text
	.globl	show
	
	# Chamando MAIN
	j	main

show:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)	
	# Testando substituição do printf
	mv  a0,a1
   	li  a7,1
   	ecall
   	li  a7,4
   	la  a0,.LC0
   	ecall
	# Fim Teste	
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L3	
	li	a0,10	
	# Testando substituição do putchar
	li  a7,11 # printa inteiro
   	ecall
	# Fim Teste	
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48	
	#Voltando pra onde saiu na main
	j	volta1

.globl	swap
swap:
	addi	sp,sp,-48
	sw	s0,44(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a5,-40(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-20(s0)
	lw	a5,-40(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a4,a4,a5
	lw	a5,-40(s0)
	slli	a5,a5,2
	lw	a3,-36(s0)
	add	a5,a3,a5
	lw	a4,0(a4)
	sw	a4,0(a5)
	lw	a5,-40(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,0(a5)
	nop
	lw	s0,44(sp)
	addi	sp,sp,48
	j	voltaSwap

.globl	sort
sort:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	zero,-20(s0)
	j	.L6
.L10:
	lw	a5,-20(s0)
	addi	a5,a5,-1
	sw	a5,-24(s0)
	j	.L7
.L9:
	lw	a1,-24(s0)
	lw	a0,-36(s0)
	j	swap
voltaSwap:	
	lw	a5,-24(s0)
	addi	a5,a5,-1
	sw	a5,-24(s0)
.L7:
	lw	a5,-24(s0)
	bltz	a5,.L8
	lw	a5,-24(s0)
	slli	a5,a5,2
	lw	a4,-36(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,-24(s0)
	addi	a5,a5,1
	slli	a5,a5,2
	lw	a3,-36(s0)
	add	a5,a3,a5
	lw	a5,0(a5)
	bgt	a4,a5,.L9
.L8:
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L6:
	lw	a4,-20(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L10
	nop
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	j	volta2

.globl	main
main:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	li	a1,10
	lui	a5,%hi(v)
	addi	a0,a5,%lo(v)
	li	a1,10
	lui	a5,%hi(v)
	addi	a0,a5,%lo(v)
	j	sort
volta2:	
	li	a1,10
	lui	a5,%hi(v)
	addi	a0,a5,%lo(v)	
	j	show
volta1:	
	li	a5,0
	mv	a0,a5
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16



