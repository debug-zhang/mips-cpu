.data
map:	.space 49
visit:.space 49

.text
li	$v0,5
syscall
move	$s0,$v0	#s0=n
li	$v0,5
syscall
move	$s1,$v0	#s1=m

move	$t0,$zero	#t0=i
move	$t1,$zero	#t1=j
move	$t2,$zero

read:	mult	$t0,$s1
	mflo	$t2
	add	$t2,$t2,$t1
	li	$v0,5
	syscall
	sb	$v0,map($t2)
	
	addi	$t1,$t1,1
	bne	$t1,$s1,read
	
	move	$t1,$zero
	addi	$t0,$t0,1
	bne	$t0,$s0,read

li	$v0,5
syscall
addi	$s2,$v0,-1	#s2=x1
li	$v0,5
syscall
addi	$s3,$v0,-1	#s3=y1
li	$v0,5
syscall
addi	$s4,$v0,-1	#s4=x2
li	$v0,5
syscall
addi	$s5,$v0,-1	#s5=y2

move	$a0,$zero	#a0=x
move	$a1,$zero	#a1=y
move	$v0,$zero	#v0=sum
jal	dfs
	
move	$a0,$a3
li	$v0,1
syscall
li	$v0,10
syscall

dfs:	bne	$a0,$s4,judge
	bne	$a1,$s5,judge
	addi	$a3,$a3,1
	j	return
	
	judge:beq	$a0,-1,return
		beq	$a0,$s0,return
		beq	$a1,-1,return
		beq	$a1,$s1,return
		
		mult	$a0,$s1
		mflo	$t0
		add	$t0,$t0,$a1
		lb	$t1,map($t0)	#t1=map[x][y]
		bne	$t1,$zero,return
		lb	$t2,visit($t0)	#t2=visit[x][y]
		bne	$t2,$zero,return
	
	addi	$t2,$t2,1
	sb	$t2,visit($t0)	#visit[x][y]=1
	
	addi	$sp,$sp,-16
	
	sw	$a0,12($sp)
	sw	$a1,8($sp)
	sw	$t0,4($sp)
	sw	$ra,0($sp)
	addi	$a0,$a0,1
	jal	dfs
	lw	$ra,0($sp)
	lw	$t0,4($sp)
	lw	$a1,8($sp)
	lw	$a0,12($sp)
	
	sw	$a0,12($sp)
	sw	$a1,8($sp)
	sw	$t0,4($sp)
	sw	$ra,0($sp)
	addi	$a0,$a0,-1
	jal	dfs
	lw	$ra,0($sp)
	lw	$t0,4($sp)
	lw	$a1,8($sp)
	lw	$a0,12($sp)
	
	sw	$a0,12($sp)
	sw	$a1,8($sp)
	sw	$t0,4($sp)
	sw	$ra,0($sp)
	addi	$a1,$a1,1
	jal	dfs
	lw	$ra,0($sp)
	lw	$t0,4($sp)
	lw	$a1,8($sp)
	lw	$a0,12($sp)
	
	sw	$a0,12($sp)
	sw	$a1,8($sp)
	sw	$t0,4($sp)
	sw	$ra,0($sp)
	addi	$a1,$a1,-1
	jal	dfs
	lw	$ra,0($sp)
	lw	$t0,4($sp)
	lw	$a1,8($sp)
	lw	$a0,12($sp)
	
	addi	$sp,$sp,16
	
	sb	$zero,visit($t0)	#visit[x][y]=0
		
	return:jr	$ra
	
	
	
	
	
	
	
	
