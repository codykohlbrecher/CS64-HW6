# calculation.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0, $a1, $a2
#   make all returned values from functions go in $v0

.text
conv:
    # CODE MISSING: Student to complete this part

    move $t0, $a0      # t0 = a0 = x
    move $t1, $a1      # t1 = a1 = y
    move $t2, $a2      # t2 = a2 = n

    li   $t3, 0        # z = 0
    li   $t4, 0        # i = 0

loop:
    bge  $t4, $t2, done #exit for loop if i >= n 

    sll  $t5, $t1, 2   # t5 = 4*y
    subu $t3, $t3, $t0 # z = z - x
    addu $t3, $t3, $t5 # z = z + 4*y 
    # ^^ z = z - x + 4 * y
    slti $t6, $t0, 2   
    bgt  $t6, $zero, skip
    subu $t1, $t1, $t0 # y -= x

skip:
    addiu $t0, $t0, 1  # x++
    addiu $t4, $t4, 1  # i++
    j    loop

done:
    move $v0, $t3
    jr   $ra

main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 5
    li $a1, 7
    li $a2, 7

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall
