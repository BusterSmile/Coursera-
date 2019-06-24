 # 字符串查找比较
 .data
 
first:      .asciiz "Please Enter Your String (within 100 characters): "
msg_t:      .asciiz "\r\nSuccess! Location: "
msg_f:      .asciiz "\r\nFail!\r\n"
msg_e:      .asciiz "\r\n"
buf:        .space 100
 
            .text
            .globl main
main:       la $a0, first # ask for input
	    li $v0, 4
	    syscall
 
 
	    la $a0, buf # address of input buffer
            la $a1, 100 # set maximum number of characters to read
            li $v0, 8 # set read string
            syscall
 
input_char:  li $v0, 12 # read character
            syscall
            addi $t7, $0, 63 # '?'
            sub $t6, $t7, $v0
            beq $t6, $0, exit
            add $t0, $0, $0
            la $s1, buf
 
find_loop:  lb $s0, 0($s1)
            sub $t1, $v0, $s0
            beq $t1, $0, success
            addi $t0, $t0, 1
            slt $t3, $t0, $a1
            beq $t3, $0, fail
            addi $s1 $s1, 1
            j find_loop
 
success:    la $a0, msg_t
            li $v0, 4 # print string
            syscall
            addi $a0, $t0, 1
            li $v0, 1 # print integer
            syscall
            la $a0, msg_e
            li $v0, 4
            syscall
            j input_char
 
fail:       la $a0, msg_f
            li $v0, 4
            syscall
            j input_char
 
exit:       li $v0, 10
            syscall
