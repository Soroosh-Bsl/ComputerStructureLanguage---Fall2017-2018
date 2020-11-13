.text
.globl main
main :
	lw $s0, x
	sll $t0, $s0, 2
	add $t0, $t0, $s0
	sll $t1, $t0, 4
	sub $t1, $t1, $t0
	sw $t0, x
