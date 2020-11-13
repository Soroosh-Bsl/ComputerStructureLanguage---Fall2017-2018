.data
key:
	.space 28
.text
.macro read_int($arg)
	li $v0, 5
	syscall
	add $arg, $zero, $v0
.end_macro
.macro print_string($arg)
	li $v0, 4
	add $a0, $zero, $arg
	syscall
.end_macro
.globl main
main:
    li $v0, 8
    la $a0, key
    li $a1, 28
    syscall
    
    read_int($a1)
    #la $t0, key
    addi $a1, $a1, 2
    li $v0, 8
    add $a0, $sp, $zero
    syscall
    addi $a1, $a1, -2
    li $t0, 0
loop:
    slt $t1, $t0, $a1
    beq $t1, 0, finish
    add $t0, $sp, $t0
    lb $t2, 0($t0)
    slti $t3, $t2, 123
    bne $t3, 1, cont
    addi $t3, $zero, 96
    slt $t3, $t3, $t2
    bne $t3, 1, cont
    subi $t2, $t2, 97
    la $t1, key
    add $t2, $t2, $t1
    lb $t2, 0($t2)
    sb $t2, 0($t0)
cont:
    sub $t0, $t0, $sp
    addi $t0, $t0, 1
    j loop
 finish:
    print_string($sp)
    
