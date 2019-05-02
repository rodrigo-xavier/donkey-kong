.data
v:

  .word 9
  .word 2
  .word 5
  .word 1
  .word 8
  .word 2
  .word 4
  .word 3
  .word 6
  .word 7
.LC0:
  .string "\t"
.LC1:
  .string "\n"

.text
j main
show:
  blez a1,.L6
  addi sp,sp,-16
  sw s1,4(sp)
  slli s1,a1,2
  sw s0,8(sp)
  sw s2,0(sp)
  sw ra,12(sp)
  mv s0,a0
  add s1,a0,s1
  lui s2,%hi(.LC0)
.L3:
  lw a1,0(s0)
  addi a0,s2,%lo(.LC0)
  addi s0,s0,4
  ########
  mv  a0,a1
  li  a7,1
  ecall
  li  a7,4
  la  a0,.LC0
  ecall
  ########
  bne s1,s0,.L3
  lw s0,8(sp)
  lw ra,12(sp)
  lw s1,4(sp)
  lw s2,0(sp)
  li a0,10
  addi sp,sp,16
  #######
  li  a7,4
  la  a0,.LC1
  ecall
  #######
.L6:
  li a0,10
  #######
  li  a7,4
  la  a0,.LC1
  ecall
  #######
  jr ra
swap:
  slli a1,a1,2
  addi a5,a1,4
  add a5,a0,a5
  lw a3,0(a5)
  add a0,a0,a1
  lw a4,0(a0)
  sw a3,0(a0)
  sw a4,0(a5)
  jr ra
sort:
  blez a1,.L11
  li a7,0
  addi t3,a1,-1
  li a6,-1
  mv a4,a7
  beq a7,t3,.L11
.L20:
  lw a3,0(a0)
  lw a2,4(a0)
  addi t1,a0,4
  mv a1,t1
  mv a5,a0
  bgt a3,a2,.L15
  j .L16
.L19:
  
  lw a3,-4(a5)
  lw a2,0(a5)
  addi a0,a0,-4
  addi a5,a5,-4
  addi a1,a1,-4
  ble a3,a2,.L16

.L15:
  sw a2,0(a0)
  sw a3,0(a1)
  addi a4,a4,-1
  bne a4,a6,.L19
.L16:
  addi a7,a7,1
  mv a0,t1
  mv a4,a7
  bne a7,t3,.L20
.L11:
  ret
main:
  addi sp,sp,-16
  sw s0,8(sp)
  lui s0,%hi(v)
  addi a0,s0,%lo(v)
  li a1,10
  sw ra,12(sp)
  call show
  lui s0,%hi(v)
  addi a0,s0,%lo(v)
  li a1,10
  call sort
   lui s0,%hi(v)
  addi a0,s0,%lo(v)
  li a1,10
  call show
  lw ra,12(sp)
  lw s0,8(sp)
  li a0,0
  addi sp,sp,16
  jr ra
