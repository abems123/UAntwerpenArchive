	.data
	# make the jump table with the cases
jump_table:	.word case0, case1, case2, default
c:	.asciiz "\n"

	.text	
	# read an integer n and move it to $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	# check if n > 2 or n < 0
	blt $t0, $zero, default
	li $t1, 2
	bgt $t0, $t1, default
	
	# check voor de cases
	la $t2, jump_table  # load the address of jump_table in $t2
	sll $t0, $t0, 2     # multiply the entered int with 4
	add $t2, $t2, $t0   # add the new number to $t2 (the address of jump_table)
	lw $t3, 0($t2)      # load the word that exists in the new address that we've just counted in the previous line
	jr $t3              # jump to the chosen case
	
case0:	addi $s0, $zero, 9
	j exit
case1:	addi $s0, $zero, 6
case2:	addi $s0, $zero, 8
	j exit
default:	addi $s0, $zero, 7
	j exit

	# print the integer a
exit:	li $v0, 1
	la $a0, ($s0)
	syscall
	#exit
	li $v0, 10
	syscall
