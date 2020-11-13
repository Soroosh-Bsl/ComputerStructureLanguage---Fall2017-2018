.text
.macro read_int($arg)
	li $v0, 5
	syscall
	add $arg, $zero, $v0
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
	add $t0, $zero, $s0
	addi $s4, $zero, 10
	addi $s5, $zero, 42
	addi $s6, $zero, 1
	addi $s7, $zero, 32
height:
	print_char($s4)
	slt $t2, $t0, $s6
	beq $t2, 1, finish
	add $t1, $zero, $s1
	addi $t3, $t0, -1
	addi $t0, $t0, -1
space_print:
	slt $t2, $t3, $s6
	beq $t2, 1, star_print
	print_char($s7)
	addi $t3, $t3, -1
	j space_print
star_print:
	slt $t2, $t1, $s6
	beq $t2, 1, height
	print_char($s5)
	addi $t1, $t1, -1
	j star_print

finish: