.text
.globl main
main :
	sll $t1, $t0, 2
	add $t2, $t9, $t1
	lw $t3, 0($t2)
	sll $t4, $s1, 2
	addi $s1, $s1, 1
	add $t5, $t4, $t8
	lw $t6, 0($t5)
	and $t1, $t3, $t6
	sll $t2, $t1, 2
	add $t4, $t7, $t2
	lw $t5, 0($t4)
	add $s0, $s1, $t5
