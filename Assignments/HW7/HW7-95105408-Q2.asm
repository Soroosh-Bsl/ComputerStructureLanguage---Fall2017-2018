.text
.macro read_int($arg)
	li $v0, 5
	syscall
	add $arg, $zero, $v0
.end_macro
.macro print_int($arg)
	li $v0, 1
	add $a0, $zero, $arg
	syscall
.end_macro
.globl main
main:
    read_int($s0)
    add    $a0,  $zero , $s0
    jal    oyler        # jump to oyler and save position to $ra
    print_int($s2)
    j Exit
oyler:
    li    $s1, 0
    add $t9, $zero, $ra
oyler_loop:
    addi  $s1, $s1, 1
    slt $t8, $s1, $a0
    beq $t8, 0, finish
    
    jal bmm
    
    beq $v0, 0, count
    j oyler_loop
count:
    addi    $s2, $s2, 1
    j     oyler_loop        # jump to oyler_loop
finish:
add $ra, $zero, $t9
  jr $ra

bmm:
    li    $t0,  1  #$t0 = 2
bmm_loop:
    addi $t0, $t0, 1
    slt $t3, $t0, $s1
    beq $t0, $s1, continue
    beq $t3, 0, no
continue:
    div    $s0, $t0      # $s0 / t0
    mfhi  $t1          #  = $s0 mot0
    div    $s1, $t0      # $s1 /$t0
    mfhi  $t2          #  = $s1 m$t0
    beq    $t1, 0, check_sec  # if $t1 =0thcheck_sec
    j bmm_loop
check_sec:
    beq    $t2, 0, yes  # if$t2  0thyes
    j bmm_loop
no:
    li $v0, 0
    jr $ra
yes:
    li $v0, 1
    jr $ra
Exit:
