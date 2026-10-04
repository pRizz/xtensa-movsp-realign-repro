	.text
	.file	"realign.c"
	.literal_position
	.literal .LCPI0_0, use
	.global	realign_trigger
	.p2align	2
	.type	realign_trigger,@function
realign_trigger:
	entry	a1, 160
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a1, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	addi	a10, a1, 0
	l32r	a8, .LCPI0_0
	callx8	a8
	retw.n
.Lfunc_end0:
	.size	realign_trigger, .Lfunc_end0-realign_trigger

	.literal_position
	.literal .LCPI1_0, use
	.global	control_no_overalign
	.p2align	2
	.type	control_no_overalign,@function
control_no_overalign:
	entry	a1, 96
	addi	a10, a1, 0
	l32r	a8, .LCPI1_0
	callx8	a8
	retw.n
.Lfunc_end1:
	.size	control_no_overalign, .Lfunc_end1-control_no_overalign

	.ident	"Espressif clang version 19.1.2 (https://github.com/espressif/llvm-project.git esp-19.1.2_20250225)"
	.section	".note.GNU-stack","",@progbits
