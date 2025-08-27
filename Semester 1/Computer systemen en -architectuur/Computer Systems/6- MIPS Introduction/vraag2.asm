	.data
endl:	.asciiz "\n"

	.text
	# request int n from the user
	li $v0, 5
	syscall
	move $t0, $v0
	
	# load 1 to the variable s0
	li $s0, 1
	# if $s0 is greater than $t0 jump to exit
loop:	bgt $s0, $t0, exit
	
	# print integer
	li $v0, 1
	la $a0, ($s0)
	syscall
	
	# print a new line
	li $v0, 4
	la $a0, endl
	syscall
	
	# increase the integer
	addi $s0, $s0, 1 
	j loop
	
	
	# exit
exit:	li $v0, 10
	syscall
