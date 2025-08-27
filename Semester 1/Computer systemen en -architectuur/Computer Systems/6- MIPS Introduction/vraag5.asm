	.data
prime_msg:	.asciiz "--Prime--"
not_prime_msg:.asciiz "--No Prime--"

	.text
	
	# vraag een integer and sla het op $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	# check if n == 0 or n == 1 or n % 2 == 0
	rem $t1, $t0, 2
	li $t2, 1
	beq $t0, $zero, not_prime
	beq $t0, $t2, not_prime
	beq $t1, 0, not_prime
	
	# if n == 2 then it's prime
	li $t2, 2
	beq $t0, $t2, prime
	
	# set i = 3
	li $t2, 3
	
	# ik weet geen enkele manier om sqrt te krijgen, dus ik ga gewoon een for loop gebruiken tot dat i > n
loop:	beq $t2, $t0, prime
	rem $t3, $t0, $t2          # j = n % i
	beq $t3, $zero, not_prime  # if j == 0 then n not prime
	addi $t2, $t2, 1
	j loop
	
	# print prime_msg
prime:	li $v0, 4
	la $a0, prime_msg
	syscall
	j exit
	
	# print not_prime_msg
not_prime:	li $v0, 4
	la $a0, not_prime_msg
	syscall
	j exit
	
	# exit
exit:	li $v0, 10
	syscall
	
