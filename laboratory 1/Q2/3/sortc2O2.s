.data
v:
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

.LC2:
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
  lui s2,%hi(.LC1)
.L3:
  lw a1,0(s0)
  addi a0,s2,%lo(.LC1)
  addi s0,s0,4
  mv  a0,a1
  li  a7,1
  ecall
  li  a7,4
  la  a0,.LC1
  ecall
  bne s1,s0,.L3
  lw s0,8(sp)
  lw ra,12(sp)
  lw s1,4(sp)
  lw s2,0(sp)
  li a0,10
  addi sp,sp,16
  li  a7,4
  la  a0,.LC1
  ecall
.L6:
  li a0,10
  li  a7,4
  la  a0,.LC2
  ecall
  ret
swap:
  slli a1,a1,2
  addi a5,a1,4
  add a5,a0,a5
  lw a3,0(a5)
  add a0,a0,a1
  lw a4,0(a0)
  sw a3,0(a0)
  sw a4,0(a5)
  ret
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
  
  
memcpy:
  lw t1,0(a1)
  sw t1,8(sp)
  
  lw t1,4(a1)
  sw t1,12(sp)
  
  lw t1,8(a1)
  sw t1,16(sp)

  lw t1,12(a1)
  sw t1,20(sp) 

  lw t1,16(a1)
  sw t1,24(sp)

  lw t1,20(a1)
  sw t1,28(sp)
  
  lw t1,24(a1)
  sw t1,32(sp)
  
  lw t1,28(a1)
  sw t1,36(sp)
  
  lw t1,32(a1)
  sw t1,40(sp)

  lw t1,36(a1)
  sw t1,44(sp) 

  ret
  
main:
  addi sp,sp,-64
  lui a1,%hi(v)
  li a2,40
  addi a1,a1,%lo(v)
  addi a0,sp,8
  sw ra,60(sp)
  call memcpy
  addi a0,sp,8
  li a1,10
  call show
  addi a0,sp,8
  li a1,10
  call sort
  addi a0,sp,8
  li a1,10
  call show
  lw ra,60(sp)
  li a0,0
  addi sp,sp,64
  jr ra
