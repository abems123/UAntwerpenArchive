	.data
endl:	.asciiz "\n"
space: 	.asciiz " "
	
	.text
	# s0 = i, s1 = j
	li $s0, 0
	
	# read an integer and save it in $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	# if $s0 is greater than $t0 then exit
loop_one:	bgt $s0, $t0, exit
	
	# set $s1 to 1
	li $s1, 1
	
loop_two:	bgt $s1, $s0, next
	# print integer
	li $v0, 1
	la $a0, ($s1)
	syscall
	
	# print space
	li $v0, 4
	la $a0, space
	syscall
	
	# increase $s1
	addi $s1, $s1, 1
	j loop_two
	
next:	# print new line
	li $v0, 4
	la $a0, endl
	syscall
	
	# increase $s0 with 1
	addi $s0, $s0, 1
	j loop_one
	

    # I converted this c++ code to assembly
    # I used $s0 as i and $s1 as j 	
    # int i = 0;
    # for (; ;) {
    #    if (i > n) break;
    #        int j = 1;
    #        for (; ;) {
    #            if (j > i) break;
    #            cout << j << ' ';
    #            j++;
    #        }
    #        cout << endl;
    #        i++;
    # }
	
	
exit:	li $v0, 10
	syscall