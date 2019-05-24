.data 
str0: .asciiz "Welcome to BobCat Candy, home to the famous BobCat Bars!"
# Declare any necessary data here
str1: .asciiz "\nPlease enter the price of a BobCat Bar:\n"
str2: .asciiz "Please enter the number of wrappers needed to exchange for a new bar:\n"
str3: .asciiz "How, how much do you have?\n"
str4: .asciiz "Good! Let me run the number ...\n"
str5: .asciiz "You first buy "
str6: .asciiz "Then, you will get another "
str7: .asciiz "With $"
str8: .asciiz " you will receive a maximum of "
str9: .asciiz " BobCat Bars!"
strBars: .asciiz " bars.\n"

.text

main:
		#This is the main program.
		#It first asks user to enter the price of each BobCat Bar.
		#It then asks user to enter the number of bar wrappers needed to exchange for a new bar.
		#It then asks user to enter how much money he/she has.
		#It then calls maxBars function to perform calculation of the maximum BobCat Bars the user will receive based on the information entered. 
		#It then prints out a statement about the maximum BobCat Bars the user will receive.
		
		addi $sp, $sp -4	# Feel free to change the increment if you need for space.
		sw $ra, 0($sp)
		# Implement your main here
		
		#intro text and save values
		la $a0, str0
		li $v0, 4
		syscall
		
		la $a0, str1
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		move $t0, $v0
		
		la $a0, str2
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		move $t1, $v0
		
		la $a0, str3
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		move $t2, $v0
		
		# process new information
		la $a0, str4
		li $v0, 4
		syscall
		
		add $a0, $t1, $zero
		add $a1, $t0, $zero
		add $a2, $t2, $zero
		
		addi $sp, $sp, -12
		sw $t2, 8($sp)
		sw $t1, 4($sp)
		sw $t0, 0($sp)

		jal maxBars 	# Call maxBars to calculate the maximum number of BobCat Bars
		
		lw $t0, 0($sp)
		lw $t1, 4($sp)
		lw $t2, 8($sp)
		addi $sp, $sp, 12
		
		add $t3, $v0, $zero

		# Print out final statement here
		la $a0, str7
		li $v0, 4
		syscall
		
		add $a0, $t2, $zero
		li $v0, 1
		syscall
		
		la $a0, str8
		li $v0, 4
		syscall
		
		add $a0, $t3, $zero
		li $v0, 1
		syscall
		
		la $a0, str9
		li $v0, 4
		syscall

		j end			# Jump to end of program



maxBars:
		# This function calculates the maximum number of BobCat Bars.
		# It takes in 3 arguments ($a0, $a1, $a0) as n, price, and money. It returns the maximum number of bars
		slt $t0, $a2, $a1
		beq $t0, 1, theFin
		
		div $t0, $a2, $a1
		add $t1, $a0, $zero
		
		la $a0, str5
		li $v0, 4
		syscall
		
		add $a0, $t0, $zero
		li $v0, 1
		syscall
		
		la $a0, strBars
		li $v0, 4
		syscall
		
		add $a0, $t0, $zero
		add $a1, $t1, $zero
		add $v0, $zero, $zero
		
		addi $sp, $sp, -8
		sw $t0, 4($sp)
		sw $ra, 0($sp)

		jal newBars 	# Call a helper function to keep track of the number of bars.
		
		lw $ra, 0($sp)
		lw $t0, 4($sp)
		addi $sp, $sp, 8
		
		add $v0, $v0, $t0
		jr $ra
		
theFin:		add $v0, $zero, $zero #return 0 if not enough money
		jr $ra
		# End of maxBars

newBars:
		# This function calculates the number of BobCat Bars a user will receive based on n.
		# It takes in 2 arguments ($a0, $a1) as number of bars so far and n.
		div $t0, $a0, $a1
		beq $t0, 0, fin
		
		addi $sp, $sp, -12
		sw $v0, 8($sp)
		sw $a0, 4($sp)
		sw $a1, 0($sp)
		
		la $a0, str6
		li $v0, 4
		syscall
		
		add $a0, $t0, $zero
		li $v0, 1
		syscall
		
		la $a0, strBars
		li $v0, 4
		syscall
		
		lw $v0, 8($sp)
		lw $a0, 4($sp)
		lw $a1, 0($sp)
		addi $sp, $sp, 12
		
		add $v0, $v0, $t0
		
		add $a0, $t0, $zero
		
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		jal newBars
		
fin:		
		lw $ra, 0($sp)
		addi $sp, $sp, 4

		jr $ra
		# End of newBars

end: 
		# Terminating the program
		lw $ra, 0($sp)
		addi $sp, $sp 4
		li $v0, 10 
		syscall
