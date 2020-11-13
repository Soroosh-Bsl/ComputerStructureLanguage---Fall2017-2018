.text
.macro read_int($arg)
	li $v0, 5
	syscall
	add $arg, $zero, $v0
.end_macro
.macro read_symbol($arg)
	li $v0, 12
	syscall
	add $arg, $zero, $v0
.end_macro
.macro print_int($arg)
	li $v0, 1
	add $a0, $zero, $arg
	syscall
.end_macro
.globl main
main:
	read_int($s0)
	read_int($s1)
	read_symbol($s2)
	addi $t0, $zero, 43
	beq $s2, $t0, sum
	sub $s0, $s0, $s1
	print_int($s0)
	beq $zero, $zero, Exit
sum:
	add $s0, $s0, $s1
	print_int($s0)
Exit:
