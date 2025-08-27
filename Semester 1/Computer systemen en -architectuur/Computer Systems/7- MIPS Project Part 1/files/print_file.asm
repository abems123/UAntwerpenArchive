 .globl main

.data
filename1: .asciiz "test_file_1.txt"
filename2: .asciiz "test_file_2.txt"
filename3: .asciiz "input_1.txt"


.text

main:
	# open the file
	li $v0, 13
	la $a0, filename3
	li $a1, 0
	li $a2, 0
	syscall
	move $t0, $v0     # $t0 is the file descriptor
	
	# read the file data
read_file:	li $v0, 14  
	move $a0, $t0   # copy the file descriptor in $a0
	
	addi $sp, $sp, -1 # allocate the memory in stack
	la $a1, ($sp)  # add the buffer
	li $a2, 1    # the number of bytes to read
	syscall
	move $t1, $v0 # 
	addi $sp, $sp, 1 # deallocate the memory from stack

	
	# print the buffer, which contains the read text
	li $v0, 4
	move $a0, $a1
	syscall
	
	beqz $t1, close_file # close the file if 
	j read_file
	

	
	# close the file
close_file:	li $v0, 16
	move $a0, $t0
	syscall
	
exit:
    # syscall to end the program
    li $v0, 10    
    syscall
