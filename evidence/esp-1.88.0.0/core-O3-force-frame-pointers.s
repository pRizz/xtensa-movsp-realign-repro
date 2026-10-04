	.text
	.file	"movsp_realign_repro.52164b975cc8d24a-cgu.0"
	.literal_position
	.literal .LCPI0_0, memset
	.section	.text.realign_trigger,"ax",@progbits
	.global	realign_trigger
	.p2align	2
	.type	realign_trigger,@function
realign_trigger:
	entry	a1, 288
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a7, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	mov.n	a7, a1
	addi	a6, a7, 64
	movi.n	a12, 64
	l32r	a8, .LCPI0_0
	mov.n	a10, a6
	mov.n	a11, a2
	callx8	a8
	s32i	a6, a7, 188
	movi	a8, 188
	add.n	a8, a7, a8
	addi	a8, a8, 0
	#APP
	#NO_APP
	l8ui	a2, a7, 67
	retw.n
.Lfunc_end0:
	.size	realign_trigger, .Lfunc_end0-realign_trigger

	.section	.text.cache_padded_channel_like,"ax",@progbits
	.global	cache_padded_channel_like
	.p2align	2
	.type	cache_padded_channel_like,@function
cache_padded_channel_like:
	entry	a1, 416
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a7, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	mov.n	a7, a1
	s32i	a2, a7, 192
	s32i	a2, a7, 128
	movi.n	a8, 0
	s32i	a8, a7, 64
	addi	a8, a7, 64
	s32i	a8, a7, 316
	movi	a8, 316
	add.n	a8, a7, a8
	addi	a8, a8, 0
	#APP
	#NO_APP
	l32i	a8, a7, 316
	l32i.n	a9, a8, 0
	l32i	a10, a8, 64
	add.n	a9, a10, a9
	l32i	a8, a8, 128
	add.n	a2, a9, a8
	retw.n
.Lfunc_end1:
	.size	cache_padded_channel_like, .Lfunc_end1-cache_padded_channel_like

	.literal_position
	.literal .LCPI2_0, memset
	.section	.text.control_no_overalign,"ax",@progbits
	.global	control_no_overalign
	.p2align	2
	.type	control_no_overalign,@function
control_no_overalign:
	entry	a1, 112
	mov.n	a7, a1
	addi	a6, a7, 0
	movi.n	a12, 64
	l32r	a8, .LCPI2_0
	mov.n	a10, a6
	mov.n	a11, a2
	callx8	a8
	s32i	a6, a7, 64
	addi	a8, a7, 64
	#APP
	#NO_APP
	l8ui	a2, a7, 3
	retw.n
.Lfunc_end2:
	.size	control_no_overalign, .Lfunc_end2-control_no_overalign

	.ident	"rustc version 1.88.0-nightly (2ab28d2e7 2025-06-24) (1.88.0.0)"
	.section	".note.GNU-stack","",@progbits
