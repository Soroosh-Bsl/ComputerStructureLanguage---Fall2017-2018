.data
matrix:
	.word 5, 1, 3, 2, 4, 9, 2, 7, 0
.text
.globl main
main:
	addi $sp, $sp, -8
	add $t0, $zero, 3
	sw $t0, 0($sp)
	la $t0, matrix
	sw $t0, 4($sp)
	jal determinant
	lw $s0, -4($sp) #result is in -4($sp) but just to check easier loaded into $s0
	j Exit
determinant:
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	slti $t2, $t0, 3
	bne $t2, 1, rec
	lw  $t2, 0($t1)
	lw $t3, 12($t1)
	mult $t2, $t3
	mflo $t2
	lw  $t3, 4($t1)
	lw $t4, 8($t1)
	mult $t3, $t4
	mflo $t3
	sub $t2, $t2, $t3
	sw $t2, -4($sp)
	jr $ra
rec:
	add $fp, $sp, $zero
	subi $sp, $sp, 4 #RESULT
	subi $sp, $sp, 4 #Loop Iterator
	sll $t2, $t0, 2  
	sub $sp, $sp, $t2 #N results
	add $t3, $sp, $zero
	subi $t2, $t0, 1
	mult $t2, $t2
	mflo $t2
	sll $t2, $t2, 2
	sub $sp, $sp, $t2 #New Array
	add $t2, $zero, $sp
	sub $sp, $sp, 20 #start of N, fp, ra, next M, N-1
	sw $t2, 4($sp)
	subi $t2, $t0, 1
	sw $t2, 0($sp)
	sw $ra, 8($sp)
	sw $fp, 12($sp)
	sw $t3, 16($sp)
	or $t2, $zero, $zero
loop:
	slt $t3, $t2, $t0
	bne $t3, 1, FINISH
	lw $t3, 4($fp)
	sll $t4, $t2, 2
	add $t3, $t4, $t3
	lw $t5, 0($t3)
	lw $t3, 16($sp)
	add $t3, $t4, $t3
	sw $t5, 0($t3)
	sw $t2, -8($fp)
	add $t4, $t0, $zero
	mult $t0, $t0
	mflo $t3
	addi $t6, $sp, 20
	#sll $t3, $t3, 2
	#add $t3, $t3, $t1
loop_2:
	slt $t5, $t4, $t3
	bne $t5, 1, finish
	div $t4, $t0
	mfhi $t5
	bne $t5, $t2, push
	addi $t4, $t4, 1
	j loop_2
push:
	sll $t4, $t4, 2
	add $t4, $t4, $t1
	lw $t5, 0($t4)
	sub $t4, $t4, $t1
	sra $t4, $t4, 2
	sw $t5, 0($t6)
	addi $t6, $t6, 4
	addi $t4, $t4, 1
	j loop_2
finish:
	jal determinant
	lw $fp, 12($sp)
	lw $t0, -4($sp)
	lw $t2, -8($fp)
	lw $t3, 16($sp)
	sll $t2, $t2, 2
	add $t3, $t3, $t2
	sra $t2, $t2, 2
	lw $t4, 0($t3)
	mult $t4, $t0
	mflo $t0
	addi $t9, $zero, 2
	div $t2, $t9
	mfhi $t5
	beq $t5, 0, cont
	not $t0, $t0
	addi $t0, $t0, 1
cont:
	sw $t0, 0($t3)
	lw $t0, 0($fp)
	lw $t1, 4($fp)
	addi $t2, $t2, 1
	j loop
FINISH:
	lw $t9, 0($fp)
	lw $t0, 16($sp)
	sw $zero, -4($fp)
	or $t1, $zero, $zero
FINISH_loop:
	slt $t2, $t1, $t9
	bne $t2, 1, return
	sll $t1, $t1, 2
	add $t3, $t1, $t0
	sra $t1, $t1, 2
	addi $t1, $t1, 1
	lw $t4, 0($t3)
	lw $t5, -4($fp)
	add $t5, $t4, $t5
	sw $t5, -4($fp)
	j FINISH_loop
return:
	lw $ra, 8($sp)
	add $sp, $zero, $fp
	jr $ra
	
Exit:
