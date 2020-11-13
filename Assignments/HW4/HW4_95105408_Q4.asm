.text
.globl main
main :
	lw $s3, 0($sp)
	lw $s2, 4($sp)
	lw $s1, 12($sp)
	
	sub $s1, $s1, $s3
	add $s3, $s3, $s1
	sub $s1, $s3, $s1

	sub $s3, $s3, $s2
	add $s2, $s2, $s3
	sub $s3, $s2, $s3
