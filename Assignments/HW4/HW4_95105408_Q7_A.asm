.text
.globl main
main :
	nor $s1, $s1, $s1
	and $s3, $s1, $s2
	nor $s1, $s1, $s1
	nor $s2, $s2, $s2
	and $s1, $s1, $s2
	add $s3, $s3, $s1