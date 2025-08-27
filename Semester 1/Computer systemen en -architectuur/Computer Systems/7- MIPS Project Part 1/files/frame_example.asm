.globl main

.text
########################################################################
#PROCEDURE to add two numbers
addtwonumbers:
	sw	$fp, 0($sp)	# push old frame pointer (dynamic link)
	move	$fp, $sp	# frame	pointer now points to the top of the stack
	subu	$sp, $sp, 16	# allocate 16 bytes on the stack
	sw	$ra, -4($fp)	# store the value of the return address
	sw	$s0, -8($fp)	# save locally used registers
	sw	$s1, -12($fp)

	move $s0, $a0		# $s0 = first number to be added
	move $s1, $a1		# $s1 = second number to be added
	
	add $t0, $s0, $s1
	
	move	$v0, $t0    	# place result in return value location

	lw	$s1, -12($fp)	# reset saved register $s1
	lw	$s0, -8($fp)	# reset saved register $s0
	lw	$ra, -4($fp)    # get return address from frame
	move	$sp, $fp        # get old frame pointer from current fra
	lw	$fp, ($sp)	# restore old frame pointer
	jr	$ra

########################################################################

#Starting Point
main:
	li $t0, 5
	li $t1, 6
	
	move	$a0, $t0	# Put procedure arguments
	move	$a1, $t1	# Put procedure arguments
	jal	addtwonumbers	# Call procedure
	
	move 	$t0, $v0	# Get procedure result
	
	move	$a0, $t0
	li 	$v0, 1		# syscall code 1 is for print_int
	syscall
	
exit:
	li   $v0, 10 		# system call for exit
	syscall      		# exit (back to operating system)
