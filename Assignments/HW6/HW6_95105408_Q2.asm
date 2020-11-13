.text
.macro read_int($arg)
	li $v0, 5
	syscall
	add $arg, $zero, $v0
.end_macro
.macro print_int($arg)
	li $v0, 1
	add $a0, $zero, $arg
	syscall
	li $a0, 32
	li $v0, 11
	syscall
.end_macro
.globl main
main:
	read_int($s0)
	add $t0, $zero, $s0
	add $s7, $s7, $zero
	addi $s1, $s0, -1
	li $t2, 0
read:
	addi $t0, $t0, -1
	read_int($t1)
	add $s6, $s7, $sp
	sw $t1, 0($s6)
	addi $s7, $s7, 4
	beq $t0, $zero, sort
	j read	
sort:
	add $t0, $zero, $zero
outer_loop:
	beq $t2, $s1, print
	addi $t2, $t2, 1
	li $t3, 0
	sub $t4, $s0, $t2
	j inner_loop 
inner_loop:
	beq $t3, $t4, outer_loop
	sll $t5, $t3, 2
	add $t5, $sp, $t5
	lw $s2, 0($t5)
	lw $s3, 4($t5)
	slt $t6, $s3, $s2
	beq $t6, 1, swap
	addi $t3, $t3, 1
	j inner_loop
swap:
	sw $s3, 0($t5)
	sw $s2, 4($t5)
	j inner_loop
print:
	sll $t1, $t0, 2
	add $t3, $t1, $sp
	lw $t2, 0($t3)
	print_int($t2)
	addi $t0, $t0, 1
	slt $t2, $t0, $s0
	beq $t2, 1, print
	
	