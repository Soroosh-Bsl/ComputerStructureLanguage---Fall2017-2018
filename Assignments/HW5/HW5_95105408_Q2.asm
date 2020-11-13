.data
choose_lang:
	.asciiz "Please choose your language :\n0 English\n1 French\n2 Italian\n"
choose_gender:
	.asciiz "Please choose your gender :\n0 Male\n1 Female\n"
hello_sir:
	.asciiz "Hello Sir"
hello_madam:
	.asciiz "Hello Madam"
bonjour_monsieur:
	.asciiz "Bonjour Monsieur"
bonjour_madame:
	.asciiz "Bonjour Madame"
salve_signore:
	.asciiz "Salve Signore"
salve_signora:
	.asciiz "Salve Signora"	
.text
.macro print_string($arg)
	li $v0, 4
	la $a0, $arg
	syscall
.end_macro

.macro read_int($arg)
	li $v0, 5
	syscall
	add $arg, $zero, $v0
.end_macro
.globl main
main :
	print_string(choose_lang)
	read_int($s0)
	print_string(choose_gender)
	read_int($s1)
	srl $t0, $s1, 2
	add $t0, $t0, $s0
	beq $t0, $zero, eng_M
	beq $t0, 1, fre_M
	beq $t0, 2, ita_M
	beq $t0, 4, eng_F
	beq $t0, 5, fre_F
	beq $t0, 6, ita_F

eng_M:
	print_string(hello_sir)
	beq $zero, $zero, Exit
fre_M:
	print_string(bonjour_monsieur)
	beq $zero, $zero, Exit
ita_M:
	print_string(salve_signore)
	beq $zero, $zero, Exit
eng_F:
	print_string(hello_madam)
	beq $zero, $zero, Exit
fre_F:
	print_string(bonjour_madame)
	beq $zero, $zero, Exit
ita_F:
	print_string(salve_signora)
	beq $zero, $zero, Exit
Exit: