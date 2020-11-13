.text
.globl main
main :
	srl $t0, $s0, 31
	srl $t1, $s1, 31
	xor $t2, $t0, $t1
	beq $t0, 1, negative_first
	j second

negative_first:
	nor $s0, $s0, $s0
second:
	beq $t1, 1, negative_second
	j calc
	
negative_second:
	nor $s1, $s1, $s1
calc:
	multu $s0, $s1
	mflo $s2
	mfhi $s3
	beq $t2, 1, negative
	j Exit
negative:
	nor $s2, $s2, $s2
	nor $s3, $s3, $s3
	addi $s2, $s2, 1
	beq $s2, 0, add_hi
	j Exit
add_hi:
	addi $s3, $s3, 1
Exit:
	add $t0, $zero, $s2
	add $t1, $zero, $s3
