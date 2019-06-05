.data
str:	.word	0:20
.text
	li	$v0,5
	syscall
	move	$s0,$v0	#s0=n

	move	$t0,$s0
	move	$t1,$0	#t1=i
for_begin1:
	beq	$t0,$t1,for_end1
	
	li	$v0,12
	syscall
	sll	$t2,$t1,2
	sw	$v0,str($t2)	#str[i]=v0
	
	addi	$t1,$t1,1
	j	for_begin1
for_end1:
	nop

	addi	$t0,$s0,-1
	move	$t1,$0	
for_begin2:
	sub	$t3,$t0,$t1
	blez	$t3,for_end2
	
	sll	$t2,$t1,2
	lw	$s1,str($t2)
	sll	$t3,$t0,2
	lw	$s2,str($t3)
	
	bne	$s1,$s2,no
	addi	$t1,$t1,1
	addi	$t0,$t0,-1
	j	for_begin2
	
for_end2:
	j	yes

yes:	li	$v0,1
	li	$a0,1
	syscall
	li	$v0,10
	syscall
no:	li	$v0,1
	li	$a0,0
	syscall
	li	$v0,10
	syscall