.data
error:
	.asciiz "ERROR"
	
.text
.macro print_string($arg)
	li $v0, 4
	la $a0, $arg
	syscall
.end_macro
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
.macro read_char($arg)
	li $v0, 12
	syscall
	add $arg, $zero, $v0
.end_macro
.globl main
main:
	read_int($s0)
	read_int($s1)
	read_char($s2)
	bne $s2, 43, c2_check
	j c1_do
c2_check:
	bne $s2, 45, c3_check
	j c2_do
c3_check:
	bne $s2, 42, c4_check
	j c3_do
c4_check:
	bne $s2, 47,c5_check
	j c4_do
c5_check:
	bne $s2, 37,c6_do
	j c5_do
c1_do:
	add $t0, $s0, $s1
	print_int($t0)
	j Exit
c2_do:
	sub $t0, $s0, $s1
	print_int($t0)
	j Exit
c3_do:
	mult $s0, $s1
	mflo $t0
	print_int($t0)
	j Exit
c4_do:
	div $s0, $s1
	mflo $t0
	print_int($t0)
	j Exit
c5_do:
	div $s0, $s1
	mfhi $t0
	print_int($t0)
	j Exit
c6_do:
	print_string(error)
	j Exit
Exit: