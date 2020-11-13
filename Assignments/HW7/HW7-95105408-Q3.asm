.data
info:
	.word 11, 36, 3, -8, 1, -15, 0, 22
length:
	.word 8
.text
.globl main
main:	
	la $a1, length
	lw $a1, 0($a1) #length of array
	la $a0, info #address of array
	jal merge_sort
	j Exit
merge_sort:
	#a0 = i, a1 = j
	#t1 = i
	#t0 mid+1
	#t2 = j
	slt $t0, $fp, $sp
	beq $t0, 0, rest
	add $fp, $sp, 0
	sw $a0, 0($fp)
	subi $a1, $a1, 1
	sub $a0, $a0, $a0
rest:
	addi $sp, $sp, -16
	sw $a0, 0($sp) 
	sw $a1, 4($sp) 
	sw $ra, 8($sp)
	slt $t0, $a0, $a1
	beq $t0, 0, finish
	add $t0, $a0, $a1 
	sra $t0, $t0, 1
	
	
	sw $t0, 12($sp)
	
	add $a0, $zero, $a0
	add $a1, $zero, $t0
	jal merge_sort
	
	lw $t0, 12($sp)
	addi $t0, $t0, 1
	lw $t2, 4($sp)
	add $a0, $zero, $t0
	add $a1, $zero, $t2
	jal merge_sort
	
	lw $t1, 0($sp)
	lw $t0, 12($sp)
	lw $t2, 4($sp)
	addi $t0, $t0, 1
	add $a0, $t1, $zero
	add $a1, $t0, $zero
	add $a2, $t2, $zero
	jal merge
finish:
	lw $t4, 8($sp)
	add $ra, $zero, $t4
	addi $sp, $sp, 16
	jr $ra

merge:
	#a0 = i1, a1= i2, a2= j2, j1= a1-1
	sub $t0, $a2, $a0
	addi $t0, $t0, 1
	#la $t0, length
	#lw $t0, 0($t0)
	sll $t0, $t0, 2
	nor $t0, $t0, $t0
	addi $t0, $t0, 1
	add $sp, $sp, $t0
	lw $t0, 0($fp)
	#t1 = i1 = i, t2 = i2 = j, t3 = j1
	addi $t1, $a0, 0
	addi $t2, $a1, 0
	addi $t3, $a1, -1
	
	
loop_1:
	slt $t5, $t1, $t3
	slt $t6, $t2, $a2
	beq $t1, $t3, check_2nd
	bne $t5, 1, loop_2
check_2nd:
	beq $t2, $a2, cont1
	bne $t6, 1, loop_2
cont1:
	sll $t1, $t1, 2
	sll $t2, $t2, 2
	add $t5, $t0, $t1
	add $t6, $t0, $t2
	lw $t5, 0($t5)
	lw $t6, 0($t6)
	sra $t1, $t1, 2
	sra $t2, $t2, 2
	slt $t7, $t5, $t6
	beq $t7, 1, do_1
	j do_2
do_1:
	sw $t5, 0($sp)
	addi $sp, $sp, 4
	addi $t1, $t1, 1
	j loop_1
do_2:
	sw $t6, 0($sp)
	addi $sp, $sp, 4
	addi $t2, $t2, 1
	j loop_1
loop_2:
	slt $t5, $t1, $t3
	beq $t1, $t3, cont2
	bne $t5, 1, loop_3
cont2:
	sll $t1, $t1, 2
	add $t1, $t0, $t1
	lw $t5, 0($t1)
	sw $t5, 0($sp)
	addi $sp, $sp, 4
	sub $t1, $t1, $t0
	sra $t1, $t1, 2
	addi $t1, $t1, 1
	j loop_2
loop_3:
	slt $t5, $t2, $a2
	beq $t2, $a2, cont3
	bne $t5, 1, loop_4_set
cont3:
	sll $t2, $t2, 2
	add $t2, $t0, $t2
	lw $t5, 0($t2)
	sw $t5, 0($sp)
	addi $sp, $sp, 4
	sub $t2, $t2, $t0
	sra $t2, $t2, 2
	addi $t2, $t2, 1
	j loop_3
loop_4_set:
	sub $t0, $a2, $a0
	addi $t0, $t0, 1
	#la $t0, length
	#lw $t0, 0($t0)
	sll $t0, $t0, 2
	nor $t0, $t0, $t0
	addi $t0, $t0, 1
	add $sp, $sp, $t0
	lw $t0, 0($fp)
	add $t1, $zero, $a0
	add $t2, $zero, $zero
loop4_do:
	slt $t3, $t1, $a2
	beq $t1, $a2, copy
	beq $t3, 1, copy
	jr $ra
copy:
	lw $t3, 0($sp)
	addi $sp, $sp, 4
	sll $t1, $t1, 2
	add $t1, $t0, $t1
	sw $t3, 0($t1)
	sub $t1, $t1, $t0
	sra $t1, $t1, 2
	addi $t1, $t1, 1
	j loop4_do
Exit:
