	.globl main

	.data

amountOfRows:    	.word 16  # The mount of rows of pixels
amountOfColumns:  .word 32  # The mount of columns of pixels

colorRed:       	.word 0x00FF0000
colorYellow:    	.word 0x00FFFF00


	.text		
main:
    	# add code here ...
	move $a0, $gp	# $gp is the base address for display
	
	li $t0, 0 # i row
	li $t1, 0 # j column
	jal main_loop
	
exit:
    	# syscall to end the program
    	li $v0, 10    
    	syscall
	
# Variables: $t0 the current row, $t1 the current column
main_loop:	bge $t0, 16, exit
	
columns_loop:	bge $t1, 32, next_line
	move $a0, $t0
	move $a1, $t1
	jal translateCoor # memory address get saved in $a0
	
	beqz $t0, border_pixel # if current row eqals 0 it's a border pixel
	beqz $t1, border_pixel # if current column eqals 0 it's a border pixel
	li $t2, 15
	beq $t0, $t2, border_pixel # if current row eqals 15 it's a border pixel
	li $t2, 31
	beq $t1, $t2, border_pixel # if current column eqals 31 it's a border pixel
	
	# if none of the branches succed, then it's not a border pixel
	jal colorPixelRed
	j next_column

# add one to the current row and jump to main loop
next_line:	addi $t0, $t0, 1
	li $t1, 0
	j main_loop


# add one to the current column and jump to colums loop
next_column:	addi $t1, $t1, 1
	j columns_loop
	

# color the pixel in Yellow
border_pixel:	jal colorPixelYellow
	j next_column



# Inputs: $a0 is the row, $a1 is the column
translateCoor:	mul $a0, $a0, 32  # $a0 = row * 32
	add $a0, $a0, $a1	# $a0 = $a0 * 32 + col
	mul $a0, $a0, 4	# $a0 = ($a0 * 32 + col) * 4
	add $a0, $a0, $gp # $a0 = $gp + ($a0 * 32 + col) * 4
	# memory address is saved in $a0
	jr $ra
	
	
# Color the pixel that exists in the memory $a0 with yellow
colorPixelYellow:	lw $a1, colorYellow
	sw $a1, ($a0)
	jr $ra

# Color the pixel that exists in the memory $a0 with red	
colorPixelRed:	lw $a1, colorRed
	sw $a1, ($a0)
	jr $ra