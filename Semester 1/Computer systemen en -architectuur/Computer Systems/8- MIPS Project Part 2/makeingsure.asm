 .globl main

.data
mazeFilename:    .asciiz "input_1.txt"
buffer:          .space 4096
victoryMessage:  .asciiz "\nYou have won the game!\n"

amountOfRows:    .word 16  # The mount of rows of pixels
amountOfColumns: .word 32  # The mount of columns of pixels

wallColor:      .word 0x004286F4    # Color used for walls (blue)
passageColor:   .word 0x00000000    # Color used for passages (black)
playerColor:    .word 0x00FFFF00    # Color used for player (yellow)
exitColor:      .word 0x0000FF00    # Color used for exit (green)

.text

main:	#==================== open the file ====================#
	li $v0, 13
	la $a0, mazeFilename
	li $a1, 0
	li $a2, 0
	syscall
	move $s2, $v0     # $s2 is the file descriptor
	#==================== open the file end ====================#
	
	
	li $t0, 0 # i row
	li $t1, 0 # j column
	
	#==================== read the file data ====================#
read_file:	li $v0, 14  
	move $a0, $s2   # move the file descriptor to $a0
	
	addi $sp, $sp, -4 # allocate 1 byte in stack
	la $a1, ($sp)  # add the buffer
	li $a2, 1   # the number of bytes to read
	syscall
	move $t2, $v0 # save the number of read characters in $t2

	# move the read letter to $t3	
	lw $t3, ($sp)	
	addi $sp, $sp, 4 # deallocate the memory from stack
	
	# =========== Here we access each letter ============#
	bge $t0, 16, mainGameLoop # if the line is 16 or greater close file
	bge $t1, 32, nextLine # if the column is 32, go to a new line
	move $a0, $t0
	move $a1, $t1
	jal translateCoor # memory address get saved in $v0
	move $a0, $v0
	
	# ======== coloring each pixel with the color corresponding to it ======== #
	li $t4, 119
	beq $t3, $t4, wallPixel
	li $t4, 112
	beq $t3, $t4, passagePixel
	li $t4, 115
	beq $t3, $t4, playerPixel
	li $t4, 117
	beq $t3, $t4, exitPixel

	j read_file
	#==================== read the file data end====================#


mainGameLoop:	# Wait for 60 milleseconds
    	li $v0, 32                 # Sleep syscall
    	li $a0, 60               # Delay for 60 milliseconds
    	syscall                    # Execute sleep
    	
	addi $sp, $sp, -8 # allocate 2 bytes
	li $v0, 8         # read a string from the user
	la $a0, ($sp) # the result will be save in the address $sp
	li $a1, 2
	syscall
	lw $t0, ($sp) # load the word to t0
	addi $sp, $sp, 8  # deallocate the 2 bytes
	
	j checkChar


wallPixel:	# Color the pixel that exists in the memory $a0 with the color that exists in $a1
	lw $a1, wallColor
	sw $a1, ($a0)
	j nextColumn


passagePixel:	# Color the pixel that exists in the memory $a0 with the color that exists in $a1
	lw $a1, passageColor
	sw $a1, ($a0)
	j nextColumn

exitPixel:	# Color the pixel that exists in the memory $a0 with the color that exists in $a1
	lw $a1, exitColor
	sw $a1, ($a0)
	j nextColumn

playerPixel:	move $s0, $t0 # $s0 = player row
	move $s1, $t1 # $s1 = player column
	lw $a1, playerColor
	sw $a1, ($a0)
	j nextColumn



checkChar:	li $t1, 120
	beq $t0, $t1, exit       # if entered letter is x, exit
	li $t1, 122
	beq $t0, $t1, move_up   # if entered letter is z, print up
	li $t1, 113
	beq $t0, $t1, move_left # if entered letter is q, print left
	li $t1, 100
	beq $t0, $t1, move_right # if entered letter is d, print right
	li $t1, 115
	beq $t0, $t1, move_down # if entered letter is s, print down
	j exit	# if it's another letter, exit	
	
	
changePosition:	# $a0 old row, $a1 old column, $a2 new row, $a3 new column
	jal translateCoor # calculate the old address
	move $t0, $v0     # save the old address in $t0
	
	# move the new row and column to $a0 and $a1
	move $a0, $a2
	move $a1, $a3
	
	jal translateCoor # calculate the new address
	lw $t1, ($v0)	# put new coor in $t1
	lw $t2, wallColor
	beq $t1, $t2, mainGameLoop # if new coor is a wall just request a new letter

	# color the old address with passage color
	lw $a1, passageColor
	sw $a1, ($t0)
	
	# color the new address with passage playerColor
	lw $a1, playerColor
	sw $a1, ($v0)
	
	lw $t2, exitColor
	beq $t1, $t2, gameWon # if new coor is a wall just request a new letter
	
	# save the new row and column in $v0 and $v1 (I don't understand why we should save them here even though $v0 is going to be change just shortly after a new character gets requested, so I have to save them in $s0 and $s1)
	move $v0, $a2
	move $v1, $a3
	
	move $s0, $a2
	move $s1, $a3
	
	j mainGameLoop
	
	
gameWon:	# print string   	
	li $v0, 4	
	la $a0, victoryMessage
	syscall
	
	j exit

move_up:	move $a0, $s0	# save the old row in $a0
	move $a1, $s1	# save the old column in $a1
	
	subi $a2, $a0, 1	# old row - 1
	move $a3, $a1	# save the old column in $a3
	
	j changePosition

move_right:	move $a0, $s0	# save the old row in $a0
	move $a1, $s1	# save the old column in $a1
	
	move $a2, $a0	# save the old row in $a2
	addi $a3, $a1, 1	# new column + 1
	
	j changePosition
	
	
move_left:	move $a0, $s0	# save the old row in $a0
	move $a1, $s1	# save the old column in $a1
	
	move $a2, $a0	# save the old row in $a2
	subi $a3, $a1, 1	# new column + 1
	
	j changePosition
	
	
move_down:	move $a0, $s0	# save the old row in $a0
	move $a1, $s1	# save the old column in $a1
	
	addi $a2, $a0, 1	# old row + 1
	move $a3, $a1	# save the old column in $a3
	
	j changePosition
	
	

	

	
# add one to the current row and jump to main loop
nextLine:	addi $t0, $t0, 1
	li $t1, 0
	j read_file


# add one to the current column and jump to colums loop
nextColumn:	addi $t1, $t1, 1
	j read_file
	
	
# Inputs: $a0 is the row, $a1 is the column
translateCoor:	mul $v0, $a0, 32  # $v0 = row * 32
	add $v0, $v0, $a1	# $v0 = row * 32 + col
	mul $v0, $v0, 4	# $v0 = (row * 32 + col) * 4
	add $v0, $v0, $gp # $v0 = $gp + (row * 32 + col) * 4
	# memory address is saved in $v0
	jr $ra
	
		
				
	# close the file
close_file:	li $v0, 16
	move $a0, $t0
	syscall
	
    	j exit # nothing to do so go to exit



exit:
    # syscall to end the program
    li $v0, 10    
    syscall
