.data
.LC0:
  .word 5
  .word 8
  .word 3
  .word 4
  .word 7
  .word 6
  .word 8
  .word 0
  .word 1
  .word 9
.LC1:
  .string "\t"
  
.text
j main
show:
  addi sp,sp,-48
  sw ra,44(sp)
  sw s0,40(sp)
  addi s0,sp,48
  sw a0,-36(s0)
  sw a1,-40(s0)
  sw zero,-20(s0)
.L3:
  lw a4,-20(s0)
  lw a5,-40(s0)
  bge a4,a5,.L2
  lw a5,-20(s0)
  slli a5,a5,2
  lw a4,-36(s0)
  add a5,a4,a5
  lw a5,0(a5)
  mv a1,a5
  lui a5,%hi(.LC0)
  addi a0,a5,%lo(.LC0)
  mv  a0,a1
  li  a7,1
  ecall
  li  a7,4
  la  a0,.LC1
  ecall
  lw a5,-20(s0)
  addi a5,a5,1
  sw a5,-20(s0)
  j .L3
.L2:
  li a0,10
  li  a7,4
  la  a0,.LC1
  ecall
  nop
  lw ra,44(sp)
  lw s0,40(sp)
  addi sp,sp,48
  jr ra
swap:
  addi sp,sp,-48
  sw s0,44(sp)
  addi s0,sp,48
  sw a0,-36(s0)
  sw a1,-40(s0)
  lw a5,-40(s0)
  slli a5,a5,2
  lw a4,-36(s0)
  add a5,a4,a5
  lw a5,0(a5)
  sw a5,-20(s0)
  lw a5,-40(s0)
  addi a5,a5,1
  slli a5,a5,2
  lw a4,-36(s0)
  add a4,a4,a5
  lw a5,-40(s0)
  slli a5,a5,2
  lw a3,-36(s0)
  add a5,a3,a5
  lw a4,0(a4)
  sw a4,0(a5)
  lw a5,-40(s0)
  addi a5,a5,1
  slli a5,a5,2
  lw a4,-36(s0)
  add a5,a4,a5
  lw a4,-20(s0)
  sw a4,0(a5)
  nop
  lw s0,44(sp)
  addi sp,sp,48
  jr ra
sort:
  addi sp,sp,-48
  sw ra,44(sp)
  sw s0,40(sp)
  addi s0,sp,48
  sw a0,-36(s0)
  sw a1,-40(s0)
  sw zero,-20(s0)
.L9:
  lw a4,-20(s0)
  lw a5,-40(s0)
  bge a4,a5,.L10
  lw a5,-20(s0)
  addi a5,a5,-1
  sw a5,-24(s0)
.L8:
  lw a5,-24(s0)
  bltz a5,.L7
  lw a5,-24(s0)
  slli a5,a5,2
  lw a4,-36(s0)
  add a5,a4,a5
  lw a4,0(a5)
  lw a5,-24(s0)
  addi a5,a5,1
  slli a5,a5,2
  lw a3,-36(s0)
  add a5,a3,a5
  lw a5,0(a5)
  ble a4,a5,.L7
  lw a1,-24(s0)
  lw a0,-36(s0)
  call swap
  lw a5,-24(s0)
  addi a5,a5,-1
  sw a5,-24(s0)
  j .L8
.L7:
  lw a5,-20(s0)
  addi a5,a5,1
  sw a5,-20(s0)
  j .L9
.L10:
  nop
  lw ra,44(sp)
  lw s0,40(sp)
  addi sp,sp,48
  jr ra

memcpy:
  lw t1,0(a1)
  sw t1,-56(s0)
  
  lw t1,4(a1)
  sw t1,-52(s0)
  
  lw t1,8(a1)
  sw t1,-48(s0)

  lw t1,12(a1)
  sw t1,-44(s0) 

  lw t1,16(a1)
  sw t1,-40(s0)

  lw t1,20(a1)
  sw t1,-36(s0)
  
  lw t1,24(a1)
  sw t1,-32(s0)
  
  lw t1,28(a1)
  sw t1,-28(s0)
  
  lw t1,32(a1)
  sw t1,-24(s0)

  lw t1,36(a1)
  sw t1,-20(s0) 

  ret
main:
  addi sp,sp,-64
  sw ra,60(sp)
  sw s0,56(sp)
  addi s0,sp,64
  lui a5,%hi(.LC0)
  addi a4,s0,-56
  addi a5,a5,%lo(.LC0)
  li a3,40
  mv a2,a3
  mv a1,a5
  mv a0,a4
  call memcpy
  addi a5,s0,-56
  li a1,10
  mv a0,a5
  call show
  addi a5,s0,-56
  li a1,10
  mv a0,a5
  call sort
  addi a5,s0,-56
  li a1,10
  mv a0,a5
  call show
  li a5,0
  mv a0,a5
  lw ra,60(sp)
  lw s0,56(sp)
  addi sp,sp,64
  jr ra
