.data
arr1:	.word	0:64
arr2:	.word	0:64
arr3:	.word	0:64
space:.asciiz " "
line_break:.asciiz "\n"
.text
	li	$v0,5		#scanf("%d",&n)
	syscall
	move	$t0,$v0	#t0=n	
	move	$t1,$v0	#t1=n
	
	move	$s0,$0
	move	$s1,$0
	move	$s2,$0	
read1:mult	$s0,$t1
	mflo	$s2
	add	$s2,$s2,$s1
	li	$v0,5
	syscall
	move	$t2,$v0
	sll	$s2,$s2,2
	sw	$t2,arr1($s2)	#t2=a[j][j]
	
	addi	$s1,$s1,1
	bne	$s1,$t1,read1
	
	move	$s1,$0
	addi	$s0,$s0,1
	bne	$s0,$t0,read1
	
	move	$s0,$0
	move	$s1,$0
	move	$s2,$0
read2:mult	$s0,$t1
	mflo	$s2
	add	$s2,$s2,$s1
	li	$v0,5
	syscall
	move	$t2,$v0
	sll	$s2,$s2,2
	sw	$t2,arr2($s2)	#t2=b[j][j]
	
	addi	$s1,$s1,1
	bne	$s1,$t1,read2
	
	move	$s1,$0
	addi	$s0,$s0,1
	bne	$s0,$t0,read2
	
	move	$t2,$t0
	move	$t3,$0		#t3=i
for_begin1:
	beq	$t3,$t2,for_end1
	
	move	$t4,$0		#t4=j
	for_begin2:
		beq	$t4,$t2,for_end2
		
		move	$s3,$0
		move	$t5,$0	#t5=k
		for_begin3:
			beq	$t5,$t2,for_end3
			
			mult	$t3,$t1
			mflo	$s2
			add	$s2,$s2,$t5
			sll	$s2,$s2,2
			lw	$t6,arr1($s2)
			
			mult	$t5,$t1
			mflo	$s2
			add	$s2,$s2,$t4
			sll	$s2,$s2,2
			lw	$t7,arr2($s2)
			
			mult	$t6,$t7
			mflo	$t6
			
			add	$s3,$s3,$t6
			mult	$t3,$t1
			mflo	$s2
			add	$s2,$s2,$t4
			sll	$s2,$s2,2
			sw	$s3,arr3($s2)
			
			addi	$t5,$t5,1	#k++
			j	for_begin3
		for_end3:
			nop
			
		addi	$t4,$t4,1	#j++
		j	for_begin2
	for_end2:
		nop

	addi	$t3,$t3,1		#i++
	j	for_begin1
for_end1:
	nop
	
	move	$s0,$0
	move	$s1,$0
	move	$t2,$0
loop: mult	$s0,$t1
	mflo	$s2
	add	$s2,$s2,$s1
	sll	$s2,$s2,2
	lw	$t2,arr3($s2)
	
	move	$a0,$t2
	li	$v0,1
	syscall
	la	$a0,space
	li	$v0,4
	syscall
	
	addi	$s1,$s1,1
	bne	$s1,$t1,loop
	
	la	$a0,line_break
	li	$v0,4
	syscall
	move	$s1,$0
	addi	$s0,$s0,1
	bne	$s0,$t0,loop
	
	li	$v0,10
	syscall
	
	
