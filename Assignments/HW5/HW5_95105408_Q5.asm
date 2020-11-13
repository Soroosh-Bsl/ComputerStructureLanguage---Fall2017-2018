.globl main
main:
	add $t0, $16, 4
	sw $t0, 0($16)
	lw $t0, 0($16)
	lw $t0, 0($t0)
	sw $t0, 4($16)
	
	sw $16, 16($16)