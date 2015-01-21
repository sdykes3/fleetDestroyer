	.cpu arm7tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	gamePrep
	.type	gamePrep, %function
gamePrep:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	mov	r3, #23296
	mov	r5, #67108864
	mov	r1, #5376	@ movhi
	add	r3, r3, #128
	ldr	r0, .L5
	strh	r1, [r5, #0]	@ movhi
	strh	r3, [r5, #12]	@ movhi
	ldr	r3, .L5+4
	mov	lr, pc
	bx	r3
	ldr	r4, .L5+8
	mov	r0, #3
	ldr	r1, .L5+12
	mov	r2, #100663296
	mov	r3, #1216
	mov	lr, pc
	bx	r4
	mov	r2, #100663296
	mov	r0, #3
	ldr	r1, .L5+16
	add	r2, r2, #55296
	mov	r3, #2048
	mov	lr, pc
	bx	r4
	mov	ip, #22784
	add	ip, ip, #136
	mov	r2, #100663296
	strh	ip, [r5, #8]	@ movhi
	mov	r0, #3
	ldr	r1, .L5+20
	add	r2, r2, #32768
	mov	r3, #1024
	mov	lr, pc
	bx	r4
	mov	r2, #100663296
	mov	r0, #3
	ldr	r1, .L5+24
	add	r2, r2, #51200
	mov	r3, #2048
	mov	lr, pc
	bx	r4
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L5+28
	add	r2, r2, #512
	mov	r3, #256
	mov	lr, pc
	bx	r4
	mov	r2, #100663296
	add	r2, r2, #65536
	mov	r3, #16384
	mov	r0, #3
	ldr	r1, .L5+32
	mov	lr, pc
	bx	r4
	ldr	r2, .L5+36
	mov	r3, #0
.L2:
	mov	r1, #512	@ movhi
	strh	r1, [r2, r3]	@ movhi
	add	r3, r3, #8
	cmp	r3, #1024
	bne	.L2
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L6:
	.align	2
.L5:
	.word	starsSmallPal
	.word	loadPalette
	.word	DMANow
	.word	starsSmallTiles
	.word	starsSmallMap
	.word	starsBigTiles
	.word	starsBigMap
	.word	spritesPal
	.word	spritesTiles
	.word	shadowOAM
	.size	gamePrep, .-gamePrep
	.align	2
	.global	bossPrep
	.type	bossPrep, %function
bossPrep:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L8
	mov	r2, #1
	str	r2, [r3, #16]
	mvn	r2, #0
	str	r2, [r3, #12]
	bx	lr
.L9:
	.align	2
.L8:
	.word	theBoss
	.size	bossPrep, .-bossPrep
	.align	2
	.global	hideSprites
	.type	hideSprites, %function
hideSprites:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L13
	mov	r3, #0
.L11:
	mov	r1, #512	@ movhi
	strh	r1, [r2, r3]	@ movhi
	add	r3, r3, #8
	cmp	r3, #1024
	bne	.L11
	bx	lr
.L14:
	.align	2
.L13:
	.word	shadowOAM
	.size	hideSprites, .-hideSprites
	.align	2
	.global	animate
	.type	animate, %function
animate:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L42
	str	r4, [sp, #-4]!
	ldr	r2, [r3, #32]
	cmp	r2, #4
	strne	r2, [r3, #36]
	ldr	r1, .L42+4
	ldr	r2, [r3, #28]
	smull	r0, r1, r2, r1
	mov	r0, r2, asr #31
	rsb	r1, r0, r1, asr #2
	add	r1, r1, r1, asl #2
	cmp	r2, r1, asl #1
	mov	r1, #4
	ldr	ip, .L42
	str	r1, [r3, #32]
	bne	.L17
	ldr	r1, .L42+8
	ldrb	r1, [r1, #0]	@ zero_extendqisi2
	cmp	r1, #0
	bne	.L39
.L17:
	mov	r1, #67108864
	ldr	r1, [r1, #304]
	tst	r1, #32
	moveq	r1, #0
	streq	r1, [r3, #32]
	mov	r1, #67108864
	ldr	r1, [r1, #304]
	tst	r1, #16
	moveq	r1, #0
	streq	r1, [r3, #32]
	mov	r1, #67108864
	ldr	r1, [r1, #304]
	tst	r1, #64
	moveq	r1, #2
	streq	r1, [r3, #32]
	mov	r1, #67108864
	ldr	r1, [r1, #304]
	tst	r1, #128
	ldr	r1, .L42+4
	smull	r4, r1, r2, r1
	rsb	r1, r0, r1, asr #3
	moveq	ip, #1
	add	r1, r1, r1, asl #2
	ldrne	ip, [r3, #32]
	streq	ip, [r3, #32]
	subs	r1, r2, r1, asl #2
	beq	.L23
	cmp	ip, #4
	add	r2, r2, #1
	beq	.L24
.L25:
	str	r2, [r3, #28]
.L31:
	ldr	r3, .L42+12
	ldr	ip, .L42+16
	add	r1, r3, #800
	b	.L35
.L32:
	add	r3, r3, #40
	cmp	r3, r1
	beq	.L40
.L35:
	ldr	r2, [r3, #12]
	cmp	r2, #1
	bne	.L32
	ldr	r2, [r3, #28]
	ldr	r0, [r3, #20]
	add	r2, r2, #1
	cmp	r0, #237
	cmpne	r0, #239
	str	r2, [r3, #28]
	bne	.L33
	smull	r4, r0, ip, r2
	sub	r0, r0, r2, asr #31
	add	r0, r0, r0, asl #1
	subs	r0, r2, r0
	streq	r0, [r3, #12]
	beq	.L32
.L33:
	tst	r2, #7
	bne	.L32
	ldr	r2, [r3, #32]
	cmp	r2, #0
	subne	r2, r2, #1
	streq	r2, [r3, #12]
	strne	r2, [r3, #32]
	add	r3, r3, #40
	cmp	r3, r1
	bne	.L35
.L40:
	ldmfd	sp!, {r4}
	bx	lr
.L23:
	cmp	ip, #4
	ldr	r2, .L42
	beq	.L41
	ldr	r1, [r2, #40]
	cmp	r1, #2
	moveq	r1, #1
	addne	r1, r1, #1
	streq	r1, [r2, #40]
	strne	r1, [r2, #40]
	mov	r2, #1
	b	.L25
.L39:
	ldr	r1, [ip, #48]
	add	r1, r1, #1
	cmp	r1, #5
	str	r1, [ip, #48]
	movgt	r1, #3
	strgt	r1, [ip, #48]
	b	.L17
.L41:
	ldr	r0, [r2, #40]
	cmp	r0, #1
	movne	r1, #1
	str	r1, [r2, #40]
	mov	r2, #1
.L24:
	str	r2, [r3, #28]
	mov	r2, #0
	str	r2, [r3, #32]
	b	.L31
.L43:
	.align	2
.L42:
	.word	player
	.word	1717986919
	.word	.LANCHOR0
	.word	explosions
	.word	1431655766
	.size	animate, .-animate
	.align	2
	.global	updateOAM
	.type	updateOAM, %function
updateOAM:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L86
	ldr	r2, .L86+4
	stmfd	sp!, {r4, r5, r6, r7, r8}
	ldr	ip, [r3, #4]
	add	r6, r3, #36
	ldmia	r6, {r6, r7}	@ phole ldm
	ldr	r0, [r3, #48]
	ldr	r5, [r2, #16]
	ldr	r1, .L86+8
	mov	ip, ip, asl #23
	add	r6, r6, r7, asl #5
	mov	r0, r0, asl #12
	orr	r0, r0, r6, asl #2
	cmp	r5, #1
	ldrb	r4, [r3, #0]	@ zero_extendqisi2
	mvn	ip, ip, lsr #6
	mvn	ip, ip, lsr #17
	strh	r0, [r1, #164]	@ movhi
	movne	r0, #512	@ movhi
	strh	r4, [r1, #160]	@ movhi
	strh	ip, [r1, #162]	@ movhi
	strneh	r0, [r1, #168]	@ movhi
	beq	.L77
.L46:
	ldr	r4, [r3, #24]
	cmp	r4, #0
	ble	.L47
	mov	r3, #0
	ldr	r0, .L86+12
	mov	r2, r3
.L50:
	ldr	ip, [r0, #4]!
	cmp	ip, #1
	addeq	ip, r1, r3
	biceq	r5, r3, #65024
	addne	ip, r1, r3
	moveq	r6, #0	@ movhi
	streqh	r5, [ip, #178]	@ movhi
	movne	r6, #512	@ movhi
	moveq	r5, #205	@ movhi
	add	r2, r2, #1
	streqh	r6, [ip, #176]	@ movhi
	streqh	r5, [ip, #180]	@ movhi
	strneh	r6, [ip, #176]	@ movhi
	cmp	r4, r2
	add	r3, r3, #8
	bgt	.L50
.L47:
	ldr	r3, .L86+16
	mov	r2, #0
	b	.L57
.L80:
	ldr	r0, [r3, #-12]
	cmp	r0, #1
	movne	ip, #512	@ movhi
	strneh	ip, [r1, r2]	@ movhi
	beq	.L78
.L54:
	add	r2, r2, #8
	cmp	r2, #160
	add	r3, r3, #40
	beq	.L79
.L57:
	ldrb	r0, [r3, #12]	@ zero_extendqisi2
	cmp	r0, #0
	bne	.L80
	ldr	r0, [r3, #-12]
	cmp	r0, #1
	beq	.L81
	add	r0, r1, r2
	add	r2, r2, #8
	add	r0, r0, #296
	mov	r5, #512	@ movhi
	cmp	r2, #160
	strh	r5, [r0, #0]	@ movhi
	add	r3, r3, #40
	bne	.L57
.L79:
	ldr	r2, .L86+20
	mov	r3, #0
.L60:
	ldr	r0, [r2, #0]
	cmp	r0, #1
	beq	.L82
	add	r0, r1, r3
	add	r0, r0, #456
	mov	ip, #512	@ movhi
	strh	ip, [r0, #0]	@ movhi
.L59:
	add	r3, r3, #8
	cmp	r3, #40
	add	r2, r2, #24
	bne	.L60
	ldr	r2, .L86+24
	mov	r3, #0
	b	.L63
.L61:
	add	r0, r1, r3
	add	r3, r3, #8
	add	r0, r0, #496
	mov	r5, #512	@ movhi
	cmp	r3, #80
	strh	r5, [r0, #0]	@ movhi
	add	r2, r2, #24
	beq	.L83
.L63:
	ldr	r0, [r2, #0]
	cmp	r0, #1
	bne	.L61
	ldr	r4, [r2, #-8]
	add	ip, r1, r3
	ldrb	r5, [r2, #-12]	@ zero_extendqisi2
	add	r0, ip, #496
	bic	r4, r4, #65024
	add	r3, r3, #8
	add	ip, ip, #500
	strh	r5, [r0, #0]	@ movhi
	strh	r4, [r0, #2]	@ movhi
	cmp	r3, #80
	mov	r0, #175	@ movhi
	strh	r0, [ip, #0]	@ movhi
	add	r2, r2, #24
	bne	.L63
.L83:
	mov	r4, #4544
	ldr	r2, .L86+28
	mov	r3, #0
	add	r4, r4, #12
	b	.L66
.L64:
	add	r0, r1, r3
	add	r3, r3, #8
	add	r0, r0, #576
	mov	r6, #512	@ movhi
	cmp	r3, #64
	strh	r6, [r0, #0]	@ movhi
	add	r2, r2, #20
	beq	.L84
.L66:
	ldr	r0, [r2, #0]
	cmp	r0, #1
	bne	.L64
	ldr	r5, [r2, #-8]
	mov	r5, r5, asl #23
	add	ip, r1, r3
	ldrb	r6, [r2, #-12]	@ zero_extendqisi2
	mov	r5, r5, lsr #23
	add	r3, r3, #8
	add	r0, ip, #576
	orr	r5, r5, #16384
	add	ip, ip, #580
	cmp	r3, #64
	strh	r6, [r0, #0]	@ movhi
	strh	r5, [r0, #2]	@ movhi
	strh	r4, [ip, #0]	@ movhi
	add	r2, r2, #20
	bne	.L66
.L84:
	ldr	r3, .L86+32
	mov	r2, #0
	b	.L69
.L67:
	add	r0, r1, r2
	add	r2, r2, #8
	add	r0, r0, #640
	mov	r5, #512	@ movhi
	cmp	r2, #64
	strh	r5, [r0, #0]	@ movhi
	add	r3, r3, #64
	beq	.L85
.L69:
	ldr	r0, [r3, #0]
	cmp	r0, #1
	bne	.L67
	ldr	r4, [r3, #-12]
	ldr	r6, [r3, #28]
	add	ip, r1, r2
	ldrb	r5, [r3, #-16]	@ zero_extendqisi2
	mov	r4, r4, asl #23
	add	r0, ip, #640
	orr	r4, r6, r4, lsr #23
	strh	r5, [r0, #0]	@ movhi
	strh	r4, [r0, #2]	@ movhi
	add	r2, r2, #8
	ldrh	r0, [r3, #24]
	add	ip, ip, #644
	cmp	r2, #64
	strh	r0, [ip, #0]	@ movhi
	add	r3, r3, #64
	bne	.L69
.L85:
	ldmfd	sp!, {r4, r5, r6, r7, r8}
	bx	lr
.L78:
	ldr	ip, [r3, #8]
	cmn	ip, #1
	addne	ip, ip, #130
	ldreq	ip, [r3, #-4]
	ldrb	r7, [r3, #-24]	@ zero_extendqisi2
	ldr	r5, [r3, #-8]
	ldrb	r6, [r3, #-20]	@ zero_extendqisi2
	ldr	r4, [r3, #0]
	movne	ip, ip, asl #2
	add	r0, r1, r2
	orr	r5, r7, r5
	orr	r4, r6, r4
	orreq	ip, ip, #4096
	orrne	ip, ip, #4096
	strh	r5, [r1, r2]	@ movhi
	strh	r4, [r0, #2]	@ movhi
	streqh	ip, [r0, #4]	@ movhi
	strneh	ip, [r0, #4]	@ movhi
	b	.L54
.L81:
	ldr	r4, [r3, #8]
	ldrb	r8, [r3, #-24]	@ zero_extendqisi2
	ldr	r6, [r3, #-8]
	ldrb	r7, [r3, #-20]	@ zero_extendqisi2
	ldr	r5, [r3, #0]
	add	r0, r1, r2
	cmn	r4, #1
	add	ip, r0, #296
	orr	r6, r8, r6
	orr	r5, r7, r5
	addne	r4, r4, #130
	strh	r6, [ip, #0]	@ movhi
	strh	r5, [ip, #2]	@ movhi
	ldreq	ip, [r3, #-4]
	movne	r4, r4, asl #2
	addeq	r0, r0, #300
	orreq	ip, ip, #4096
	addne	r0, r0, #300
	orrne	r4, r4, #4096
	streqh	ip, [r0, #0]	@ movhi
	strneh	r4, [r0, #0]	@ movhi
	b	.L54
.L82:
	ldr	r4, [r2, #-8]
	add	ip, r1, r3
	ldrb	r5, [r2, #-12]	@ zero_extendqisi2
	add	r0, ip, #456
	bic	r4, r4, #65024
	add	ip, ip, #460
	mov	r6, #173	@ movhi
	strh	r5, [r0, #0]	@ movhi
	strh	r4, [r0, #2]	@ movhi
	strh	r6, [ip, #0]	@ movhi
	b	.L59
.L77:
	ldr	r5, [r2, #4]
	ldr	r0, [r2, #44]
	ldr	r4, [r2, #40]
	ldrb	ip, [r2, #0]	@ zero_extendqisi2
	mov	r2, r5, asl #23
	orr	r0, r0, r2, lsr #23
	orr	r2, r4, #8192
	strh	ip, [r1, #168]	@ movhi
	strh	r0, [r1, #170]	@ movhi
	strh	r2, [r1, #172]	@ movhi
	b	.L46
.L87:
	.align	2
.L86:
	.word	player
	.word	theBoss
	.word	shadowOAM
	.word	health-4
	.word	explosions+24
	.word	bullets+12
	.word	bossBullets+12
	.word	healthPacks+12
	.word	asteroids+16
	.size	updateOAM, .-updateOAM
	.align	2
	.global	cheat
	.type	cheat, %function
cheat:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r4, .L91
	ldrb	ip, [r4, #0]	@ zero_extendqisi2
	mov	r1, #22016
	eor	ip, ip, #1
	mov	r2, #44032
	add	r2, r2, #68
	mov	r3, #0
	strb	ip, [r4, #0]
	ldr	r0, .L91+4
	add	r1, r1, #66
	ldr	ip, .L91+8
	mov	lr, pc
	bx	ip
	ldrb	r3, [r4, #0]	@ zero_extendqisi2
	cmp	r3, #0
	ldreq	r2, .L91+12
	ldrne	r3, .L91+12
	movne	r2, #3
	streq	r3, [r2, #48]
	strne	r2, [r3, #48]
	ldmfd	sp!, {r4, lr}
	bx	lr
.L92:
	.align	2
.L91:
	.word	.LANCHOR0
	.word	Powerup6
	.word	playSoundB
	.word	player
	.size	cheat, .-cheat
	.align	2
	.global	shoot
	.type	shoot, %function
shoot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	ldr	r5, .L99
	mov	r4, #0
	mov	r2, r5
.L96:
	ldr	r3, [r2, #12]
	cmp	r3, #0
	beq	.L98
	add	r4, r4, #1
	cmp	r4, #5
	add	r2, r2, #24
	bne	.L96
.L93:
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L98:
	mov	r1, #19200
	mov	r2, #44032
	ldr	r0, .L99+4
	add	r1, r1, #204
	add	r2, r2, #68
	ldr	ip, .L99+8
	mov	lr, pc
	bx	ip
	ldr	r3, .L99+12
	ldmia	r3, {r1, r2}	@ phole ldm
	add	r4, r4, r4, asl #1
	add	r3, r5, r4, asl #3
	add	r1, r1, #11
	add	r2, r2, #30
	mov	r0, #1
	str	r0, [r3, #12]
	str	r1, [r5, r4, asl #3]
	str	r2, [r3, #4]
	b	.L93
.L100:
	.align	2
.L99:
	.word	bullets
	.word	playerShot
	.word	playSoundB
	.word	player
	.size	shoot, .-shoot
	.align	2
	.global	bossShoot
	.type	bossShoot, %function
bossShoot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	str	r4, [sp, #-4]!
	ldr	r0, .L107
	mov	r3, #0
	mov	r2, r0
.L104:
	ldr	r1, [r2, #12]
	cmp	r1, #0
	beq	.L106
	add	r3, r3, #1
	cmp	r3, #10
	add	r2, r2, #24
	bne	.L104
.L101:
	ldmfd	sp!, {r4}
	bx	lr
.L106:
	ldr	r2, .L107+4
	ldr	ip, [r2, #0]
	add	r3, r3, r3, asl #1
	ldr	r1, [r2, #4]
	add	ip, ip, #11
	add	r2, r0, r3, asl #3
	mov	r4, #1
	str	r4, [r2, #12]
	str	ip, [r0, r3, asl #3]
	str	r1, [r2, #4]
	b	.L101
.L108:
	.align	2
.L107:
	.word	bossBullets
	.word	theBoss
	.size	bossShoot, .-bossShoot
	.align	2
	.global	bulletExplode
	.type	bulletExplode, %function
bulletExplode:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6}
	ldr	r3, .L115
	mov	r2, #0
	mov	ip, r3
.L112:
	ldr	r4, [ip, #12]
	cmp	r4, #0
	beq	.L114
	add	r2, r2, #1
	cmp	r2, #20
	add	ip, ip, #40
	bne	.L112
.L109:
	ldmfd	sp!, {r4, r5, r6}
	bx	lr
.L114:
	add	r2, r2, r2, asl #2
	add	ip, r3, r2, asl #3
	mvn	r6, #0
	mov	r5, #1
	str	r0, [r3, r2, asl #3]
	mov	r3, #237
	str	r6, [ip, #8]
	str	r5, [ip, #12]
	str	r1, [ip, #4]
	str	r4, [ip, #16]
	str	r4, [ip, #24]
	str	r3, [ip, #20]
	str	r6, [ip, #32]
	strb	r5, [ip, #36]
	b	.L109
.L116:
	.align	2
.L115:
	.word	explosions
	.size	bulletExplode, .-bulletExplode
	.align	2
	.global	asteroidExplode
	.type	asteroidExplode, %function
asteroidExplode:
	@ Function supports interworking.
	@ args = 64, pretend = 8, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
	stmfd	sp!, {r4, r5, r6, r7, r8}
	ldr	r4, .L127
	add	ip, sp, #20
	stmia	ip, {r2, r3}
	ldr	r3, [sp, #56]
	mov	ip, r4
	mov	r2, #0
.L122:
	ldr	r5, [ip, #12]
	cmp	r5, #0
	beq	.L124
	add	r2, r2, #1
	cmp	r2, #20
	add	ip, ip, #40
	bne	.L122
.L117:
	ldmfd	sp!, {r4, r5, r6, r7, r8}
	add	sp, sp, #8
	bx	lr
.L124:
	add	r2, r2, r2, asl #2
	mov	ip, r2, asl #3
	add	r4, r4, ip
	mvn	r7, #0
	str	r7, [r4, #8]
	mov	r7, #49152
	mov	r6, #1
	str	r7, [r4, #24]
	cmp	r3, #2
	mov	r7, #32768
	ldr	r8, .L127
	str	r6, [r4, #12]
	str	r7, [r4, #16]
	strb	r5, [r4, #36]
	bls	.L125
	cmp	r3, #3
	beq	.L126
	mov	r3, #520
	sub	r0, r0, #32
	add	r1, r1, #12
	str	r3, [r4, #20]
	mov	r3, #2
	str	r3, [r4, #32]
	str	r0, [r8, ip]
	str	r1, [r4, #4]
	b	.L117
.L125:
	mov	r3, #520
	add	r3, r3, #2
	sub	r0, r0, #32
	add	r1, r1, #6
	str	r3, [r4, #20]
	str	r6, [r4, #32]
	str	r0, [r8, r2, asl #3]
	str	r1, [r4, #4]
	b	.L117
.L126:
	sub	r0, r0, #30
	add	r1, r1, #4
	mov	r3, #524
	str	r3, [r4, #20]
	str	r5, [r4, #32]
	str	r0, [r8, ip]
	str	r1, [r4, #4]
	b	.L117
.L128:
	.align	2
.L127:
	.word	explosions
	.size	asteroidExplode, .-asteroidExplode
	.align	2
	.global	playerHit
	.type	playerHit, %function
playerHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L136
	stmfd	sp!, {r4, r5, r6, r7}
	mov	ip, #0
	mov	r4, r3
.L133:
	ldr	r5, [r4, #12]
	cmp	r5, #0
	beq	.L135
	add	ip, ip, #1
	cmp	ip, #20
	add	r4, r4, #40
	bne	.L133
.L129:
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr
.L135:
	add	ip, ip, ip, asl #2
	add	r3, r3, ip, asl #3
	mvn	r4, #0
	mov	r7, #1
	cmp	r2, #0
	ldr	r6, .L136
	str	r4, [r3, #8]
	str	r7, [r3, #12]
	beq	.L131
	ldr	r2, .L136+4
	ldr	r2, [r2, #16]
	sub	r2, r2, #16
	add	r1, r2, r1
	mov	r2, #32768
	str	r2, [r3, #16]
	mov	r2, #49152
	sub	r0, r0, #16
	str	r2, [r3, #24]
	mov	r2, #524
	str	r2, [r3, #20]
	str	r5, [r3, #32]
	str	r0, [r6, ip, asl #3]
	str	r1, [r3, #4]
	b	.L129
.L131:
	add	r1, r1, #4
	str	r2, [r3, #16]
	str	r2, [r3, #24]
	mov	r2, #239
	str	r0, [r6, ip, asl #3]
	str	r1, [r3, #4]
	str	r2, [r3, #20]
	str	r4, [r3, #32]
	b	.L129
.L137:
	.align	2
.L136:
	.word	explosions
	.word	player
	.size	playerHit, .-playerHit
	.align	2
	.global	splashPrep
	.type	splashPrep, %function
splashPrep:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	ldr	lr, .L139
	mov	r5, #1024
	mov	ip, #0
	mov	r6, #67108864
	add	r5, r5, #3
	sub	sp, sp, #8
	mov	r1, ip
	strh	ip, [r6, #16]	@ movhi
	strh	r5, [r6, #0]	@ movhi
	strh	ip, [r6, #18]	@ movhi
	mov	r2, ip
	strh	ip, [r6, #24]	@ movhi
	mov	r8, ip	@ movhi
	str	ip, [lr, #4]
	strh	ip, [r6, #26]	@ movhi
	str	ip, [lr, #8]
	str	ip, [lr, #12]
	str	ip, [lr, #16]
	str	ip, [lr, #20]
	str	ip, [lr, #24]
	ldr	ip, .L139+4
	mov	r7, #240
	mov	r6, #75
	mov	r4, #32512
	strb	r1, [lr, #28]
	strb	r1, [lr, #0]
	add	r4, r4, #255
	str	r6, [ip, #0]
	mov	r3, r7
	ldr	ip, .L139+8
	ldr	r0, .L139+12
	str	r7, [sp, #0]
	mov	lr, pc
	bx	ip
	ldr	r5, .L139+16
	mov	r3, r4
	mov	r0, #20
	mov	r1, #77
	ldr	r2, .L139+20
	mov	lr, pc
	bx	r5
	mov	r3, r4
	mov	r0, #125
	mov	r1, #77
	ldr	r2, .L139+24
	mov	lr, pc
	bx	r5
	mov	r0, #140
	mov	r1, #52
	ldr	r2, .L139+28
	mov	r3, r4
	mov	lr, pc
	bx	r5
	add	sp, sp, #8
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L140:
	.align	2
.L139:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.word	drawImage3
	.word	startBitmap
	.word	drawString3
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	splashPrep, .-splashPrep
	.align	2
	.global	howto
	.type	howto, %function
howto:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L158
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	ldr	r3, [r3, #0]
	tst	r3, #4
	beq	.L142
	ldr	r3, .L158+4
	ldr	r3, [r3, #0]
	ands	r3, r3, #4
	beq	.L154
.L142:
	ldr	r1, .L158+8
	ldr	r3, [r1, #32]
	cmp	r3, #4
	strne	r3, [r1, #36]
	ldr	r0, .L158+12
	ldr	r3, [r1, #28]
	smull	r2, r0, r3, r0
	mov	r2, r3, asr #31
	rsb	r2, r2, r0, asr #3
	add	r2, r2, r2, asl #2
	subs	r2, r3, r2, asl #2
	ldr	ip, .L158+8
	beq	.L144
	ldr	r0, .L158+16
	add	r3, r3, #1
.L145:
	ldr	r2, .L158+20
	str	r3, [r1, #28]
	mov	r3, #0
.L150:
	mov	r6, #512	@ movhi
	strh	r6, [r2, r3]	@ movhi
	add	r3, r3, #8
	cmp	r3, #1024
	ldr	ip, .L158+20
	bne	.L150
	add	r3, r1, #36
	ldmia	r3, {r3, r7}	@ phole ldm
	add	r7, r3, r7, asl #5
	ldr	r6, [r0, #4]
	mov	r7, r7, asl #2
	mov	r8, #3	@ movhi
	strh	r8, [ip, #0]	@ movhi
	strh	r7, [ip, #4]	@ movhi
	mov	r8, #128	@ movhi
	mov	r7, #37	@ movhi
	strh	r7, [ip, #8]	@ movhi
	strh	r8, [ip, #12]	@ movhi
	sub	r6, r6, #5
	mov	r7, #48	@ movhi
	mov	r8, #173	@ movhi
	mvn	lr, #32512
	mov	r5, #16384
	mov	r4, #4544
	sub	lr, lr, #230
	strh	r7, [ip, #16]	@ movhi
	strh	r6, [ip, #18]	@ movhi
	strh	r8, [ip, #20]	@ movhi
	add	r5, r5, #33
	add	r4, r4, #12
	mov	r6, #71	@ movhi
	mov	r7, #388	@ movhi
	mov	r8, #108	@ movhi
	mov	r1, ip
	strh	lr, [ip, #2]	@ movhi
	strh	lr, [ip, #10]	@ movhi
	strh	r6, [ip, #24]	@ movhi
	strh	lr, [ip, #26]	@ movhi
	strh	r7, [ip, #28]	@ movhi
	strh	r8, [ip, #32]	@ movhi
	strh	r5, [ip, #34]	@ movhi
	strh	r4, [ip, #36]	@ movhi
	mov	r0, #3
	mov	r2, #117440512
	mov	r3, #512
	ldr	ip, .L158+24
	mov	lr, pc
	bx	ip
	ldr	r3, .L158+28
	mov	lr, pc
	bx	r3
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L144:
	ldr	lr, [ip, #40]
	cmp	lr, #2
	beq	.L155
	ldr	r0, .L158+16
	ldr	r3, [r0, #4]
	add	r3, r3, #10
	cmp	r3, #90
	str	r3, [r0, #4]
	add	lr, lr, #1
	movgt	r3, #60
	strgt	r3, [r0, #4]
	str	lr, [ip, #40]
	movgt	r3, #1
	movle	r3, #1
	b	.L145
.L154:
	ldr	r2, .L158+32
	strb	r3, [r2, #0]
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	b	splashPrep
.L155:
	ldr	r0, .L158+36
	ldr	r3, [r0, #16]
	cmp	r3, #0
	str	r2, [ip, #40]
	bne	.L147
	add	r3, r3, #1
	str	r3, [r0, #16]
	str	lr, [ip, #32]
	ldr	r0, .L158+16
	b	.L145
.L147:
	cmp	r3, #1
	beq	.L156
	cmp	r3, #2
	beq	.L157
	cmp	r3, #3
	movne	r3, #1
	ldrne	r0, .L158+16
	streq	r2, [r0, #16]
	streq	r2, [ip, #32]
	moveq	r3, #1
	ldreq	r0, .L158+16
	b	.L145
.L157:
	mov	r3, #1
	mov	r2, #3
	str	r2, [r0, #16]
	str	r3, [ip, #32]
	ldr	r0, .L158+16
	b	.L145
.L156:
	str	lr, [r0, #16]
	str	r2, [ip, #32]
	ldr	r0, .L158+16
	b	.L145
.L159:
	.align	2
.L158:
	.word	oldButtons
	.word	buttons
	.word	player
	.word	1717986919
	.word	.LANCHOR1
	.word	shadowOAM
	.word	DMANow
	.word	waitForVblank
	.word	gameState
	.word	.LANCHOR0
	.size	howto, .-howto
	.align	2
	.global	howtoPrep
	.type	howtoPrep, %function
howtoPrep:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	mov	r3, #22784
	mov	r2, #67108864
	mov	r1, #5376	@ movhi
	add	r3, r3, #136
	mov	r5, #100663296
	strh	r1, [r2, #0]	@ movhi
	strh	r3, [r2, #8]	@ movhi
	ldr	r0, .L161
	ldr	r3, .L161+4
	mov	lr, pc
	bx	r3
	ldr	r4, .L161+8
	mov	r0, #3
	ldr	r1, .L161+12
	add	r2, r5, #32768
	mov	r3, #3328
	mov	lr, pc
	bx	r4
	mov	r0, #3
	ldr	r1, .L161+16
	add	r2, r5, #51200
	mov	r3, #1024
	mov	lr, pc
	bx	r4
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L161+20
	add	r2, r2, #512
	mov	r3, #256
	mov	lr, pc
	bx	r4
	add	r2, r5, #65536
	mov	r3, #16384
	mov	r0, #3
	ldr	r1, .L161+24
	mov	lr, pc
	bx	r4
	ldr	r3, .L161+28
	mov	r2, #0
	str	r2, [r3, #28]
	str	r2, [r3, #40]
	str	r2, [r3, #32]
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L162:
	.align	2
.L161:
	.word	howtoPal
	.word	loadPalette
	.word	DMANow
	.word	howtoTiles
	.word	howtoMap
	.word	spritesPal
	.word	spritesTiles
	.word	player
	.size	howtoPrep, .-howtoPrep
	.align	2
	.global	pause
	.type	pause, %function
pause:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L168
	stmfd	sp!, {r4, lr}
	ldr	r3, [r3, #0]
	tst	r3, #8
	beq	.L164
	ldr	r2, .L168+4
	ldr	r0, [r2, #0]
	ands	r0, r0, #8
	beq	.L166
.L164:
	tst	r3, #4
	beq	.L163
	ldr	r3, .L168+4
	ldr	r4, [r3, #0]
	ands	r4, r4, #4
	beq	.L167
.L163:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L167:
	mov	r0, r4
	ldr	r3, .L168+8
	mov	lr, pc
	bx	r3
	ldr	r3, .L168+12
	strb	r4, [r3, #0]
	bl	splashPrep
	ldr	r3, .L168+16
	mov	lr, pc
	bx	r3
	mov	r1, #4194304
	add	r1, r1, #36864
	mov	r2, #44032
	ldr	r0, .L168+20
	add	r1, r1, #128
	add	r2, r2, #68
	mov	r3, #1
	ldr	ip, .L168+24
	mov	lr, pc
	bx	ip
	b	.L163
.L166:
	ldr	r3, .L168+8
	mov	lr, pc
	bx	r3
	ldr	r3, .L168+12
	mov	r2, #2
	strb	r2, [r3, #0]
	bl	gamePrep
	ldr	r3, .L168+28
	mov	lr, pc
	bx	r3
	b	.L163
.L169:
	.align	2
.L168:
	.word	oldButtons
	.word	buttons
	.word	fillScreen3
	.word	gameState
	.word	stopSound
	.word	Ballad
	.word	playSoundA
	.word	unpauseSound
	.size	pause, .-pause
	.align	2
	.global	pausePrep
	.type	pausePrep, %function
pausePrep:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	mov	r3, #1024
	mov	r2, #67108864
	add	r3, r3, #3
	mov	r4, #32512
	add	r4, r4, #255
	strh	r3, [r2, #0]	@ movhi
	mov	r0, #0
	ldr	r3, .L171
	mov	lr, pc
	bx	r3
	ldr	r5, .L171+4
	mov	r3, r4
	mov	r0, #120
	mov	r1, #52
	ldr	r2, .L171+8
	mov	lr, pc
	bx	r5
	mov	r0, #140
	mov	r1, #22
	ldr	r2, .L171+12
	mov	r3, r4
	mov	lr, pc
	bx	r5
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L172:
	.align	2
.L171:
	.word	fillScreen3
	.word	drawString3
	.word	.LC3
	.word	.LC4
	.size	pausePrep, .-pausePrep
	.align	2
	.global	win
	.type	win, %function
win:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L176
	stmfd	sp!, {r4, lr}
	ldr	r3, [r3, #0]
	tst	r3, #8
	beq	.L173
	ldr	r3, .L176+4
	ldr	r4, [r3, #0]
	ands	r4, r4, #8
	beq	.L175
.L173:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L175:
	mov	r0, r4
	ldr	r3, .L176+8
	mov	lr, pc
	bx	r3
	ldr	r3, .L176+12
	strb	r4, [r3, #0]
	bl	splashPrep
	ldr	r3, .L176+16
	mov	lr, pc
	bx	r3
	mov	r1, #4194304
	add	r1, r1, #36864
	mov	r2, #44032
	ldr	r0, .L176+20
	add	r1, r1, #128
	add	r2, r2, #68
	mov	r3, #1
	ldr	ip, .L176+24
	mov	lr, pc
	bx	ip
	b	.L173
.L177:
	.align	2
.L176:
	.word	oldButtons
	.word	buttons
	.word	fillScreen3
	.word	gameState
	.word	stopSound
	.word	Ballad
	.word	playSoundA
	.size	win, .-win
	.align	2
	.global	winPrep
	.type	winPrep, %function
winPrep:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	mov	r3, #1024
	mov	r2, #67108864
	add	r3, r3, #3
	mov	r4, #32512
	add	r4, r4, #255
	strh	r3, [r2, #0]	@ movhi
	mov	r0, #0
	ldr	r3, .L179
	mov	lr, pc
	bx	r3
	ldr	r5, .L179+4
	mov	r3, r4
	mov	r0, #70
	mov	r1, #69
	ldr	r2, .L179+8
	mov	lr, pc
	bx	r5
	mov	r0, #140
	mov	r1, #18
	ldr	r2, .L179+12
	mov	r3, r4
	mov	lr, pc
	bx	r5
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L180:
	.align	2
.L179:
	.word	fillScreen3
	.word	drawString3
	.word	.LC5
	.word	.LC6
	.size	winPrep, .-winPrep
	.align	2
	.global	lose
	.type	lose, %function
lose:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L184
	stmfd	sp!, {r4, lr}
	ldr	r3, [r3, #0]
	tst	r3, #8
	beq	.L181
	ldr	r3, .L184+4
	ldr	r4, [r3, #0]
	ands	r4, r4, #8
	beq	.L183
.L181:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L183:
	mov	r0, r4
	ldr	r3, .L184+8
	mov	lr, pc
	bx	r3
	ldr	r3, .L184+12
	strb	r4, [r3, #0]
	bl	splashPrep
	ldr	r3, .L184+16
	mov	lr, pc
	bx	r3
	mov	r1, #4194304
	add	r1, r1, #36864
	mov	r2, #44032
	ldr	r0, .L184+20
	add	r1, r1, #128
	add	r2, r2, #68
	mov	r3, #1
	ldr	ip, .L184+24
	mov	lr, pc
	bx	ip
	b	.L181
.L185:
	.align	2
.L184:
	.word	oldButtons
	.word	buttons
	.word	fillScreen3
	.word	gameState
	.word	stopSound
	.word	Ballad
	.word	playSoundA
	.size	lose, .-lose
	.align	2
	.global	losePrep
	.type	losePrep, %function
losePrep:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	mov	r3, #1024
	mov	r2, #67108864
	add	r3, r3, #3
	mov	r4, #32512
	add	r4, r4, #255
	strh	r3, [r2, #0]	@ movhi
	mov	r0, #0
	ldr	r3, .L187
	mov	lr, pc
	bx	r3
	ldr	r5, .L187+4
	mov	r3, r4
	mov	r0, #70
	mov	r1, #53
	ldr	r2, .L187+8
	mov	lr, pc
	bx	r5
	mov	r0, #140
	mov	r1, #17
	ldr	r2, .L187+12
	mov	r3, r4
	mov	lr, pc
	bx	r5
	ldmfd	sp!, {r3, r4, r5, lr}
	bx	lr
.L188:
	.align	2
.L187:
	.word	fillScreen3
	.word	drawString3
	.word	.LC7
	.word	.LC6
	.size	losePrep, .-losePrep
	.align	2
	.global	setupAsteroidTypes
	.type	setupAsteroidTypes, %function
setupAsteroidTypes:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L190
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	mov	r4, #2
	str	r4, [r3, #32]
	mov	r9, #0
	str	r4, [r3, #96]
	str	r4, [r3, #160]
	str	r4, [r3, #164]
	mov	r4, #392
	str	r9, [r3, #36]
	str	r4, [r3, #168]
	mov	r9, #384
	mov	r4, #16
	mov	r2, #1
	mov	ip, #50
	mov	r0, #300
	mvn	r1, #0
	mov	r7, #32
	mov	r6, #32768
	mov	r5, #3
	str	r9, [r3, #40]
	str	r4, [r3, #212]
	mov	r9, #388
	mov	r4, #396
	str	r2, [r3, #16]
	str	r2, [r3, #80]
	str	r2, [r3, #100]
	str	r2, [r3, #144]
	str	r2, [r3, #208]
	str	r2, [r3, #224]
	str	ip, [r3, #0]
	str	r0, [r3, #4]
	str	r1, [r3, #12]
	str	r7, [r3, #20]
	str	r6, [r3, #44]
	str	ip, [r3, #64]
	str	r0, [r3, #68]
	str	r1, [r3, #76]
	str	r7, [r3, #84]
	str	r9, [r3, #104]
	str	r6, [r3, #108]
	str	ip, [r3, #128]
	str	r0, [r3, #132]
	str	r1, [r3, #140]
	str	r7, [r3, #148]
	str	r6, [r3, #172]
	str	ip, [r3, #192]
	str	r0, [r3, #196]
	str	r1, [r3, #204]
	str	r5, [r3, #228]
	str	r4, [r3, #232]
	mov	r4, #16384
	str	r4, [r3, #236]
	str	r2, [r3, #272]
	mov	r4, #4
	str	r2, [r3, #336]
	mov	r2, #5
	mov	sl, #64
	mov	r8, #49152
	str	r4, [r3, #292]
	str	r2, [r3, #356]
	mov	r4, #512
	mov	r2, #768
	str	ip, [r3, #256]
	str	r0, [r3, #260]
	str	r1, [r3, #268]
	str	sl, [r3, #276]
	str	r5, [r3, #288]
	str	r4, [r3, #296]
	str	r8, [r3, #300]
	str	ip, [r3, #320]
	str	r0, [r3, #324]
	str	r1, [r3, #332]
	str	sl, [r3, #340]
	str	r5, [r3, #352]
	str	r2, [r3, #360]
	str	r8, [r3, #364]
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	bx	lr
.L191:
	.align	2
.L190:
	.word	asteroidType
	.size	setupAsteroidTypes, .-setupAsteroidTypes
	.global	__aeabi_idivmod
	.align	2
	.global	resetAsteroid
	.type	resetAsteroid, %function
resetAsteroid:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, lr}
	ldr	r5, .L193
	mov	r4, r0
	mov	lr, pc
	bx	r5
	ldr	r6, .L193+4
	smull	r2, r6, r0, r6
	sub	r6, r6, r0, asr #31
	add	r6, r6, r6, asl #1
	ldr	r7, .L193+8
	sub	r6, r0, r6, asl #1
	mov	r6, r6, asl #6
	add	ip, r7, r6
	ldmia	ip!, {r0, r1, r2, r3}
	mov	lr, r4
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	add	r6, r7, r6
	ldmia	ip, {r0, r1, r2, r3}
	ldr	r6, [r6, #20]
	stmia	lr, {r0, r1, r2, r3}
	add	r6, r6, r6, lsr #31
	mov	lr, pc
	bx	r5
	mov	r1, r6, asr #1
	ldr	r3, .L193+12
	rsb	r1, r1, #160
	mov	lr, pc
	bx	r3
	str	r1, [r4, #0]
	mov	lr, pc
	bx	r5
	ldr	r3, .L193+16
	smull	r2, r3, r0, r3
	mov	r2, r0, asr #31
	add	r3, r3, r0
	rsb	r3, r2, r3, asr #7
	rsb	r3, r3, r3, asl #4
	sub	r0, r0, r3, asl #4
	add	r0, r0, #223
	mov	r3, #1
	str	r0, [r4, #4]
	str	r3, [r4, #16]
	mov	r0, r4
	ldmfd	sp!, {r3, r4, r5, r6, r7, lr}
	bx	lr
.L194:
	.align	2
.L193:
	.word	rand
	.word	715827883
	.word	asteroidType
	.word	__aeabi_idivmod
	.word	-2004318071
	.size	resetAsteroid, .-resetAsteroid
	.align	2
	.global	updateDebris
	.type	updateDebris, %function
updateDebris:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 96
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #100
	add	r0, sp, #32
	ldr	r4, .L249
	ldr	r6, .L249+4
	mov	r5, #0
	str	r0, [sp, #12]
	b	.L216
.L196:
	add	r5, r5, #1
	cmp	r5, #8
	add	r4, r4, #64
	beq	.L242
.L216:
	ldr	r3, [r4, #4]
	cmp	r3, #1
	bne	.L196
	ldr	r3, [r4, #8]
	ldr	r0, [r4, #-8]
	ldr	ip, [r4, #0]
	ldr	r2, [r4, #-12]
	rsb	r1, r3, #0
	add	r0, ip, r0
	cmp	r2, r1
	str	r0, [r4, #-8]
	ble	.L197
	cmp	r2, #159
	bgt	.L197
	cmp	r0, r1
	bgt	.L198
.L197:
	ldr	r1, .L249+8
	ldrb	r3, [r1, #0]	@ zero_extendqisi2
	cmp	r3, #3
	mov	r3, #0
	str	r3, [r4, #4]
	beq	.L239
	add	r0, sp, #32
	bl	resetAsteroid
	ldr	r7, [sp, #12]
	ldr	r8, .L249+12
	ldmia	r7!, {r0, r1, r2, r3}
	add	ip, r8, r5, asl #6
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r7!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r7!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r7, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
.L239:
	ldr	r2, [r4, #-12]
	ldr	r3, [r4, #8]
.L198:
	add	r9, r3, #3
	cmp	r3, #0
	mov	r0, r9
	ldr	ip, [r6, #0]
	movge	r0, r3
	mov	r0, r0, asr #2
	add	r7, ip, #4
	add	r1, r0, r2
	cmp	r7, r1
	str	r9, [sp, #16]
	blt	.L200
	rsb	sl, r0, #0
	add	r8, r3, r2
	add	fp, ip, #3
	add	r9, r8, sl
	cmp	fp, r9
	bge	.L200
	ldr	fp, .L249+4
	ldr	r9, [r4, #-8]
	ldr	fp, [fp, #4]
	str	r9, [sp, #24]
	str	fp, [sp, #20]
	add	r9, r0, r9
	add	fp, fp, #12
	cmp	fp, r9
	str	fp, [sp, #28]
	bge	.L201
.L200:
	ldr	fp, [r6, #20]
	add	fp, ip, fp
	sub	r8, fp, #3
	cmp	r1, r8
	str	fp, [sp, #4]
	bge	.L202
	ldr	sl, [sp, #16]
	cmp	r3, #0
	movge	sl, r3
	mov	sl, sl, asr #2
	rsb	sl, sl, #0
	add	r8, r3, r2
	sub	r9, fp, #4
	add	fp, r8, sl
	cmp	r9, fp
	bgt	.L202
	ldr	fp, [r4, #-8]
	ldr	r9, [r6, #4]
	str	fp, [sp, #24]
	ldr	fp, [r6, #16]
	str	r9, [sp, #20]
	add	r9, r9, fp
	str	r9, [sp, #8]
	ldr	fp, [sp, #8]
	ldr	r9, [sp, #24]
	sub	fp, fp, #7
	add	r9, r0, r9
	cmp	fp, r9
	str	r9, [sp, #28]
	str	fp, [sp, #8]
	bgt	.L201
	ldr	r9, [sp, #20]
	ldr	fp, [sp, #28]
	add	r9, r9, #12
	cmp	fp, r9
	str	r9, [sp, #8]
	ble	.L201
.L202:
	cmp	r7, r1
	blt	.L204
	ldr	sl, [sp, #16]
	cmp	r3, #0
	movge	sl, r3
	mov	sl, sl, asr #2
	add	r8, r3, r2
	rsb	sl, sl, #0
	add	fp, ip, #3
	add	r9, sl, r8
	cmp	fp, r9
	str	r8, [sp, #8]
	blt	.L243
.L205:
	ldr	sl, [sp, #8]
	add	fp, sl, r0
	cmp	r7, fp
	bge	.L211
	ldr	r2, [r6, #20]
	add	r2, ip, r2
	sub	r2, r2, #4
	cmp	fp, r2
	blt	.L244
.L211:
	cmp	r7, r1
	bge	.L196
	ldr	r2, [r6, #20]
	add	ip, ip, r2
	sub	ip, ip, #4
	cmp	r1, ip
	bge	.L196
	ldr	r1, [r4, #-8]
	ldr	r2, [r6, #4]
	ldr	ip, [r6, #16]
	add	r3, r3, r1
	add	ip, r2, ip
	add	r3, r3, r0
	sub	ip, ip, #8
	cmp	r3, ip
	bge	.L196
	add	r1, r0, r1
	add	r2, r2, #12
	cmp	r1, r2
	ble	.L196
.L206:
	ldr	fp, .L249+16
	mov	lr, pc
	bx	fp
	ldr	ip, .L249+20
	smull	r1, r3, ip, r0
	sub	r3, r3, r0, asr #31
	add	r3, r3, r3, asl #1
	subs	r3, r0, r3
	beq	.L245
	cmp	r3, #1
	beq	.L246
	mov	r1, #130048
	mov	r2, #44032
	ldr	r0, .L249+24
	add	r1, r1, #128
	add	r2, r2, #68
	mov	r3, #0
	ldr	sl, .L249+28
	mov	lr, pc
	bx	sl
.L213:
	ldr	fp, .L249+32
	ldmia	r6, {r0, r1}	@ phole ldm
	mov	r2, #1
	bl	playerHit
	ldrb	r3, [fp, #0]	@ zero_extendqisi2
	cmp	r3, #0
	ldreq	r3, [r6, #24]
	ldr	ip, .L249+8
	subeq	r3, r3, #1
	streq	r3, [r6, #24]
	ldrb	r3, [ip, #0]	@ zero_extendqisi2
	cmp	r3, #3
	mov	r3, #0
	str	r3, [r4, #4]
	beq	.L196
	add	r0, sp, #32
	bl	resetAsteroid
	ldr	r7, [sp, #12]
	ldr	r8, .L249+12
	ldmia	r7!, {r0, r1, r2, r3}
	add	ip, r8, r5, asl #6
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r7!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r7!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	add	r5, r5, #1
	ldmia	r7, {r0, r1, r2, r3}
	cmp	r5, #8
	stmia	ip, {r0, r1, r2, r3}
	add	r4, r4, #64
	bne	.L216
.L242:
	ldr	r4, .L249+36
	ldr	r6, .L249+4
	mov	r5, #1
	ldr	r7, .L249+32
	b	.L233
.L217:
	add	r5, r5, #1
	cmp	r5, #9
	add	r4, r4, #20
	beq	.L247
.L233:
	ldr	r3, [r4, #-20]
	cmp	r3, #1
	bne	.L217
	ldr	r3, [r4, #-32]
	ldr	r2, [r4, #-16]
	sub	r9, r4, #24
	ldmda	r9, {r1, r9}
	add	r1, r9, r1
	add	r0, r2, r3
	cmp	r0, #0
	str	r1, [r4, #-28]
	ble	.L218
	cmp	r3, #159
	bgt	.L218
	add	r0, r1, r2
	cmp	r0, #0
	ble	.L218
.L219:
	ldr	r0, [r6, #24]
	cmp	r0, #20
	bgt	.L217
	ldr	fp, .L249+4
	ldr	r0, [fp, #0]
	cmp	r0, r3
	blt	.L221
	add	ip, r3, r2
	add	sl, r0, #3
	sub	r8, ip, #4
	cmp	sl, r8
	mov	sl, r2
	bge	.L221
	ldr	r8, [fp, #4]
	str	r8, [sp, #16]
	ldr	r9, [sp, #16]
	sub	r8, r1, #4
	cmp	r9, r8
	blt	.L221
.L222:
	ldr	fp, [sp, #16]
	add	r8, r2, r1
	add	r9, fp, #7
	sub	r8, r8, #4
	cmp	r9, r8
	blt	.L227
	cmp	r0, r3
	movge	r8, ip
	bge	.L226
	ldr	r8, [r6, #20]
	add	ip, r3, #4
	str	ip, [sp, #28]
	add	r8, r0, r8
.L225:
	ldr	r9, [sp, #28]
	sub	r8, r8, #4
	cmp	r9, r8
	blt	.L229
	ldr	sl, [r4, #-16]
	add	r8, sl, r3
.L226:
	cmp	r0, r8
	bge	.L232
	ldr	r2, [r6, #20]
	add	r2, r0, r2
	add	r8, r8, #4
	sub	r2, r2, #4
	cmp	r8, r2
	bge	.L232
	ldr	r2, [r6, #4]
	ldr	ip, [r6, #16]
	add	r8, r1, #4
	add	ip, r2, ip
	add	r8, r8, sl
	sub	ip, ip, #8
	cmp	r8, ip
	bge	.L232
	add	r2, r2, #4
	cmp	r1, r2
	bgt	.L227
.L232:
	cmp	r0, r3
	bge	.L217
	ldr	r2, [r6, #20]
	add	r0, r0, r2
	add	r3, r3, #4
	sub	r0, r0, #4
	cmp	r3, r0
	bge	.L217
	ldr	r3, [r6, #4]
	ldr	r2, [r6, #16]
	add	r0, r1, #4
	add	r2, r3, r2
	add	sl, r0, sl
	sub	r2, r2, #8
	cmp	sl, r2
	bge	.L217
	add	r3, r3, #4
	cmp	r1, r3
	ble	.L217
.L227:
	mov	r1, #20224
	mov	r2, #44032
	ldr	r0, .L249+40
	add	r1, r1, #86
	add	r2, r2, #68
	mov	r3, #0
	ldr	sl, .L249+28
	mov	lr, pc
	bx	sl
	ldr	r2, [r7, #12]
	ldr	r3, [r6, #24]
	add	r2, r2, #1
	ldr	fp, .L249+44
	cmp	r2, #9
	mov	ip, #1
	add	r1, r3, #1
	ldrle	r0, .L249+48
	str	ip, [fp, r3, asl #2]
	mov	r3, #0
	str	r3, [r4, #-20]
	addle	r3, r5, r5, asl #2
	addle	r3, r0, r3, asl #2
	add	r5, r5, #1
	strle	ip, [r3, #12]
	cmp	r5, #9
	str	r1, [r6, #24]
	str	r2, [r7, #12]
	add	r4, r4, #20
	bne	.L233
.L247:
	add	sp, sp, #100
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L243:
	ldr	fp, [r4, #-8]
	ldr	r9, [r6, #4]
	str	fp, [sp, #24]
	ldr	fp, [r6, #16]
	str	r9, [sp, #20]
	add	r9, r9, fp
	ldr	fp, [sp, #24]
	sub	r9, r9, #7
	add	fp, r0, fp
	cmp	r9, fp
	str	r9, [sp, #16]
	str	fp, [sp, #28]
	ble	.L205
.L201:
	ldr	r9, [sp, #24]
	ldr	fp, [sp, #20]
	add	sl, r9, sl
	add	sl, sl, r3
	add	r9, fp, #11
	cmp	r9, sl
	blt	.L206
	cmp	r7, r1
	strge	r8, [sp, #8]
	bge	.L205
	ldr	fp, [r6, #20]
	add	fp, ip, fp
	str	fp, [sp, #4]
.L204:
	ldr	r8, [sp, #4]
	sub	fp, r8, #4
	cmp	r1, fp
	bge	.L240
	ldr	r8, [r6, #4]
	ldr	r9, [r6, #16]
	ldr	fp, [r4, #-8]
	add	r9, r8, r9
	sub	r9, r9, #8
	add	sl, r0, fp
	cmp	sl, r9
	str	r9, [sp, #16]
	bge	.L209
	add	r9, r8, #12
	cmp	sl, r9
	bgt	.L206
.L209:
	add	fp, r3, fp
	ldr	r9, [sp, #16]
	add	fp, fp, r0
	cmp	r9, fp
	ble	.L240
	add	r8, r8, #12
	cmp	fp, r8
	bgt	.L206
.L240:
	add	r2, r3, r2
	str	r2, [sp, #8]
	b	.L205
.L221:
	ldr	r8, [r6, #20]
	add	r8, r0, r8
	add	sl, r3, #4
	sub	ip, r8, #3
	cmp	ip, sl
	str	sl, [sp, #28]
	ble	.L223
	add	ip, r2, r3
	cmp	r8, ip
	mov	sl, r2
	bgt	.L223
	ldr	fp, [r6, #4]
	ldr	r9, [r6, #16]
	add	r9, fp, r9
	str	fp, [sp, #16]
	str	r9, [sp, #20]
	sub	fp, r9, #7
	add	r9, r1, #4
	cmp	fp, r9
	bgt	.L222
	ldr	fp, [sp, #16]
	sub	r9, r1, #4
	cmp	fp, r9
	bge	.L222
.L223:
	cmp	r0, r3
	blt	.L225
	add	ip, r2, r3
	add	sl, r0, #3
	sub	r8, ip, #4
	cmp	sl, r8
	mov	sl, r2
	mov	r8, ip
	bge	.L226
	ldr	fp, [r6, #4]
	ldr	r9, [r6, #16]
	add	r9, fp, r9
	str	fp, [sp, #16]
	sub	fp, r9, #7
	add	r9, r1, #4
	cmp	fp, r9
	ble	.L226
	b	.L222
.L218:
	ldr	r0, [r7, #12]
	add	r0, r0, #1
	cmp	r0, #7
	mov	ip, #0
	movle	sl, #1
	str	ip, [r4, #-20]
	str	r0, [r7, #12]
	strle	sl, [r4, #0]
	b	.L219
.L244:
	ldr	r8, [r4, #-8]
	ldr	r2, [r6, #4]
	ldr	sl, [r6, #16]
	add	r9, r3, r8
	add	sl, r2, sl
	add	r9, r9, r0
	sub	sl, sl, #8
	cmp	r9, sl
	bge	.L211
	add	r8, r0, r8
	add	r2, r2, #12
	cmp	r8, r2
	bgt	.L206
	b	.L211
.L245:
	mov	r1, #124928
	mov	r2, #44032
	ldr	r0, .L249+52
	add	r1, r1, #640
	add	r2, r2, #68
	ldr	r8, .L249+28
	mov	lr, pc
	bx	r8
	b	.L213
.L229:
	ldr	ip, [r6, #4]
	ldr	r8, [r6, #16]
	add	r8, ip, r8
	sub	r8, r8, #8
	add	sl, r1, #4
	cmp	sl, r8
	blt	.L248
.L230:
	mov	sl, r2
	add	r2, r2, r1
	add	r9, r2, #4
	cmp	r8, r9
	ble	.L241
	add	ip, ip, #4
	cmp	r2, ip
	bgt	.L227
.L241:
	add	r8, sl, r3
	b	.L226
.L246:
	mov	r1, #123904
	mov	r2, #44032
	ldr	r0, .L249+56
	add	r1, r1, #512
	add	r2, r2, #68
	mov	r3, #0
	ldr	r9, .L249+28
	mov	lr, pc
	bx	r9
	b	.L213
.L248:
	add	sl, ip, #4
	cmp	r1, sl
	bgt	.L227
	b	.L230
.L250:
	.align	2
.L249:
	.word	asteroids+12
	.word	player
	.word	gameState
	.word	asteroids
	.word	rand
	.word	1431655766
	.word	expl03
	.word	playSoundB
	.word	.LANCHOR0
	.word	healthPacks+32
	.word	Powerup8
	.word	health
	.word	healthPacks
	.word	expl01
	.word	expl02
	.size	updateDebris, .-updateDebris
	.align	2
	.global	updateBullets
	.type	updateBullets, %function
updateBullets:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 80
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	ldr	r4, .L277
	sub	sp, sp, #140
	sub	r5, r4, #12
	ldr	fp, .L277+4
	add	r8, r5, #132
	add	sl, sp, #72
.L260:
	ldr	r3, [r5, #12]
	cmp	r3, #1
	beq	.L273
.L252:
	add	r4, r4, #24
	cmp	r4, r8
	add	r5, r5, #24
	bne	.L260
	ldr	r4, .L277+8
	ldr	r7, .L277+12
	ldr	fp, .L277+16
	add	r5, r4, #240
	mov	r6, #0
	mov	r8, r7
	b	.L265
.L261:
	add	r4, r4, #24
	cmp	r4, r5
	beq	.L274
.L265:
	ldr	r3, [r4, #0]
	cmp	r3, #1
	bne	.L261
	ldr	r2, [r4, #-12]
	sub	sl, r4, #8
	ldmia	sl, {r3, sl}
	sub	r3, r3, sl
	add	r1, r2, #3
	cmp	r1, #162
	str	r3, [r4, #-8]
	bhi	.L264
	cmn	r3, #7
	blt	.L264
	cmp	r3, #239
	ble	.L263
.L264:
	str	r6, [r4, #0]
.L276:
	add	r4, r4, #24
	cmp	r4, r5
	bne	.L265
.L274:
	ldr	r3, .L277+20
	mov	ip, #0
	add	r1, r3, #800
	b	.L268
.L266:
	add	r3, r3, #40
	cmp	r3, r1
	beq	.L275
.L268:
	ldr	r2, [r3, #0]
	cmp	r2, #1
	bne	.L266
	ldr	r0, [r3, #-12]
	sub	r4, r3, #4
	ldmda	r4, {r2, r4}
	add	r2, r4, r2
	add	r0, r0, #3
	cmp	r0, #162
	str	r2, [r3, #-8]
	bhi	.L267
	cmn	r2, #7
	blt	.L267
	cmp	r2, #239
	ble	.L266
.L267:
	str	ip, [r3, #0]
	add	r3, r3, #40
	cmp	r3, r1
	bne	.L268
.L275:
	add	sp, sp, #140
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L273:
	sub	r0, r4, #12
	ldmia	r0, {r0, r3}	@ phole ldm
	ldr	r1, [r5, #8]
	sub	r2, r0, #1
	add	r3, r1, r3
	cmp	r2, #158
	str	r3, [r4, #-8]
	bhi	.L253
	cmp	r3, #0
	ble	.L253
	cmp	r3, #239
	bgt	.L253
	mov	r7, #0
	ldr	r6, .L277+4
	mov	r9, r5
	b	.L259
.L255:
	add	r7, r7, #1
	cmp	r7, #8
	add	r6, r6, #64
	beq	.L258
	ldr	r0, [r4, #-12]
.L259:
	ldr	r3, [r6, #16]
	cmp	r3, #1
	bne	.L255
	ldr	r3, [r6, #20]
	cmp	r3, #0
	add	r2, r3, #3
	ldr	r1, [r6, #0]
	movge	r2, r3
	mov	r2, r2, asr #2
	add	r5, r0, #3
	add	ip, r2, r1
	cmp	r5, ip
	blt	.L255
	rsb	ip, r2, #0
	add	r1, r3, r1
	add	r5, r0, #2
	add	r1, r1, ip
	cmp	r5, r1
	bge	.L255
	ldr	r5, [r6, #4]
	ldr	r1, [r4, #-8]
	add	r3, r5, r3
	str	r3, [sp, #60]
	add	r3, r1, #7
	str	r3, [sp, #68]
	ldr	r3, [sp, #60]
	add	ip, r3, ip
	ldr	r3, [sp, #68]
	cmp	r3, ip
	bge	.L255
	add	r3, r1, #8
	add	r2, r2, r5
	cmp	r3, r2
	blt	.L255
	ldr	r3, [r6, #32]
	sub	r3, r3, #1
	str	r3, [r6, #32]
	bl	bulletExplode
	ldr	r3, [r6, #32]
	mov	ip, #0
	cmp	r3, #0
	str	ip, [r9, #12]
	beq	.L256
.L272:
	ldr	r0, [r4, #-12]
	b	.L255
.L253:
	mov	r3, #0
	str	r3, [r5, #12]
	b	.L252
.L263:
	ldr	r1, [r7, #20]
	cmp	r1, #0
	add	r9, r1, #3
	ldr	r0, [r7, #0]
	movge	r9, r1
	mov	r9, r9, asr #2
	add	ip, r2, #8
	add	sl, r9, r0
	cmp	ip, sl
	blt	.L261
	add	r1, r1, r0
	add	r2, r2, #2
	rsb	r9, r9, r1
	cmp	r2, r9
	bge	.L261
	ldr	r2, [r8, #16]
	ldr	r1, [r8, #4]
	cmp	r2, #0
	add	r0, r2, #3
	movge	r9, r2
	movlt	r9, r0
	add	ip, r2, r1
	str	ip, [sp, #60]
	add	sl, r3, #3
	sub	ip, ip, r9, asr #2
	cmp	sl, ip
	bge	.L261
	add	r3, r3, #4
	add	r1, r1, r9, asr #2
	cmp	r3, r1
	blt	.L261
	mov	r1, #23552
	mov	r2, #44032
	mov	r3, #0
	ldr	r0, .L277+24
	add	r1, r1, #252
	add	r2, r2, #68
	ldr	ip, .L277+28
	mov	lr, pc
	bx	ip
	sub	r0, r4, #12
	ldmia	r0, {r0, r1}	@ phole ldm
	mov	r2, #0
	bl	playerHit
	ldrb	r3, [fp, #0]	@ zero_extendqisi2
	cmp	r3, #0
	ldreq	r3, [r7, #24]
	subeq	r3, r3, #1
	streq	r3, [r7, #24]
	str	r6, [r4, #0]
	b	.L276
.L258:
	ldr	r6, .L277+32
	ldr	r3, [r6, #28]
	cmp	r3, #0
	add	r2, r3, #3
	ldr	r1, [r6, #0]
	movge	r2, r3
	mov	r2, r2, asr #2
	add	r7, r0, #8
	add	ip, r2, r1
	cmp	r7, ip
	mov	r5, r9
	blt	.L252
	add	r3, r3, r1
	add	ip, r0, #2
	rsb	r2, r2, r3
	cmp	ip, r2
	bge	.L252
	ldr	r3, [r6, #24]
	ldr	r1, [r4, #-8]
	cmp	r3, #0
	add	ip, r3, #3
	movge	r7, r3
	movlt	r7, ip
	str	r7, [sp, #60]
	add	r9, r1, #3
	ldr	r2, [r6, #4]
	str	r9, [sp, #68]
	ldr	r9, [sp, #60]
	add	r7, r3, r2
	sub	r7, r7, r9, asr #2
	ldr	r9, [sp, #68]
	cmp	r9, r7
	bge	.L252
	cmp	r3, #0
	movlt	r3, ip
	add	r7, r1, #4
	add	r2, r2, r3, asr #2
	cmp	r7, r2
	blt	.L252
	ldr	r3, [r6, #32]
	sub	r3, r3, #1
	str	r3, [r6, #32]
	bl	bulletExplode
	ldr	r6, [r6, #32]
	mov	r3, #0
	cmp	r6, #0
	str	r3, [r5, #12]
	bne	.L252
	ldr	r3, .L277+36
	mov	lr, pc
	bx	r3
	mov	r1, #112640
	mov	r2, #44032
	mov	r3, r6
	ldr	r0, .L277+40
	add	r1, r1, #256
	add	r2, r2, #68
	ldr	ip, .L277+28
	mov	lr, pc
	bx	ip
	ldr	r3, .L277+44
	mov	r2, #7
	strb	r2, [r3, #0]
	add	sp, sp, #140
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	b	winPrep
.L256:
	mov	lr, #0
	str	lr, [r6, #16]
	add	r1, fp, r7, asl #6
	add	lr, r1, #8
	str	r1, [sp, #68]
	ldmia	lr!, {r0, r1, r2, r3}
	mov	ip, sp
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	lr, {r0, r1}
	ldr	lr, [sp, #68]
	ldmia	lr, {r2, r3}
	stmia	ip, {r0, r1}
	sub	r0, r4, #12
	ldmia	r0, {r0, r1}	@ phole ldm
	bl	asteroidExplode
	mov	r1, #70656
	mov	r2, #47872
	sub	r1, r1, #9
	mov	r3, #0
	ldr	r0, .L277+48
	add	r2, r2, #128
	ldr	ip, .L277+28
	mov	lr, pc
	bx	ip
	ldr	r1, .L277+44
	ldrb	r3, [r1, #0]	@ zero_extendqisi2
	cmp	r3, #3
	beq	.L272
	mov	r0, sl
	mov	r5, sl
	bl	resetAsteroid
	ldmia	r5!, {r0, r1, r2, r3}
	ldr	ip, [sp, #68]
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r5, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
	ldr	r0, [r4, #-12]
	b	.L255
.L278:
	.align	2
.L277:
	.word	bullets+12
	.word	asteroids
	.word	bossBullets+12
	.word	player
	.word	.LANCHOR0
	.word	explosions+12
	.word	crash
	.word	playSoundB
	.word	theBoss
	.word	stopSound
	.word	explosion
	.word	gameState
	.word	crash0
	.size	updateBullets, .-updateBullets
	.align	2
	.global	alwaysCallThese
	.type	alwaysCallThese, %function
alwaysCallThese:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	ldr	r2, .L299
	mov	r3, #0
.L280:
	mov	r1, #512	@ movhi
	strh	r1, [r2, r3]	@ movhi
	add	r3, r3, #8
	cmp	r3, #1024
	bne	.L280
	ldr	r3, .L299+4
	ldr	r0, [r3, #8]
	ldr	r1, [r3, #4]
	add	ip, r0, r0, lsr #31
	add	r4, r1, r1, lsr #31
	mov	r6, r1, asl #16
	mov	r5, r0, asl #16
	mov	r4, r4, asl #15
	mov	ip, ip, asl #15
	mov	r2, #67108864
	mov	r4, r4, lsr #16
	mov	ip, ip, lsr #16
	mov	r6, r6, lsr #16
	mov	r5, r5, lsr #16
	strh	r6, [r2, #16]	@ movhi
	ldr	r3, .L299+8
	strh	r5, [r2, #18]	@ movhi
	strh	r4, [r2, #24]	@ movhi
	strh	ip, [r2, #26]	@ movhi
	ldr	r4, [r3, #4]
	ldr	r2, [r2, #304]
	ldr	ip, [r3, #0]
	add	r1, r1, r4
	add	r0, r0, ip
	tst	r2, #64
	str	r0, [r3, #8]
	str	r1, [r3, #12]
	bne	.L281
	cmp	ip, #0
	subgt	ip, ip, #1
	movle	r2, #0
	strgt	ip, [r3, #0]
	strle	r2, [r3, #0]
.L281:
	mov	r2, #67108864
	ldr	r2, [r2, #304]
	tst	r2, #128
	bne	.L283
	ldr	r2, [r3, #20]
	ldr	r1, [r3, #0]
	rsb	r2, r2, #160
	cmp	r1, r2
	ldr	r0, .L299+8
	addlt	r1, r1, #1
	strlt	r1, [r0, #0]
	strge	r2, [r0, #0]
.L283:
	mov	r2, #67108864
	ldr	r2, [r2, #304]
	tst	r2, #32
	bne	.L285
	ldr	r2, [r3, #4]
	ldr	r1, .L299+8
	cmp	r2, #0
	subgt	r2, r2, #2
	movle	r2, #0
	strgt	r2, [r1, #4]
	strle	r2, [r1, #4]
.L285:
	mov	r2, #67108864
	ldr	r2, [r2, #304]
	tst	r2, #16
	bne	.L287
	ldr	r2, [r3, #16]
	ldr	r1, [r3, #4]
	rsb	r2, r2, #240
	cmp	r1, r2
	ldr	r0, .L299+8
	addlt	r1, r1, #1
	strlt	r1, [r0, #4]
	strge	r2, [r0, #4]
.L287:
	ldr	r2, .L299+12
	ldr	r2, [r2, #0]
	tst	r2, #8
	beq	.L289
	ldr	r1, .L299+16
	ldr	r1, [r1, #0]
	tst	r1, #8
	beq	.L295
.L289:
	tst	r2, #2
	beq	.L291
	ldr	r1, .L299+16
	ldr	r1, [r1, #0]
	tst	r1, #2
	beq	.L296
.L291:
	tst	r2, #1
	bne	.L297
.L292:
	ldr	r3, [r3, #24]
	cmp	r3, #0
	ble	.L298
	bl	animate
	bl	updateOAM
	bl	updateBullets
	bl	updateDebris
	mov	r3, #512
	mov	r0, #3
	ldr	r1, .L299
	mov	r2, #117440512
	ldr	ip, .L299+20
	mov	lr, pc
	bx	ip
	ldr	r3, .L299+24
	mov	lr, pc
	bx	r3
.L279:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L297:
	ldr	r2, .L299+16
	ldr	r2, [r2, #0]
	tst	r2, #1
	bne	.L292
	ldmfd	sp!, {r4, r5, r6, lr}
	b	cheat
.L295:
	ldr	r3, .L299+28
	mov	r2, #6
	strb	r2, [r3, #0]
	bl	pausePrep
	ldr	r3, .L299+32
	mov	lr, pc
	bx	r3
	b	.L279
.L296:
	ldmfd	sp!, {r4, r5, r6, lr}
	b	shoot
.L298:
	ldr	r3, .L299+28
	mov	r2, #8
	strb	r2, [r3, #0]
	bl	losePrep
	ldr	r3, .L299+36
	mov	lr, pc
	bx	r3
	mov	r1, #208896
	mov	r2, #47872
	ldr	r0, .L299+40
	add	r1, r1, #256
	add	r2, r2, #128
	mov	r3, #0
	ldr	ip, .L299+44
	mov	lr, pc
	bx	ip
	b	.L279
.L300:
	.align	2
.L299:
	.word	shadowOAM
	.word	.LANCHOR0
	.word	player
	.word	oldButtons
	.word	buttons
	.word	DMANow
	.word	waitForVblank
	.word	gameState
	.word	pauseSound
	.word	stopSound
	.word	longCrash
	.word	playSoundB
	.size	alwaysCallThese, .-alwaysCallThese
	.align	2
	.global	preBoss
	.type	preBoss, %function
preBoss:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L310
	stmfd	sp!, {r4, lr}
	ldr	r2, [r3, #4]
	add	r2, r2, #1
	str	r2, [r3, #4]
	bl	alwaysCallThese
	ldr	r2, .L310+4
	mov	r3, #0
	add	r0, r2, #512
.L303:
	ldr	r1, [r2, #16]
	add	r2, r2, #64
	cmp	r1, #1
	moveq	r3, #1
	cmp	r2, r0
	bne	.L303
	cmp	r3, #0
	bne	.L301
	ldr	r4, .L310+8
	ldr	r2, [r4, #0]
	cmp	r2, #75
	beq	.L308
.L305:
	sub	r2, r2, #1
	cmp	r2, #0
	str	r2, [r4, #0]
	ble	.L309
.L301:
	ldmfd	sp!, {r4, lr}
	bx	lr
.L309:
	ldr	r2, .L310+12
	ldr	r3, .L310+16
	mov	r1, #5
	strb	r1, [r2, #0]
	mov	r2, #1
	str	r2, [r3, #16]
	mvn	r2, #0
	str	r2, [r3, #12]
	b	.L301
.L308:
	mov	r2, #44032
	add	r2, r2, #68
	ldr	r0, .L310+20
	mov	r1, #41472
	ldr	ip, .L310+24
	mov	lr, pc
	bx	ip
	ldr	r2, [r4, #0]
	b	.L305
.L311:
	.align	2
.L310:
	.word	.LANCHOR0
	.word	asteroids
	.word	.LANCHOR1
	.word	gameState
	.word	theBoss
	.word	alert
	.word	playSoundB
	.size	preBoss, .-preBoss
	.align	2
	.global	bossFollow
	.type	bossFollow, %function
bossFollow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	ldr	r5, .L323
	ldr	r3, [r5, #4]
	cmp	r3, #174
	ldrgt	r2, [r5, #12]
	ldr	r4, .L323+4
	addgt	r3, r2, r3
	strgt	r3, [r5, #4]
	ldr	r2, .L323+8
	ldr	r3, [r4, #20]
	smull	r0, r2, r3, r2
	mov	r1, r3, asr #31
	add	r2, r2, r3
	rsb	r2, r1, r2, asr #4
	rsb	r2, r2, r2, asl #4
	subs	r2, r3, r2, asl #1
	beq	.L321
.L314:
	ldr	r2, [r4, #24]
	mov	r1, #-1241513984
	add	r1, r1, #745472
	add	r2, r2, #1
	add	r1, r1, #183
	smull	r0, r1, r2, r1
	mov	r0, r2, asr #31
	add	r1, r1, r2
	rsb	r1, r0, r1, asr #6
	add	r1, r1, r1, asl #1
	rsb	r1, r1, r1, asl #4
	add	r3, r3, #1
	subs	r1, r2, r1, asl #1
	str	r3, [r4, #20]
	str	r2, [r4, #24]
	beq	.L322
	ldr	r2, .L323+12
	ldr	r3, [r5, #0]
	ldr	r1, [r2, #0]
	sub	r2, r3, #7
	cmp	r2, r1
	ldr	r2, .L323
	ble	.L317
	ldr	r1, [r2, #8]
	rsb	r3, r1, r3
	cmp	r3, #0
	subgt	r3, r3, #1
	movle	r3, #0
	strgt	r3, [r2, #0]
	strle	r3, [r2, #0]
.L319:
	ldmfd	sp!, {r4, r5, r6, lr}
	b	alwaysCallThese
.L317:
	add	r0, r3, #7
	cmp	r1, r0
	ble	.L319
	ldr	r0, [r2, #8]
	ldr	r1, [r2, #28]
	add	r3, r3, r0
	rsb	r1, r1, #160
	cmp	r3, r1
	addlt	r3, r3, #1
	strlt	r3, [r2, #0]
	strge	r1, [r2, #0]
	b	.L319
.L321:
	str	r2, [r4, #20]
	bl	bossShoot
	ldr	r3, [r4, #20]
	b	.L314
.L322:
	ldr	r3, .L323+4
	str	r1, [r3, #24]
	ldr	r3, .L323+16
	mov	r2, #5
	strb	r2, [r3, #0]
	bl	bossRandom
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L324:
	.align	2
.L323:
	.word	theBoss
	.word	.LANCHOR0
	.word	-2004318071
	.word	player
	.word	gameState
	.size	bossFollow, .-bossFollow
	.align	2
	.global	bossRandom
	.type	bossRandom, %function
bossRandom:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	ldr	r4, .L337
	ldr	r3, [r4, #4]
	cmp	r3, #174
	ldrgt	r2, [r4, #12]
	ldr	r5, .L337+4
	addgt	r3, r2, r3
	strgt	r3, [r4, #4]
	ldr	r2, .L337+8
	ldr	r3, [r5, #20]
	smull	r0, r2, r3, r2
	mov	r1, r3, asr #31
	add	r2, r2, r3
	rsb	r2, r1, r2, asr #4
	rsb	r2, r2, r2, asl #4
	subs	r2, r3, r2, asl #1
	beq	.L335
.L327:
	ldrb	r1, [r5, #28]	@ zero_extendqisi2
	add	r3, r3, #1
	cmp	r1, #0
	str	r3, [r5, #20]
	ldrne	r0, [r4, #0]
	ldrne	r3, [r4, #8]
	ldreq	r3, [r4, #0]
	ldreq	r0, [r4, #8]
	rsbne	r3, r3, r0
	addeq	r3, r0, r3
	ldr	r2, [r5, #24]
	strne	r3, [r4, #0]
	streq	r3, [r4, #0]
	mov	r3, #-1241513984
	add	r3, r3, #745472
	add	r2, r2, #1
	add	r3, r3, #183
	smull	r0, r3, r2, r3
	mov	r0, r2, asr #31
	add	r3, r3, r2
	rsb	r3, r0, r3, asr #6
	add	r3, r3, r3, asl #1
	rsb	r3, r3, r3, asl #4
	str	r2, [r5, #24]
	subs	r2, r2, r3, asl #1
	beq	.L336
	ldr	r3, [r4, #0]
	ldr	r2, [r4, #28]
	cmp	r3, #0
	subgt	r3, r3, #1
	movle	r3, #0
	rsb	r2, r2, #160
	cmp	r3, r2
	ldr	r1, .L337
	addlt	r3, r3, #1
	strlt	r3, [r1, #0]
	strge	r2, [r1, #0]
	ldmfd	sp!, {r4, r5, r6, lr}
	b	alwaysCallThese
.L335:
	str	r2, [r5, #20]
	bl	bossShoot
	ldr	r3, [r5, #20]
	b	.L327
.L336:
	ldr	r3, .L337+12
	eor	r1, r1, #1
	str	r2, [r5, #24]
	mov	r2, #4
	strb	r1, [r5, #28]
	strb	r2, [r3, #0]
	ldmfd	sp!, {r4, r5, r6, lr}
	b	bossFollow
.L338:
	.align	2
.L337:
	.word	theBoss
	.word	.LANCHOR0
	.word	-2004318071
	.word	gameState
	.size	bossRandom, .-bossRandom
	.align	2
	.global	game
	.type	game, %function
game:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L342
	ldr	r2, [r3, #4]
	ldr	r1, [r3, #12]
	add	r2, r2, #1
	cmp	r1, #7
	str	r2, [r3, #4]
	ble	.L340
	ldr	r3, .L342+4
	mov	r2, #3
	strb	r2, [r3, #0]
	bx	lr
.L340:
	b	alwaysCallThese
.L343:
	.align	2
.L342:
	.word	.LANCHOR0
	.word	gameState
	.size	game, .-game
	.align	2
	.global	initialize
	.type	initialize, %function
initialize:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	ldr	r3, .L359
	ldr	r4, .L359+4
	mov	r1, #32
	mov	r2, #67108864
	sub	sp, sp, #68
	ldr	lr, [r2, #304]
	str	r1, [r3, #24]
	str	r1, [r3, #28]
	str	r1, [r4, #16]
	str	r1, [r4, #20]
	mov	r1, #250
	str	r1, [r3, #4]
	mov	r1, #25
	str	r1, [r3, #32]
	mov	r1, #12
	mov	r2, #0
	mov	r0, #64
	str	r1, [r3, #40]
	mov	r5, #1
	mov	r1, #32768
	ldr	ip, .L359+8
	str	r0, [r3, #0]
	str	r2, [r3, #16]
	str	r2, [r3, #48]
	str	r2, [r3, #60]
	str	r2, [r3, #52]
	mov	r6, #104
	str	r5, [r3, #12]
	str	r5, [r3, #8]
	str	r0, [r3, #20]
	str	r1, [r3, #44]
	ldr	r3, .L359+12
	str	r6, [r4, #4]
	mov	r6, #5
	str	r2, [r4, #28]
	str	r2, [r4, #40]
	str	r2, [r4, #32]
	str	r2, [r4, #48]
	str	r2, [ip, #4]
	str	r2, [ip, #8]
	str	r0, [r4, #0]
	str	r6, [r4, #24]
	str	lr, [r3, #0]
	bl	setupAsteroidTypes
	ldr	r2, [r4, #24]
	cmp	r2, #0
	ble	.L345
	ldr	r3, .L359+16
	add	r2, r3, r2, asl #2
.L346:
	str	r5, [r3], #4
	cmp	r3, r2
	bne	.L346
.L345:
	ldr	r4, .L359+20
	ldr	r5, .L359+24
	ldr	r9, .L359+28
	ldr	r7, .L359+32
	add	fp, r4, #160
	mov	r6, #0
	mvn	sl, #0
	mov	r8, #16
.L347:
	str	r6, [r4, #0]
	str	sl, [r4, #-4]
	str	r8, [r4, #4]
	mov	lr, pc
	bx	r5
	ldr	r1, [r4, #4]
	rsb	r1, r1, #160
	mov	lr, pc
	bx	r9
	str	r1, [r4, #-12]
	mov	lr, pc
	bx	r5
	smull	r2, r3, r7, r0
	mov	r2, r0, asr #31
	add	r3, r3, r0
	rsb	r3, r2, r3, asr #7
	rsb	r3, r3, r3, asl #4
	sub	r0, r0, r3, asl #4
	add	r0, r0, #250
	str	r0, [r4, #-8]
	add	r4, r4, #20
	cmp	r4, fp
	bne	.L347
	ldr	r3, .L359+36
	mov	r2, #1
	str	r2, [r3, #12]
	ldr	r7, .L359+40
	mov	r5, sp
.L348:
	mov	r0, sp
	mov	r4, r5
	bl	resetAsteroid
	ldmia	r4!, {r0, r1, r2, r3}
	add	ip, r7, r6, asl #6
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	add	r6, r6, #1
	ldmia	r4, {r0, r1, r2, r3}
	cmp	r6, #8
	stmia	ip, {r0, r1, r2, r3}
	bne	.L348
	ldr	r3, .L359+44
	mov	r2, #0
	add	r0, r3, #120
	mov	r1, #2
.L349:
	str	r2, [r3, #0]
	str	r2, [r3, #-12]
	str	r2, [r3, #-8]
	str	r1, [r3, #-4]
	add	r3, r3, #24
	cmp	r3, r0
	bne	.L349
	ldr	r3, .L359+48
	add	r0, r3, #240
.L350:
	str	r2, [r3, #0]
	str	r2, [r3, #-12]
	str	r2, [r3, #-8]
	str	r1, [r3, #-4]
	add	r3, r3, #24
	cmp	r3, r0
	bne	.L350
	ldr	r3, .L359+52
	mvn	r0, #0
	add	ip, r3, #800
	mov	r1, #237
.L351:
	str	r2, [r3, #-12]
	str	r2, [r3, #-24]
	str	r2, [r3, #-20]
	str	r0, [r3, #-16]
	str	r2, [r3, #-8]
	stmda	r3, {r1, r2}	@ phole stm
	strb	r2, [r3, #12]
	add	r3, r3, #40
	cmp	r3, ip
	bne	.L351
	add	sp, sp, #68
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L360:
	.align	2
.L359:
	.word	theBoss
	.word	player
	.word	.LANCHOR0
	.word	buttons
	.word	health
	.word	healthPacks+12
	.word	rand
	.word	__aeabi_idivmod
	.word	-2004318071
	.word	healthPacks
	.word	asteroids
	.word	bullets+12
	.word	bossBullets+12
	.word	explosions+24
	.size	initialize, .-initialize
	.align	2
	.global	splash
	.type	splash, %function
splash:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L366
	stmfd	sp!, {r4, lr}
	ldr	r3, [r3, #0]
	tst	r3, #8
	beq	.L362
	ldr	r2, .L366+4
	ldr	r0, [r2, #0]
	ands	r0, r0, #8
	beq	.L364
.L362:
	tst	r3, #4
	beq	.L363
	ldr	r3, .L366+4
	ldr	r0, [r3, #0]
	ands	r0, r0, #4
	beq	.L365
.L363:
	ldr	r3, .L366+8
	ldr	r2, [r3, #32]
	add	r2, r2, #1
	str	r2, [r3, #32]
	mov	r0, r2
	ldr	r3, .L366+12
	mov	lr, pc
	bx	r3
	ldmfd	sp!, {r4, lr}
	bx	lr
.L364:
	ldr	r3, .L366+16
	mov	lr, pc
	bx	r3
	ldr	r3, .L366+20
	mov	r2, #2
	strb	r2, [r3, #0]
	bl	gamePrep
	ldmfd	sp!, {r4, lr}
	b	initialize
.L365:
	ldr	r3, .L366+16
	mov	lr, pc
	bx	r3
	ldr	r3, .L366+20
	mov	r2, #1
	strb	r2, [r3, #0]
	ldmfd	sp!, {r4, lr}
	b	howtoPrep
.L367:
	.align	2
.L366:
	.word	oldButtons
	.word	buttons
	.word	.LANCHOR0
	.word	srand
	.word	fillScreen3
	.word	gameState
	.size	splash, .-splash
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, lr}
	mov	r3, #1024
	add	r3, r3, #3
	mov	r4, #67108864
	strh	r3, [r4, #0]	@ movhi
	ldr	r3, .L384
	mov	lr, pc
	bx	r3
	ldr	r3, .L384+4
	mov	lr, pc
	bx	r3
	bl	splashPrep
	mov	r1, #4194304
	add	r1, r1, #36864
	mov	r2, #44032
	ldr	r0, .L384+8
	add	r1, r1, #128
	add	r2, r2, #68
	mov	r3, #1
	ldr	ip, .L384+12
	mov	lr, pc
	bx	ip
	ldr	r5, .L384+16
	ldr	r7, .L384+20
	ldr	r6, .L384+24
.L383:
	ldr	r3, [r5, #0]
	ldrb	r2, [r7, #0]	@ zero_extendqisi2
.L370:
	str	r3, [r6, #0]
	ldr	r3, [r4, #304]
	str	r3, [r5, #0]
	cmp	r2, #8
	ldrls	pc, [pc, r2, asl #2]
	b	.L370
.L380:
	.word	.L371
	.word	.L372
	.word	.L373
	.word	.L374
	.word	.L375
	.word	.L376
	.word	.L377
	.word	.L378
	.word	.L379
.L379:
	bl	lose
	b	.L383
.L378:
	bl	win
	b	.L383
.L377:
	bl	pause
	b	.L383
.L376:
	bl	bossRandom
	b	.L383
.L375:
	bl	bossFollow
	b	.L383
.L374:
	bl	preBoss
	b	.L383
.L373:
	bl	game
	b	.L383
.L372:
	bl	howto
	b	.L383
.L371:
	bl	splash
	b	.L383
.L385:
	.align	2
.L384:
	.word	setupInterrupts
	.word	setupSounds
	.word	Ballad
	.word	playSoundA
	.word	buttons
	.word	gameState
	.word	oldButtons
	.size	main, .-main
	.global	hOff
	.global	vOff
	.global	collMapSize
	.global	seed
	.global	collectedHP
	.global	howToState
	.global	howToBullet
	.global	alertDelay
	.global	bulletTimer
	.global	bossMoveTimer
	.global	bossMoveDirIsUp
	.global	cheating
	.comm	oldButtons,4,4
	.comm	buttons,4,4
	.comm	buffer,41,4
	.comm	shadowOAM,1024,4
	.comm	bigRow,4,4
	.comm	bigCol,4,4
	.comm	player,52,4
	.comm	theBoss,64,4
	.comm	bullets,120,4
	.comm	bossBullets,240,4
	.comm	explosions,800,4
	.comm	healthPacks,160,4
	.comm	asteroids,512,4
	.comm	asteroidType,384,4
	.comm	health,60,4
	.comm	state,1,1
	.comm	gameState,1,1
	.data
	.align	2
	.set	.LANCHOR1,. + 0
	.type	alertDelay, %object
	.size	alertDelay, 4
alertDelay:
	.word	75
	.type	howToBullet, %object
	.size	howToBullet, 4
howToBullet:
	.word	60
	.type	collMapSize, %object
	.size	collMapSize, 4
collMapSize:
	.word	256
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"FLEET DESTROYER\000"
.LC1:
	.ascii	"Start to begin\000"
	.space	1
.LC2:
	.ascii	"Select for instructions\000"
.LC3:
	.ascii	"Press Start to continue\000"
.LC4:
	.ascii	"Press Select to quit to main menu\000"
	.space	2
.LC5:
	.ascii	"VICTORY IS YOURS\000"
	.space	3
.LC6:
	.ascii	"Press Start to return to main menu\000"
	.space	1
.LC7:
	.ascii	"YOUR SHIP WAS DESTROYED\000"
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	cheating, %object
	.size	cheating, 1
cheating:
	.space	1
	.space	3
	.type	hOff, %object
	.size	hOff, 4
hOff:
	.space	4
	.type	vOff, %object
	.size	vOff, 4
vOff:
	.space	4
	.type	collectedHP, %object
	.size	collectedHP, 4
collectedHP:
	.space	4
	.type	howToState, %object
	.size	howToState, 4
howToState:
	.space	4
	.type	bulletTimer, %object
	.size	bulletTimer, 4
bulletTimer:
	.space	4
	.type	bossMoveTimer, %object
	.size	bossMoveTimer, 4
bossMoveTimer:
	.space	4
	.type	bossMoveDirIsUp, %object
	.size	bossMoveDirIsUp, 1
bossMoveDirIsUp:
	.space	1
	.space	3
	.type	seed, %object
	.size	seed, 4
seed:
	.space	4
	.ident	"GCC: (devkitARM release 31) 4.5.0"
