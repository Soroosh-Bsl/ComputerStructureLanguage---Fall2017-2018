.data 
res1:
	.word 1
res2:
	.word 1
.text
.macro read_int($arg)
	li $v0, 5
	syscall
	add $arg, $zero, $v0
.end_macro

.globl main
main:
	read_int($s0)
	sra $t0, $s0, 3
	sll $t1, $s0, 3
	add $s1, $t0, $t1
	addi $s1, $s1, 10
	la $s2, res1
	sw $s1, 0($s2)
	sll $t0, $s0, 30
	srl $t0, $t0, 30
	la $s2, res2
	sw $t0, 0($s2)