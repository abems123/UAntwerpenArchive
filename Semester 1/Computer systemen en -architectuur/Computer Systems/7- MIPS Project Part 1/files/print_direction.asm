 .globl main

.data
z:	.asciiz "\nup\n"
q:	.asciiz "\nleft\n"
s:	.asciiz "\ndown\n"
d:	.asciiz "\nright\n"
invalid:	.asciiz "\nUnknown input! Valid inputs: z s q d x\n"

.text

main:
    	# add code here ...
   
	
poll_input:	addi $sp, $sp, -8 # allocate 2 bytes for
	li $v0, 8         # read a string from the user
	la $a0, ($sp) # the result will be save in the address $t1
	li $a1, 2
	syscall
	lw $t0, ($sp) # load the word to t0
	addi $sp, $sp, 8
	
	li $t1, 120
	beq $t0, $t1, exit       # if entered letter is x, exit
	li $t1, 122
	beq $t0, $t1, print_up   # if entered letter is z, print up
	li $t1, 113
	beq $t0, 113, print_left # if entered letter is q, print left
	li $t1, 100
	beq $t0, $t1, print_right # if entered letter is d, print right
	li $t1, 115
	beq $t0, $t1, print_down # if entered letter is s, print down
	j invalid_out	# if it's another letter, print ivalid
	
	
	# print string   	
print:	li $v0, 4	
	syscall
	
	# Wait for 2 seconds
    	li $v0, 32                 # Sleep syscall
    	li $a0, 2000               # Delay for 2000 milliseconds (2 seconds)
    	syscall                    # Execute sleep
    	
    	j poll_input

print_up:	la $a0, z
	j print
	
	
print_left:	la $a0, q
	j print
	
print_down:	la $a0, s
	j print
	
print_right:	la $a0, d
	j print
	
	
invalid_out:	li $v0, 4
	la $a0, invalid
	syscall
	j exit

exit:
    # syscall to end the program
    li $v0, 10    
    syscall
