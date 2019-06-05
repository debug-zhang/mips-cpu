.data
array:.word 0:6
symbol:.word 0:6
space:.asciiz " "
line:	.asciiz "\n"

.text
	li	$v0,5
	syscall
	move	$s0,$v0	#s0=n
	li	$a1,-1	#a1=index
	jal	Full
	
	li	$v0,10
	syscall

Full:
	addi	$a1,$a1,1
	bne	$a1,$s0,if_1_end
	move	$t2,$zero	#t2=i
	move	$t3,$s0
	for_begin1:
		beq	$t2,$t3,for_end1
		sll	$t4,$t2,2
		lw	$a0,array($t4)
		li	$v0,1
		syscall
		la	$a0,space
		li	$v0,4
		syscall
		addi	$t2,$t2,1
		j	for_begin1
	for_end1:
		la	$a0,line
		li	$v0,4
		syscall
		jr	$ra
if_1_end:	
	move	$t2,$s0	#t2=i
	addi	$t2,$t2,-1
	move	$t3,$zero
for_begin2:
	beq	$t2,-1,for_end2
	
	sll	$t4,$t2,2
	lw	$s1,symbol($t4)	#s1=symbol[i]
	bne	$s1,$zero,if_2_end
	
	sll	$t5,$a1,2
	addi	$s2,$t2,1
	sw	$s2,array($t5)	#array[index]=i+1
	
	addi	$s1,$zero,1
	sw	$s1,symbol($t4)	#symbol[i]=1
	
	addi	$sp,$sp,-20
	sw	$t4,16($sp)
	sw	$t2,12($sp)
	sw	$t1,8($sp)
	sw	$a1,4($sp)
	sw	$ra,0($sp)
	jal	Full
	
	lw	$ra,0($sp)
	lw	$a1,4($sp)
	lw	$t1,8($sp)
	lw	$t2,12($sp)
	lw	$t4,16($sp)
	addi	$sp,$sp,20
	sw	$zero,symbol($t4)
	
if_2_end:
	addi	$t2,$t2,-1
	j	for_begin2
for_end2:
	jr	$ra
	
