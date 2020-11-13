.text
.globl main
main :
	addi $s0, $s0, 1
	add $t1, $s0, $zero
	sll $t1, $t1, 2
	add $t2, $t9, $t1
	lw $t3, 0($t2)
	sub $t4, $s1, $t3
	nor $t4, $t4, $t4
	add $s0, $t4, $zero
