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
.end_macro
.macro print_char($arg)
	li $v0, 11
	add $a0, $zero, $arg
	syscall
.end_macro
.globl main
main:
	read_int($s0)
	read_int($s1)
	add $t1, $zero, $s0
	li $s6, 10
	li $s7, 1
change:
	slt $t0, $t1, $s1
	beq $t0, 1, change_finish
	div $t1, $s1
	mflo $t1
	mfhi $t2
	addi $s3, $s3, 1
	sll $t3, $s3, 2
	add $t3, $t3, $sp
	sw $t2, 0($t3)
	j change
change_finish: 
	addi $s3, $s3, 1
	sll $t3, $s3, 2
	add $t3, $t3, $sp
	sw $t1, 0($t3)
print_loop:
	sll $t3, $s3, 2
	add $t3, $t3, $sp
	lw $t2, 0($t3)
	slt $t7, $t2, $s6
	beq $t7, 1, normal
	addi $t2, $t2, 87
	print_char($t2)
	j continue_print 
normal:	
	print_int($t2)
continue_print:
	addi $s3, $s3, -1
	slt $t4, $s3, $s7
	beq $t4, 1, Exit
	j print_loop
Exit: