.text
.globl main
main:
	or $16, $0, $0 
	la $19, v #lw $19, v+12
	addi $19, $19, 12 #added 
loop: 
	sw $18, 0($19) #added
	beq $18, $zero, finish #bne $8, finish 
	add $16,$18,$16 #add $16,$19,$16 
	addi $19, $19, 4 #addi $19, 1 
	j loop 
finish: