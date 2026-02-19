# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0, $a1
#   make all returned values from functions go in $v0

# Example array and alen - your code should work for any integer array of any length > 1.
.data
    array:  .word 6, 4, 0, 1, 2, 9, 3, 5, 8, 7
    alen:   .word 10
    newline: .asciiz "\n"
    space:  .asciiz " "

.text

bubble:

    lw   $t0, 0($a1)        # t0 = size, a0 stores the bass address of the array, a1 stores the address of the array length

    addi $t1, $t0, -1       # t1 = i = size - 1

outerLoop:
    blt  $t1, $zero, finished   # if (i < 0) done

    li   $t2, 1             # t2 = j = 1

innerLoop:
    bgt  $t2, $t1, nexti   # when j > i end loop 

    # get values of the array at j - 1  and j
    addi $t3, $t2, -1       # t3 = j-1
    sll  $t4, $t3, 2        # t4 = 4(j-1)
    add  $t4, $t4, $a0      # t4 =  4(j-1) + base address 
    lw   $t5, 0($t4)        # t5 array value at j - 1

    sll  $t6, $t2, 2        #t6 = 4j
    add  $t6, $t6, $a0      #t6 = 4j + base address  
    lw   $t7, 0($t6)        #t7 = array value at j
    # if (t5 > t6) swap (arr[j-1] > arr[j])
    ble  $t5, $t7, dontSwap
    sw   $t7, 0($t4)        # array[j-1] = array[j]
    sw   $t5, 0($t6)        # array[j]   = temp

dontSwap:
    addi $t2, $t2, 1        #j++ skip swap
    j    innerLoop

nexti:
    addi $t1, $t1, -1       #i--
    j    outerLoop

finished:
    jr   $ra
printArray: 
move $t9, $a0 #save address in a0 in t9
lw $t0, 0($a1)
li $t1, 0
printJump:

    # $t9 = address of array (int*) 
    # $a1 = address of alen (int*)
    bge  $t1, $t0, printNewline   # if (i >= size) finish line

    sll  $t2, $t1, 2        # offset by i * 4
    add  $t2, $t2, $t9      # new address = base adress + index * 4
    lw   $t3, 0($t2)        # load value at that address into $t3

    # print $t3
    move $a0, $t3 
    li   $v0, 1
    syscall

    # print space
    la   $a0, space
    li   $v0, 4
    syscall

    addi $t1, $t1, 1        #i++
    j    printJump        #jump back up 

printNewline:
    la   $a0, newline
    li   $v0, 4
    syscall
    jr   $ra #jump back

main:
    la $a0, array
    la $a1, alen
    jal printArray

    la $a0, array
    la $a1, alen
    jal bubble

    la $a0, array
    la $a1, alen
    jal printArray

    li $v0, 10
    syscall	
