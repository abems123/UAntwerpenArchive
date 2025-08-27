	.data
one:	.asciiz "This is my "
two:	.asciiz "-th MIPS-program"
	.text
	
	# read int from the user
main:	li $v0, 5
	syscall
	# move the entered int to $t0
	move $t0, $v0
	
	# print string which is "This is my "
	li $v0, 4
	la $a0, one
	syscall
	
	# print the entered integer which exists in the $t0 register
	li $v0, 1
	move $a0, $t0
	syscall
	
	# print string which is "-th MIPS-program"
	li $v0 4
	la $a0, two
	syscall
	
	# exit the program
	li $v0, 10
	syscall