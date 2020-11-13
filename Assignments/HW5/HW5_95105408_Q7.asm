.data
x:
	.asciiz "x ?"
a:
	.asciiz "a ?"
b:
	.asciiz "b ?"
c:
	.asciiz "c ?"
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
.globl main
main:
	print_string(x)
	read_int($s0)
	print_string(a)
	read_int($t0)
	print_string(b)
	read_int($t1)
	print_string(c)
	read_int($t2)
	
	mult $s0, $s0
	mflo $s1
	mult $s1, $s0
	mflo $s2
	mult $s0, $t0
	mflo $t3
	add $t3, $t3, $t1
	addi $t4, $s2, 1
	mult $t3, $t4
	mflo $t3
	mult $t2, $s1
	mflo $t4
	add $t3, $t3, $t4
	
	print_int($t3)