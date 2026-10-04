	.file	"movsp_realign_repro.f6eba51747e4c43a-cgu.0"
	.section	.text.cache_padded_channel_like,"ax",@progbits
	.global	cache_padded_channel_like
	.p2align	2
	.type	cache_padded_channel_like,@function
cache_padded_channel_like:
	entry	a1, 416
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a1, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	s32i	a2, a1, 192
	s32i	a2, a1, 128
	movi.n	a8, 0
	s32i	a8, a1, 64
	addi	a8, a1, 64
	s32i	a8, a1, 316
	movi	a8, 316
	add.n	a8, a1, a8
	addi	a8, a8, 0
	#APP
	#NO_APP
	l32i	a8, a1, 316
	l32i.n	a9, a8, 0
	l32i	a10, a8, 64
	add.n	a9, a10, a9
	l32i	a8, a8, 128
	add.n	a2, a9, a8
	retw.n
.Lfunc_end0:
	.size	cache_padded_channel_like, .Lfunc_end0-cache_padded_channel_like

	.literal_position
	.literal .LCPI1_0, memset
	.section	.text.cache_padded_channel_like,"ax",@progbits
	.section	.text.control_no_overalign,"ax",@progbits
	.global	control_no_overalign
	.p2align	2
	.type	control_no_overalign,@function
control_no_overalign:
	entry	a1, 112
	mov.n	a11, a2
	addi	a7, a1, 0
	movi.n	a12, 64
	l32r	a8, .LCPI1_0
	mov.n	a10, a7
	callx8	a8
	s32i	a7, a1, 64
	addi	a8, a1, 64
	#APP
	#NO_APP
	l8ui	a2, a1, 3
	retw.n
.Lfunc_end1:
	.size	control_no_overalign, .Lfunc_end1-control_no_overalign

	.literal_position
	.literal .LCPI2_0, memset
	.section	.text.control_no_overalign,"ax",@progbits
	.section	.text.realign_trigger,"ax",@progbits
	.global	realign_trigger
	.p2align	2
	.type	realign_trigger,@function
realign_trigger:
	entry	a1, 288
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a1, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	mov.n	a11, a2
	addi	a7, a1, 64
	movi.n	a12, 64
	l32r	a8, .LCPI2_0
	mov.n	a10, a7
	callx8	a8
	s32i	a7, a1, 188
	movi	a8, 188
	add.n	a8, a1, a8
	addi	a8, a8, 0
	#APP
	#NO_APP
	l8ui	a2, a1, 67
	retw.n
.Lfunc_end2:
	.size	realign_trigger, .Lfunc_end2-realign_trigger

	.ident	"rustc version 1.99.0-nightly (ad02ddc22 2026-09-30) (1.99.0.0)"
	.section	".note.GNU-stack","",@progbits
