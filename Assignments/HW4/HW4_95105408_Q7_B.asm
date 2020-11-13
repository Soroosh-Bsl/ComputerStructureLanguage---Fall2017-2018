.text

.globl main
main :
	sub $s3, $s1, $s2
	srl $s3, $s3, 31
	addi $s3, $s3, -1
	and $s1, $s1, $s3
	nor $s3, $s3, $s3
	and $s2, $s2, $s3
	add $s3, $s1, $s2