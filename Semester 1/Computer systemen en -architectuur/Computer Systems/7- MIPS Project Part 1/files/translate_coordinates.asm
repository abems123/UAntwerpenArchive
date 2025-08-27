	.globl main

	.data

amountOfRows:    .word 16  # The mount of rows of pixels
amountOfColumns: .word 32  # The mount of columns of pixels

promptRows: 	.asciiz "Please enter the row number:\n"
promptCols: 	.asciiz "Please enter the column number:\n"

msgShowMemoryAddress: .asciiz "The memory address for the pixel is:\n"
endl:	.asciiz "\n"

	.text

main:

    	li $v0, 4		# print string
    	la $a0, promptRows  # message to ask the user for the row number
    	syscall
    
    	li $v0, 5  # read integer
    	syscall    # ask the user for a row number
    	move $t0, $v0 # t0 contains the row number
    	
    	li $v0, 4		# print string
    	la $a0, promptCols  # message to ask the user for the column number
    	syscall
    
    	li $v0, 5  # read integer
    	syscall    # ask the user for a column number
    	move $t1, $v0 # t1 contains the column number
    	
   	# add code here ...
   	# we can get the memory address by this formula
   	# $gp + (row * 32 + column) * 4
	mul $t0, $t0, 32  # $t0 = row * 32
	add $t0, $t0, $t1	# $t0 = row * 32 + col
	mul $t0, $t0, 4	# $t0 = (row * 32 + col) * 4
	add $t0, $t0, $gp # $t0 = $gp + (row * 32 + col) * 4
    	
    	li $v0, 4	
    	la $a0, msgShowMemoryAddress  
    	syscall
    	
    	li $v0, 1		
	move $a0, $t0
    	syscall
    	
exit:

    	li $v0, 10  # syscall to end the program
    	syscall
