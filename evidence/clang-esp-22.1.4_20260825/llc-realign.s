	.file	"realign.ll"
	.literal_position
	.literal .LCPI0_0, use
	.text
	.text
	.global	realign                         # -- Begin function realign
	.p2align	2
	.type	realign,@function
realign:                                # @realign
	.cfi_startproc
# %bb.0:                                # %entry
	entry	a1, 160
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a1, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	.cfi_def_cfa_offset 160
	addi	a10, a1, 0
	l32r	a8, .LCPI0_0
	callx8	a8
	retw.n
.Lfunc_end0:
	.size	realign, .Lfunc_end0-realign
	.cfi_endproc
                                        # -- End function
	.literal_position
	.literal .LCPI1_0, use
	.text
	.global	control                         # -- Begin function control
	.p2align	2
	.type	control,@function
control:                                # @control
	.cfi_startproc
# %bb.0:                                # %entry
	entry	a1, 96
	.cfi_def_cfa_offset 96
	addi	a10, a1, 0
	l32r	a8, .LCPI1_0
	callx8	a8
	retw.n
.Lfunc_end1:
	.size	control, .Lfunc_end1-control
	.cfi_endproc
                                        # -- End function
	.literal_position
	.literal .LCPI2_0, use
	.text
	.global	under_aligned_32                # -- Begin function under_aligned_32
	.p2align	2
	.type	under_aligned_32,@function
under_aligned_32:                       # @under_aligned_32
	.cfi_startproc
# %bb.0:                                # %entry
	entry	a1, 96
	.cfi_def_cfa_offset 96
	addi	a10, a1, 0
	l32r	a8, .LCPI2_0
	callx8	a8
	retw.n
.Lfunc_end2:
	.size	under_aligned_32, .Lfunc_end2-under_aligned_32
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
