.text
.macro memory_indirect($first, $address)
	lw $address, 0($address)
	lw $address, 0($address)
	add $first, $address, $first
.end_macro
.macro direct($arg, $imm)
	lw $imm, $imm($zero)
	add $arg, $arg, $imm
.end_macro
.macro register_indirect($first, $sec)
	lw $sec, 0($sec)
	add $first, $first, $sec
.end_macro
.macro scaled($first, $imm,  $sec, $third, $d)
	mult $third, $d
	mflo $third
	add $sec, $sec $third
	addi $sec, $sec, $imm
	lw $sec, 0($sec)
	add $first, $first, $sec
.end_macro
.macro auto_increament($first, $sec, $d)
	lw $sec, 0($sec)
	add $first, $first, $sec
	addi $sec, $d
.end_macro
.macro indexed($first, $sec, $third)
	add $sec, $sec, $third
	lw $sec, 0($sec)
	add $first, $first, $sec
.end_macro
.globl main
main :

	
	
	
