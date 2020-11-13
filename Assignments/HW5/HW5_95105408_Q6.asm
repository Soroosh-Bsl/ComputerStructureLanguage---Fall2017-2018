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
.globl main
main :
	read_int($s0)
	read_int($s1)
	
	addu $t3, $s1, $s0
	srl $t3, $t3, 31
	
	srl $t0, $s0, 31
	srl $t1, $s1, 31
	xor $t2, $t0, $t1
	beq $t2, 0, probable_problem
	j Exit_0
probable_problem:
	beq $t3, $t0, Exit_0
	j Exit_1
Exit_0:
	print_int($zero)
	j Exit
Exit_1:
	add $s7, $zero, 1
	print_int($s7)
Exit: