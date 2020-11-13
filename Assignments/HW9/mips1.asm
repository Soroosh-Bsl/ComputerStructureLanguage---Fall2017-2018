.data
num1:
	.word 1
num2:
	.word 2
num3:
	.word 3
result:
	.word 0
.text
.globl main
main:
	la $t0, num1
	lw $t1, 0($t0)
	la $t0, num2
	lw $t2, 0($t0)
	la $t0, num3
	lw $t3, 0($t0)
if:
	beq $t1, $t2, else_if
	slt $t0, $t1, $t2
	beq $t0, 1, else
	add $s0, $t1, $zero
	j finish
else_if:
	bgt $t2, $t3, else_if_else
else_if_if:
	and $s0, $t2, $t3
	j finish
else_if_else:
	or $s0, $t2, $t3
	j finish
else:
	addi $s0, $t3, 5
	j finish
finish:
	la $t0, result
	sw $s0, 0($t0)