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
	.file	"sound.c"
	.text
	.align	2
	.global	setupSounds
	.type	setupSounds, %function
setupSounds:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mvn	r2, #1264
	mov	r3, #67108864
	sub	r2, r2, #1
	mov	r1, #128	@ movhi
	strh	r1, [r3, #132]	@ movhi
	strh	r2, [r3, #130]	@ movhi
	mov	r2, #0	@ movhi
	strh	r2, [r3, #128]	@ movhi
	bx	lr
	.size	setupSounds, .-setupSounds
	.global	__aeabi_idiv
	.align	2
	.global	playSoundA
	.type	playSoundA, %function
playSoundA:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, .L3
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	ldr	ip, [ip, #0]
	mov	r6, #0
	add	ip, ip, #12
	str	r6, [ip, #8]
	ldr	ip, .L3+4
	mov	sl, r0
	mov	r7, #67108864
	mov	r5, r2
	mov	r4, r1
	add	r2, r7, #160
	str	r6, [ip, #0]
	add	r7, r7, #256
	ldr	ip, .L3+8
	mov	r9, r3
	mov	r0, #1
	mov	r3, #910163968
	mov	r1, sl
	mov	lr, pc
	bx	ip
	ldr	r8, .L3+12
	mov	r1, r5
	strh	r6, [r7, #2]	@ movhi
	mov	r0, #16777216
	mov	lr, pc
	bx	r8
	rsb	r3, r0, #0
	mov	r3, r3, asl #16
	ldr	r6, .L3+16
	mov	r3, r3, lsr #16
	strh	r3, [r7, #0]	@ movhi
	mov	r3, #128	@ movhi
	str	sl, [r6, #0]
	rsb	r0, r4, r4, asl #4
	strh	r3, [r7, #2]	@ movhi
	mov	r3, #1
	mov	r1, r5
	str	r5, [r6, #8]
	str	r3, [r6, #12]
	mov	r0, r0, asl #2
	str	r4, [r6, #4]
	str	r9, [r6, #16]
	mov	lr, pc
	bx	r8
	mov	r1, r5
	sub	r5, r0, #1
	mov	r0, r4
	mov	lr, pc
	bx	r8
	sub	r0, r0, r0, asl #2
	add	r5, r5, r0
	str	r5, [r6, #20]
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L4:
	.align	2
.L3:
	.word	dma
	.word	vbCountA
	.word	DMANow
	.word	__aeabi_idiv
	.word	soundA
	.size	playSoundA, .-playSoundA
	.align	2
	.global	playSoundB
	.type	playSoundB, %function
playSoundB:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, .L6
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	ldr	ip, [ip, #0]
	mov	r6, #0
	add	ip, ip, #24
	str	r6, [ip, #8]
	ldr	ip, .L6+4
	mov	sl, r0
	mov	r7, #67108864
	mov	r5, r2
	mov	r4, r1
	add	r2, r7, #164
	str	r6, [ip, #0]
	add	r7, r7, #256
	ldr	ip, .L6+8
	mov	r9, r3
	mov	r0, #2
	mov	r3, #910163968
	mov	r1, sl
	mov	lr, pc
	bx	ip
	ldr	r8, .L6+12
	mov	r1, r5
	strh	r6, [r7, #6]	@ movhi
	mov	r0, #16777216
	mov	lr, pc
	bx	r8
	rsb	r3, r0, #0
	mov	r3, r3, asl #16
	ldr	r6, .L6+16
	mov	r3, r3, lsr #16
	strh	r3, [r7, #4]	@ movhi
	mov	r3, #128	@ movhi
	str	sl, [r6, #0]
	rsb	r0, r4, r4, asl #4
	strh	r3, [r7, #6]	@ movhi
	mov	r3, #1
	mov	r1, r5
	str	r5, [r6, #8]
	str	r3, [r6, #12]
	mov	r0, r0, asl #2
	str	r4, [r6, #4]
	str	r9, [r6, #16]
	mov	lr, pc
	bx	r8
	mov	r1, r5
	sub	r5, r0, #1
	mov	r0, r4
	mov	lr, pc
	bx	r8
	sub	r0, r0, r0, asl #2
	add	r5, r5, r0
	str	r5, [r6, #20]
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L7:
	.align	2
.L6:
	.word	dma
	.word	vbCountB
	.word	DMANow
	.word	__aeabi_idiv
	.word	soundB
	.size	playSoundB, .-playSoundB
	.align	2
	.global	interruptHandler
	.type	interruptHandler, %function
interruptHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	mov	r3, #67108864
	add	r3, r3, #512
	ldrh	r2, [r3, #2]
	tst	r2, #1
	mov	r2, #0	@ movhi
	strh	r2, [r3, #8]	@ movhi
	beq	.L9
	ldr	r3, .L21
	ldr	r2, [r3, #12]
	cmp	r2, #1
	ldreq	r1, .L21+4
	ldrne	r2, .L21+4
	ldreq	r2, [r1, #0]
	ldrne	r2, [r2, #0]
	ldr	r3, [r3, #20]
	addeq	r2, r2, #1
	streq	r2, [r1, #0]
	cmp	r3, r2
	ldr	r2, .L21
	bge	.L12
	ldr	r3, [r2, #16]
	cmp	r3, #1
	beq	.L19
	ldr	r3, .L21+8
	ldr	r1, [r3, #0]
	mov	r3, #0
	add	r1, r1, #12
	str	r3, [r1, #8]
	str	r3, [r2, #12]
.L12:
	ldr	r3, .L21+12
	ldr	r2, [r3, #12]
	cmp	r2, #1
	ldreq	r1, .L21+16
	ldrne	r2, .L21+16
	ldreq	r2, [r1, #0]
	ldrne	r2, [r2, #0]
	ldr	r3, [r3, #20]
	addeq	r2, r2, #1
	streq	r2, [r1, #0]
	cmp	r3, r2
	ldr	r2, .L21+12
	bge	.L16
	ldr	r3, [r2, #16]
	cmp	r3, #1
	beq	.L20
	ldr	r3, .L21+8
	ldr	r1, [r3, #0]
	mov	r3, #0
	add	r1, r1, #24
	str	r3, [r1, #8]
	str	r3, [r2, #12]
.L16:
	mov	r3, #67108864
	add	r3, r3, #512
	mov	r2, #1	@ movhi
	strh	r2, [r3, #2]	@ movhi
.L9:
	mov	r3, #67108864
	add	r3, r3, #512
	mov	r2, #1	@ movhi
	strh	r2, [r3, #8]	@ movhi
	ldmfd	sp!, {r3, lr}
	bx	lr
.L20:
	ldmia	r2, {r0, r1, r2}	@ phole ldm
	bl	playSoundB
	b	.L16
.L19:
	ldmia	r2, {r0, r1, r2}	@ phole ldm
	bl	playSoundA
	b	.L12
.L22:
	.align	2
.L21:
	.word	soundA
	.word	vbCountA
	.word	dma
	.word	soundB
	.word	vbCountB
	.size	interruptHandler, .-interruptHandler
	.align	2
	.global	muteSound
	.type	muteSound, %function
muteSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #67108864
	mov	r2, #0	@ movhi
	strh	r2, [r3, #132]	@ movhi
	bx	lr
	.size	muteSound, .-muteSound
	.align	2
	.global	unmuteSound
	.type	unmuteSound, %function
unmuteSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #67108864
	mov	r2, #128	@ movhi
	strh	r2, [r3, #132]	@ movhi
	bx	lr
	.size	unmuteSound, .-unmuteSound
	.align	2
	.global	pauseSound
	.type	pauseSound, %function
pauseSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
	mov	r3, #0
	add	r2, r2, #256
	strh	r3, [r2, #2]	@ movhi
	strh	r3, [r2, #6]	@ movhi
	ldr	r2, .L26
	str	r3, [r2, #12]
	ldr	r2, .L26+4
	str	r3, [r2, #12]
	bx	lr
.L27:
	.align	2
.L26:
	.word	soundA
	.word	soundB
	.size	pauseSound, .-pauseSound
	.align	2
	.global	unpauseSound
	.type	unpauseSound, %function
unpauseSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #67108864
	add	r3, r3, #256
	mov	r1, #128
	strh	r1, [r3, #2]	@ movhi
	strh	r1, [r3, #6]	@ movhi
	ldr	r3, .L29
	mov	r2, #1
	str	r2, [r3, #12]
	ldr	r3, .L29+4
	str	r2, [r3, #12]
	bx	lr
.L30:
	.align	2
.L29:
	.word	soundA
	.word	soundB
	.size	unpauseSound, .-unpauseSound
	.align	2
	.global	stopSound
	.type	stopSound, %function
stopSound:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L32
	ldr	r2, [r3, #0]
	mov	r3, #0
	add	r1, r2, #12
	str	r3, [r1, #8]
	ldr	r1, .L32+4
	add	r2, r2, #24
	str	r3, [r1, #12]
	str	r3, [r2, #8]
	ldr	r2, .L32+8
	str	r3, [r2, #12]
	bx	lr
.L33:
	.align	2
.L32:
	.word	dma
	.word	soundA
	.word	soundB
	.size	stopSound, .-stopSound
	.align	2
	.global	setupInterrupts
	.type	setupInterrupts, %function
setupInterrupts:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
	add	r3, r2, #512
	str	r4, [sp, #-4]!
	ldrh	r0, [r2, #4]
	ldrh	ip, [r3, #0]
	mov	r1, #50331648
	ldr	r4, .L35
	add	r1, r1, #28672
	orr	ip, ip, #1
	orr	r0, r0, #8
	str	r4, [r1, #4092]
	strh	ip, [r3, #0]	@ movhi
	strh	r0, [r2, #4]	@ movhi
	mov	r2, #1	@ movhi
	strh	r2, [r3, #8]	@ movhi
	ldmfd	sp!, {r4}
	bx	lr
.L36:
	.align	2
.L35:
	.word	interruptHandler
	.size	setupInterrupts, .-setupInterrupts
	.comm	soundA,28,4
	.comm	soundB,28,4
	.comm	vbCountA,4,4
	.comm	vbCountB,4,4
	.ident	"GCC: (devkitARM release 31) 4.5.0"
