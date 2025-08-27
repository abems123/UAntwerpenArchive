	.data
	# Plaats je data elementen hier
pi:	.float 3.14

	.text
	# request radius from user 
	li $v0, 6 # it get saved in $f0
	syscall
	
	# save pi in $f1
	lwc1 $f1, pi
	mul.s $f12, $f0, $f0 # save r*r in $f12
	mul.s $f12, $f12, $f1 # multiply $f12 and $f1 and save them in $f12
	
	# print a float which is saved in $f12
	li $v0, 2
	syscall
	
	# exit
	li $v0, 10
	syscall
    	