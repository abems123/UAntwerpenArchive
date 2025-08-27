# fibonacci

	.data
msg0:	.asciiz "Enter a number n: "
msg1:	.asciiz "The result is: "
nl:	.asciiz "\n"

	
	.text
	j main
	
Fibonacci:	beqz $a0, return0
	beq $a0, 1, return1
	
	li $t0, 0  # n - 2
	li $t1, 1  # n - 1
	li $t2, 1  # counter
	
loop:	bgt $t2, $a0, endloop
	add $v0, $t0, $t1
	move $t0, $t1
	move $t1, $v0
	addi $t2, $t2, 1
	j loop

endloop:	jr $ra	
	
return0:	li $v0, 0
	jr $ra
	
return1:	li $v0, 1
	jr $ra
	
#============== read a int from the user==================#
main:	li $v0, 4
	la $a0, msg0
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $v0, 4
	la $a0, nl
	syscall
	
	li $v0, 4
	la $a0, msg1
	syscall
#=========================================================#
	
	move $a0, $t0
	jal Fibonacci

		
#============== print the fibonacci value ==================#
	
	move $t0, $v0
	li $v0, 1
	move $a0, $t0
	syscall
#===========================================================#
	