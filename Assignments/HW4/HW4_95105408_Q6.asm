.data
data:
	.ascii "abcd"
.text
.globl main
main :
	la $t1, data
	lw $t8, 0($t1)
	sub $t9, $t9, $t9
	addi $t9, $t9, 1
	sll $t9, $t9, 5
	sub $t8, $t8, $t9
	sll $t9, $t9, 16
	sub $t8, $t8, $t9
