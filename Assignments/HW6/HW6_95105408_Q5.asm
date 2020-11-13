.text
.globl main
main:
	sra $t1,$2,31   
	xor $2,$2,$t1   
	sub $2,$2,$t1 