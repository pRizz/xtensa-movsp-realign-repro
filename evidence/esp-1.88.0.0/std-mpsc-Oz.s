	.text
	.file	"std_mpmc_repro.a740b504a668b155-cgu.0"
	.section	".text._ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4fold17h38326d16241098c0E","ax",@progbits
	.global	_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4fold17h38326d16241098c0E
	.p2align	2
	.type	_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4fold17h38326d16241098c0E,@function
_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4fold17h38326d16241098c0E:
	entry	a1, 32
	maxu	a8, a3, a2
	l32i.n	a10, a4, 8
	l32i.n	a9, a4, 4
	addx8	a11, a9, a10
	l32i.n	a10, a4, 0
	movi.n	a12, 0
	beq	a8, a2, .LBB0_2
.LBB0_1:
	s32i.n	a12, a11, 4
	s32i.n	a2, a11, 0
	addi.n	a11, a11, 8
	addi.n	a9, a9, 1
	addi.n	a2, a2, 1
	bne	a8, a2, .LBB0_1
.LBB0_2:
	s32i.n	a9, a10, 0
	retw.n
.Lfunc_end0:
	.size	_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4fold17h38326d16241098c0E, .Lfunc_end0-_ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4fold17h38326d16241098c0E

	.literal_position
	.literal .LCPI1_0, _ZN5alloc7raw_vec20RawVecInner$LT$A$GT$15try_allocate_in17haa76108dfb203d8cE
	.literal .LCPI1_1, _ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17he2a741e20a088a25E
	.literal .LCPI1_2, _ZN5alloc7raw_vec12handle_error17hbfccafac19cfbb21E
	.section	".text._ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h9c39bd364b5704beE","ax",@progbits
	.global	_ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h9c39bd364b5704beE
	.p2align	2
	.type	_ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h9c39bd364b5704beE,@function
_ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h9c39bd364b5704beE:
	entry	a1, 64
	maxu	a8, a4, a3
	sub	a11, a8, a3
	addi	a10, a1, 12
	movi.n	a7, 0
	movi.n	a13, 4
	movi.n	a14, 8
	l32r	a8, .LCPI1_0
	mov.n	a12, a7
	callx8	a8
	l32i.n	a10, a1, 16
	l32i.n	a8, a1, 12
	beqi	a8, 1, .LBB1_2
	s32i.n	a7, a1, 8
	l32i.n	a8, a1, 20
	s32i.n	a8, a1, 4
	s32i.n	a10, a1, 0
	addi	a10, a1, 0
	l32r	a8, .LCPI1_1
	mov.n	a11, a3
	mov.n	a12, a4
	mov.n	a13, a5
	callx8	a8
	l32i.n	a8, a1, 8
	s32i.n	a8, a2, 8
	l32i.n	a8, a1, 4
	s32i.n	a8, a2, 4
	l32i.n	a8, a1, 0
	s32i.n	a8, a2, 0
	retw.n
.LBB1_2:
	l32i.n	a11, a1, 20
	l32r	a8, .LCPI1_2
	mov.n	a12, a5
	callx8	a8
.Lfunc_end1:
	.size	_ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h9c39bd364b5704beE, .Lfunc_end1-_ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h9c39bd364b5704beE

	.literal_position
	.literal .LCPI2_0, _ZN3std4sync4mpmc5array16Channel$LT$T$GT$13with_capacity17h6a73e04737d51ce6E
	.literal .LCPI2_1, _ZN3std4sync4mpmc7counter3new17hbdbc8ad0b6c40e29E
	.literal .LCPI2_2, _ZN3std4sync4mpmc7counter3new17hbaa2a909b5758324E
	.section	.text._ZN3std4sync4mpmc12sync_channel17h9e3c03da2dc31653E,"ax",@progbits
	.global	_ZN3std4sync4mpmc12sync_channel17h9e3c03da2dc31653E
	.p2align	2
	.type	_ZN3std4sync4mpmc12sync_channel17h9e3c03da2dc31653E,@function
_ZN3std4sync4mpmc12sync_channel17h9e3c03da2dc31653E:
	entry	a1, 416
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a1, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	beqz	a3, .LBB2_2
	addi	a7, a1, 64
	l32r	a8, .LCPI2_0
	mov.n	a10, a7
	mov.n	a11, a3
	callx8	a8
	l32r	a8, .LCPI2_1
	mov.n	a10, a7
	callx8	a8
	movi.n	a8, 0
	j	.LBB2_3
.LBB2_2:
	movi.n	a8, 0
	s8i	a8, a1, 116
	s32i	a8, a1, 112
	movi.n	a9, 4
	s32i	a9, a1, 108
	s32i	a8, a1, 104
	s32i	a8, a1, 100
	s32i	a9, a1, 96
	s32i	a8, a1, 92
	s32i	a8, a1, 88
	s32i	a9, a1, 84
	s32i	a8, a1, 80
	s32i	a8, a1, 76
	s32i	a9, a1, 72
	s32i	a8, a1, 68
	s32i	a8, a1, 64
	addi	a10, a1, 64
	l32r	a8, .LCPI2_2
	callx8	a8
	movi.n	a8, 2
.LBB2_3:
	s32i.n	a8, a2, 8
	s32i.n	a10, a2, 4
	s32i.n	a8, a2, 0
	s32i.n	a11, a2, 12
	retw.n
.Lfunc_end2:
	.size	_ZN3std4sync4mpmc12sync_channel17h9e3c03da2dc31653E, .Lfunc_end2-_ZN3std4sync4mpmc12sync_channel17h9e3c03da2dc31653E

	.section	".text._ZN3std4sync4mpmc4list16Channel$LT$T$GT$3new17h9645fd22fdcfeb67E","ax",@progbits
	.global	_ZN3std4sync4mpmc4list16Channel$LT$T$GT$3new17h9645fd22fdcfeb67E
	.p2align	2
	.type	_ZN3std4sync4mpmc4list16Channel$LT$T$GT$3new17h9645fd22fdcfeb67E,@function
_ZN3std4sync4mpmc4list16Channel$LT$T$GT$3new17h9645fd22fdcfeb67E:
	entry	a1, 32
	movi.n	a8, 0
	s32i	a8, a2, 68
	s32i	a8, a2, 64
	s32i.n	a8, a2, 4
	s32i.n	a8, a2, 0
	movi.n	a9, 1
	s8i	a9, a2, 156
	s32i	a8, a2, 152
	movi.n	a9, 4
	s32i	a9, a2, 148
	s32i	a8, a2, 144
	s32i	a8, a2, 140
	s32i	a9, a2, 136
	s32i	a8, a2, 132
	s32i	a8, a2, 128
	retw.n
.Lfunc_end3:
	.size	_ZN3std4sync4mpmc4list16Channel$LT$T$GT$3new17h9645fd22fdcfeb67E, .Lfunc_end3-_ZN3std4sync4mpmc4list16Channel$LT$T$GT$3new17h9645fd22fdcfeb67E

	.section	".text._ZN3std4sync4mpmc4zero16Channel$LT$T$GT$3new17h930f88ab367c7674E","ax",@progbits
	.global	_ZN3std4sync4mpmc4zero16Channel$LT$T$GT$3new17h930f88ab367c7674E
	.p2align	2
	.type	_ZN3std4sync4mpmc4zero16Channel$LT$T$GT$3new17h930f88ab367c7674E,@function
_ZN3std4sync4mpmc4zero16Channel$LT$T$GT$3new17h930f88ab367c7674E:
	entry	a1, 32
	movi.n	a8, 0
	s8i	a8, a2, 52
	s32i.n	a8, a2, 48
	movi.n	a9, 4
	s32i.n	a9, a2, 44
	s32i.n	a8, a2, 40
	s32i.n	a8, a2, 36
	s32i.n	a9, a2, 32
	s32i.n	a8, a2, 28
	s32i.n	a8, a2, 24
	s32i.n	a9, a2, 20
	s32i.n	a8, a2, 16
	s32i.n	a8, a2, 12
	s32i.n	a9, a2, 8
	s32i.n	a8, a2, 4
	s32i.n	a8, a2, 0
	retw.n
.Lfunc_end4:
	.size	_ZN3std4sync4mpmc4zero16Channel$LT$T$GT$3new17h930f88ab367c7674E, .Lfunc_end4-_ZN3std4sync4mpmc4zero16Channel$LT$T$GT$3new17h930f88ab367c7674E

	.literal_position
	.literal .LCPI5_0, _ZN5alloc5boxed4iter117_$LT$impl$u20$core..iter..traits..collect..FromIterator$LT$I$GT$$u20$for$u20$alloc..boxed..Box$LT$$u5b$I$u5d$$GT$$GT$9from_iter17he6b94ea8b42568abE
	.literal .LCPI5_1, .Lanon.1480270bc37766ba845fc6673a0d7792.1
	.literal .LCPI5_2, .Lanon.1480270bc37766ba845fc6673a0d7792.3
	.literal .LCPI5_3, _ZN4core9panicking9panic_fmt17hbd538b14efdce7c8E
	.section	".text._ZN3std4sync4mpmc5array16Channel$LT$T$GT$13with_capacity17h6a73e04737d51ce6E","ax",@progbits
	.global	_ZN3std4sync4mpmc5array16Channel$LT$T$GT$13with_capacity17h6a73e04737d51ce6E
	.p2align	2
	.type	_ZN3std4sync4mpmc5array16Channel$LT$T$GT$13with_capacity17h6a73e04737d51ce6E,@function
_ZN3std4sync4mpmc5array16Channel$LT$T$GT$13with_capacity17h6a73e04737d51ce6E:
	entry	a1, 64
	beqz	a3, .LBB5_4
	movi.n	a7, 0
	l32r	a8, .LCPI5_0
	mov.n	a10, a7
	mov.n	a11, a3
	callx8	a8
	s32i	a11, a2, 208
	s32i	a10, a2, 204
	s32i	a7, a2, 64
	s32i.n	a7, a2, 0
	s32i	a3, a2, 192
	movi.n	a8, 1
	s8i	a8, a2, 188
	s32i	a7, a2, 184
	movi.n	a9, 4
	s32i	a9, a2, 180
	s32i	a7, a2, 176
	s32i	a7, a2, 172
	s32i	a9, a2, 168
	s32i	a7, a2, 164
	s32i	a7, a2, 160
	s8i	a8, a2, 156
	s32i	a7, a2, 152
	s32i	a9, a2, 148
	s32i	a7, a2, 144
	s32i	a7, a2, 140
	s32i	a9, a2, 136
	s32i	a7, a2, 132
	s32i	a7, a2, 128
	nsau	a9, a3
	movi.n	a10, -1
	ssr	a9
	srl	a9, a10
	beq	a3, a10, .LBB5_3
	addi.n	a8, a9, 1
.LBB5_3:
	s32i	a8, a2, 200
	_slli	a8, a8, 1
	s32i	a8, a2, 196
	retw.n
.LBB5_4:
	movi.n	a8, 0
	s32i.n	a8, a1, 16
	movi.n	a9, 1
	s32i.n	a9, a1, 4
	l32r	a9, .LCPI5_1
	s32i.n	a9, a1, 0
	s32i.n	a8, a1, 12
	movi.n	a8, 4
	s32i.n	a8, a1, 8
	addi	a10, a1, 0
	l32r	a11, .LCPI5_2
	l32r	a8, .LCPI5_3
	callx8	a8
.Lfunc_end5:
	.size	_ZN3std4sync4mpmc5array16Channel$LT$T$GT$13with_capacity17h6a73e04737d51ce6E, .Lfunc_end5-_ZN3std4sync4mpmc5array16Channel$LT$T$GT$13with_capacity17h6a73e04737d51ce6E

	.literal_position
	.literal .LCPI6_0, _ZN3std4sync4mpmc7counter3new17h45277d70dc14b19bE
	.section	.text._ZN3std4sync4mpmc7channel17h41a5277f090d021bE,"ax",@progbits
	.global	_ZN3std4sync4mpmc7channel17h41a5277f090d021bE
	.p2align	2
	.type	_ZN3std4sync4mpmc7channel17h41a5277f090d021bE,@function
_ZN3std4sync4mpmc7channel17h41a5277f090d021bE:
	entry	a1, 352
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a1, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	movi.n	a8, 0
	s32i	a8, a1, 132
	s32i	a8, a1, 128
	s32i	a8, a1, 68
	s32i	a8, a1, 64
	movi.n	a7, 1
	s8i	a7, a1, 220
	s32i	a8, a1, 216
	movi.n	a9, 4
	s32i	a9, a1, 212
	s32i	a8, a1, 208
	s32i	a8, a1, 204
	s32i	a9, a1, 200
	s32i	a8, a1, 196
	s32i	a8, a1, 192
	addi	a10, a1, 64
	l32r	a8, .LCPI6_0
	callx8	a8
	s32i.n	a11, a2, 12
	s32i.n	a7, a2, 8
	s32i.n	a10, a2, 4
	s32i.n	a7, a2, 0
	retw.n
.Lfunc_end6:
	.size	_ZN3std4sync4mpmc7channel17h41a5277f090d021bE, .Lfunc_end6-_ZN3std4sync4mpmc7channel17h41a5277f090d021bE

	.literal_position
	.literal .LCPI7_0, _ZN5alloc5alloc15exchange_malloc17hff59d1b301acb397E
	.literal .LCPI7_1, memcpy
	.section	.text._ZN3std4sync4mpmc7counter3new17h45277d70dc14b19bE,"ax",@progbits
	.global	_ZN3std4sync4mpmc7counter3new17h45277d70dc14b19bE
	.p2align	2
	.type	_ZN3std4sync4mpmc7counter3new17h45277d70dc14b19bE,@function
_ZN3std4sync4mpmc7counter3new17h45277d70dc14b19bE:
	entry	a1, 32
	movi	a10, 256
	movi.n	a11, 64
	l32r	a8, .LCPI7_0
	callx8	a8
	mov.n	a3, a10
	movi	a12, 192
	l32r	a8, .LCPI7_1
	mov.n	a11, a2
	callx8	a8
	movi.n	a8, 0
	s8i	a8, a3, 200
	movi.n	a8, 1
	s32i	a8, a3, 196
	s32i	a8, a3, 192
	mov.n	a2, a3
	retw.n
.Lfunc_end7:
	.size	_ZN3std4sync4mpmc7counter3new17h45277d70dc14b19bE, .Lfunc_end7-_ZN3std4sync4mpmc7counter3new17h45277d70dc14b19bE

	.literal_position
	.literal .LCPI8_0, _ZN5alloc5alloc15exchange_malloc17hff59d1b301acb397E
	.literal .LCPI8_1, memcpy
	.section	.text._ZN3std4sync4mpmc7counter3new17hbaa2a909b5758324E,"ax",@progbits
	.global	_ZN3std4sync4mpmc7counter3new17hbaa2a909b5758324E
	.p2align	2
	.type	_ZN3std4sync4mpmc7counter3new17hbaa2a909b5758324E,@function
_ZN3std4sync4mpmc7counter3new17hbaa2a909b5758324E:
	entry	a1, 32
	movi.n	a10, 68
	movi.n	a11, 4
	l32r	a8, .LCPI8_0
	callx8	a8
	mov.n	a3, a10
	movi.n	a12, 56
	l32r	a8, .LCPI8_1
	mov.n	a11, a2
	callx8	a8
	movi.n	a8, 0
	s8i	a8, a3, 64
	movi.n	a8, 1
	s32i.n	a8, a3, 60
	s32i.n	a8, a3, 56
	mov.n	a2, a3
	retw.n
.Lfunc_end8:
	.size	_ZN3std4sync4mpmc7counter3new17hbaa2a909b5758324E, .Lfunc_end8-_ZN3std4sync4mpmc7counter3new17hbaa2a909b5758324E

	.literal_position
	.literal .LCPI9_0, _ZN5alloc5alloc15exchange_malloc17hff59d1b301acb397E
	.literal .LCPI9_1, memcpy
	.section	.text._ZN3std4sync4mpmc7counter3new17hbdbc8ad0b6c40e29E,"ax",@progbits
	.global	_ZN3std4sync4mpmc7counter3new17hbdbc8ad0b6c40e29E
	.p2align	2
	.type	_ZN3std4sync4mpmc7counter3new17hbdbc8ad0b6c40e29E,@function
_ZN3std4sync4mpmc7counter3new17hbdbc8ad0b6c40e29E:
	entry	a1, 32
	movi	a10, 320
	movi.n	a11, 64
	l32r	a8, .LCPI9_0
	callx8	a8
	mov.n	a3, a10
	movi	a12, 256
	l32r	a8, .LCPI9_1
	mov.n	a11, a2
	callx8	a8
	movi	a8, 264
	add.n	a8, a3, a8
	movi.n	a9, 0
	s8i	a9, a8, 0
	movi.n	a8, 1
	s32i	a8, a3, 260
	s32i	a8, a3, 256
	mov.n	a2, a3
	retw.n
.Lfunc_end9:
	.size	_ZN3std4sync4mpmc7counter3new17hbdbc8ad0b6c40e29E, .Lfunc_end9-_ZN3std4sync4mpmc7counter3new17hbdbc8ad0b6c40e29E

	.literal_position
	.literal .LCPI10_0, _ZN3std4sync4mpmc12sync_channel17h9e3c03da2dc31653E
	.section	.text._ZN3std4sync4mpsc12sync_channel17h7ebc3674c83df037E,"ax",@progbits
	.global	_ZN3std4sync4mpsc12sync_channel17h7ebc3674c83df037E
	.p2align	2
	.type	_ZN3std4sync4mpsc12sync_channel17h7ebc3674c83df037E,@function
_ZN3std4sync4mpsc12sync_channel17h7ebc3674c83df037E:
	entry	a1, 48
	addi	a10, a1, 0
	l32r	a8, .LCPI10_0
	mov.n	a11, a3
	callx8	a8
	l32i.n	a8, a1, 0
	l32i.n	a9, a1, 4
	l32i.n	a10, a1, 8
	l32i.n	a11, a1, 12
	s32i.n	a11, a2, 12
	s32i.n	a10, a2, 8
	s32i.n	a9, a2, 4
	s32i.n	a8, a2, 0
	retw.n
.Lfunc_end10:
	.size	_ZN3std4sync4mpsc12sync_channel17h7ebc3674c83df037E, .Lfunc_end10-_ZN3std4sync4mpsc12sync_channel17h7ebc3674c83df037E

	.literal_position
	.literal .LCPI11_0, _ZN3std4sync4mpmc7channel17h41a5277f090d021bE
	.section	.text._ZN3std4sync4mpsc7channel17h0bec0d4f8e7e5b2dE,"ax",@progbits
	.global	_ZN3std4sync4mpsc7channel17h0bec0d4f8e7e5b2dE
	.p2align	2
	.type	_ZN3std4sync4mpsc7channel17h0bec0d4f8e7e5b2dE,@function
_ZN3std4sync4mpsc7channel17h0bec0d4f8e7e5b2dE:
	entry	a1, 48
	addi	a10, a1, 0
	l32r	a8, .LCPI11_0
	callx8	a8
	l32i.n	a8, a1, 0
	l32i.n	a9, a1, 4
	l32i.n	a10, a1, 8
	l32i.n	a11, a1, 12
	s32i.n	a11, a2, 12
	s32i.n	a10, a2, 8
	s32i.n	a9, a2, 4
	s32i.n	a8, a2, 0
	retw.n
.Lfunc_end11:
	.size	_ZN3std4sync4mpsc7channel17h0bec0d4f8e7e5b2dE, .Lfunc_end11-_ZN3std4sync4mpsc7channel17h0bec0d4f8e7e5b2dE

	.literal_position
	.literal .LCPI12_0, _ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h47512f86352cc2f1E
	.literal .LCPI12_1, _ZN102_$LT$core..iter..adapters..map..Map$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4fold17h38326d16241098c0E
	.section	".text._ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17he2a741e20a088a25E","ax",@progbits
	.global	_ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17he2a741e20a088a25E
	.p2align	2
	.type	_ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17he2a741e20a088a25E,@function
_ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17he2a741e20a088a25E:
	entry	a1, 48
	maxu	a8, a4, a3
	sub	a11, a8, a3
	l32r	a8, .LCPI12_0
	mov.n	a10, a2
	callx8	a8
	l32i.n	a8, a2, 4
	l32i.n	a9, a2, 8
	s32i.n	a9, a1, 4
	addi.n	a9, a2, 8
	s32i.n	a9, a1, 0
	s32i.n	a8, a1, 8
	addi	a12, a1, 0
	l32r	a8, .LCPI12_1
	mov.n	a10, a3
	mov.n	a11, a4
	callx8	a8
	retw.n
.Lfunc_end12:
	.size	_ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17he2a741e20a088a25E, .Lfunc_end12-_ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17he2a741e20a088a25E

	.literal_position
	.literal .LCPI13_0, _ZN5alloc7raw_vec20RawVecInner$LT$A$GT$16shrink_unchecked17hc6c47883b41eb6edE
	.literal .LCPI13_1, -2147483647
	.literal .LCPI13_2, _ZN5alloc7raw_vec12handle_error17hbfccafac19cfbb21E
	.section	".text._ZN5alloc3vec16Vec$LT$T$C$A$GT$16into_boxed_slice17h126e7fed49ded38dE","ax",@progbits
	.global	_ZN5alloc3vec16Vec$LT$T$C$A$GT$16into_boxed_slice17h126e7fed49ded38dE
	.p2align	2
	.type	_ZN5alloc3vec16Vec$LT$T$C$A$GT$16into_boxed_slice17h126e7fed49ded38dE,@function
_ZN5alloc3vec16Vec$LT$T$C$A$GT$16into_boxed_slice17h126e7fed49ded38dE:
	entry	a1, 32
	l32i.n	a11, a2, 8
	l32i.n	a8, a2, 0
	bgeu	a11, a8, .LBB13_3
	movi.n	a12, 4
	movi.n	a13, 8
	l32r	a8, .LCPI13_0
	mov.n	a10, a2
	callx8	a8
	l32r	a8, .LCPI13_1
	bne	a10, a8, .LBB13_4
	l32i.n	a11, a2, 8
.LBB13_3:
	l32i.n	a2, a2, 4
	mov.n	a3, a11
	retw.n
.LBB13_4:
	l32r	a8, .LCPI13_2
	mov.n	a12, a3
	callx8	a8
.Lfunc_end13:
	.size	_ZN5alloc3vec16Vec$LT$T$C$A$GT$16into_boxed_slice17h126e7fed49ded38dE, .Lfunc_end13-_ZN5alloc3vec16Vec$LT$T$C$A$GT$16into_boxed_slice17h126e7fed49ded38dE

	.literal_position
	.literal .LCPI14_0, _ZN5alloc7raw_vec20RawVecInner$LT$A$GT$7reserve21do_reserve_and_handle17h6b6b6ee2568f8818E
	.section	".text._ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h47512f86352cc2f1E","ax",@progbits
	.global	_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h47512f86352cc2f1E
	.p2align	2
	.type	_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h47512f86352cc2f1E,@function
_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h47512f86352cc2f1E:
	entry	a1, 32
	l32i.n	a11, a2, 8
	l32i.n	a8, a2, 0
	sub	a8, a8, a11
	bltu	a8, a3, .LBB14_2
	retw.n
.LBB14_2:
	movi.n	a13, 4
	movi.n	a14, 8
	l32r	a8, .LCPI14_0
	mov.n	a10, a2
	mov.n	a12, a3
	callx8	a8
	retw.n
.Lfunc_end14:
	.size	_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h47512f86352cc2f1E, .Lfunc_end14-_ZN5alloc3vec16Vec$LT$T$C$A$GT$7reserve17h47512f86352cc2f1E

	.literal_position
	.literal .LCPI15_0, __rust_no_alloc_shim_is_unstable
	.literal .LCPI15_1, _RNvCs6MjFWaQOJWH_7___rustc12___rust_alloc
	.literal .LCPI15_2, _ZN5alloc5alloc18handle_alloc_error17he3812dc82e565942E
	.section	.text._ZN5alloc5alloc15exchange_malloc17hff59d1b301acb397E,"ax",@progbits
	.p2align	2
	.type	_ZN5alloc5alloc15exchange_malloc17hff59d1b301acb397E,@function
_ZN5alloc5alloc15exchange_malloc17hff59d1b301acb397E:
	entry	a1, 32
	beqz	a2, .LBB15_3
	l32r	a8, .LCPI15_0
	memw
	l8ui	a8, a8, 0
	l32r	a8, .LCPI15_1
	mov.n	a10, a2
	mov.n	a11, a3
	callx8	a8
	beqz	a10, .LBB15_4
.LBB15_2:
	mov.n	a2, a10
	retw.n
.LBB15_3:
	mov.n	a10, a3
	bnez	a10, .LBB15_2
.LBB15_4:
	l32r	a8, .LCPI15_2
	mov.n	a10, a3
	mov.n	a11, a2
	callx8	a8
.Lfunc_end15:
	.size	_ZN5alloc5alloc15exchange_malloc17hff59d1b301acb397E, .Lfunc_end15-_ZN5alloc5alloc15exchange_malloc17hff59d1b301acb397E

	.literal_position
	.literal .LCPI16_0, .Lanon.1480270bc37766ba845fc6673a0d7792.5
	.literal .LCPI16_1, _ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h9c39bd364b5704beE
	.literal .LCPI16_2, .Lanon.1480270bc37766ba845fc6673a0d7792.7
	.literal .LCPI16_3, _ZN5alloc3vec16Vec$LT$T$C$A$GT$16into_boxed_slice17h126e7fed49ded38dE
	.section	".text._ZN5alloc5boxed4iter117_$LT$impl$u20$core..iter..traits..collect..FromIterator$LT$I$GT$$u20$for$u20$alloc..boxed..Box$LT$$u5b$I$u5d$$GT$$GT$9from_iter17he6b94ea8b42568abE","ax",@progbits
	.global	_ZN5alloc5boxed4iter117_$LT$impl$u20$core..iter..traits..collect..FromIterator$LT$I$GT$$u20$for$u20$alloc..boxed..Box$LT$$u5b$I$u5d$$GT$$GT$9from_iter17he6b94ea8b42568abE
	.p2align	2
	.type	_ZN5alloc5boxed4iter117_$LT$impl$u20$core..iter..traits..collect..FromIterator$LT$I$GT$$u20$for$u20$alloc..boxed..Box$LT$$u5b$I$u5d$$GT$$GT$9from_iter17he6b94ea8b42568abE,@function
_ZN5alloc5boxed4iter117_$LT$impl$u20$core..iter..traits..collect..FromIterator$LT$I$GT$$u20$for$u20$alloc..boxed..Box$LT$$u5b$I$u5d$$GT$$GT$9from_iter17he6b94ea8b42568abE:
	entry	a1, 48
	addi	a7, a1, 0
	l32r	a13, .LCPI16_0
	l32r	a8, .LCPI16_1
	mov.n	a10, a7
	mov.n	a11, a2
	mov.n	a12, a3
	callx8	a8
	l32r	a11, .LCPI16_2
	l32r	a8, .LCPI16_3
	mov.n	a10, a7
	callx8	a8
	mov.n	a2, a10
	mov.n	a3, a11
	retw.n
.Lfunc_end16:
	.size	_ZN5alloc5boxed4iter117_$LT$impl$u20$core..iter..traits..collect..FromIterator$LT$I$GT$$u20$for$u20$alloc..boxed..Box$LT$$u5b$I$u5d$$GT$$GT$9from_iter17he6b94ea8b42568abE, .Lfunc_end16-_ZN5alloc5boxed4iter117_$LT$impl$u20$core..iter..traits..collect..FromIterator$LT$I$GT$$u20$for$u20$alloc..boxed..Box$LT$$u5b$I$u5d$$GT$$GT$9from_iter17he6b94ea8b42568abE

	.section	".text._ZN5alloc7raw_vec15RawVec$LT$T$GT$3new17h16054741bd10469bE","ax",@progbits
	.global	_ZN5alloc7raw_vec15RawVec$LT$T$GT$3new17h16054741bd10469bE
	.p2align	2
	.type	_ZN5alloc7raw_vec15RawVec$LT$T$GT$3new17h16054741bd10469bE,@function
_ZN5alloc7raw_vec15RawVec$LT$T$GT$3new17h16054741bd10469bE:
	entry	a1, 32
	movi.n	a2, 0
	movi.n	a3, 4
	retw.n
.Lfunc_end17:
	.size	_ZN5alloc7raw_vec15RawVec$LT$T$GT$3new17h16054741bd10469bE, .Lfunc_end17-_ZN5alloc7raw_vec15RawVec$LT$T$GT$3new17h16054741bd10469bE

	.section	".text._ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$8into_box17h58368f748e32d1f0E","ax",@progbits
	.global	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$8into_box17h58368f748e32d1f0E
	.p2align	2
	.type	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$8into_box17h58368f748e32d1f0E,@function
_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$8into_box17h58368f748e32d1f0E:
	entry	a1, 32
	mov.n	a2, a3
	mov.n	a3, a4
	retw.n
.Lfunc_end18:
	.size	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$8into_box17h58368f748e32d1f0E, .Lfunc_end18-_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$8into_box17h58368f748e32d1f0E

	.literal_position
	.literal .LCPI19_0, _ZN5alloc3vec16Vec$LT$T$C$A$GT$14extend_trusted17he2a741e20a088a25E
	.section	".text._ZN97_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$I$GT$$GT$11spec_extend17h85d5b49769358198E","ax",@progbits
	.global	_ZN97_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$I$GT$$GT$11spec_extend17h85d5b49769358198E
	.p2align	2
	.type	_ZN97_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$I$GT$$GT$11spec_extend17h85d5b49769358198E,@function
_ZN97_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$I$GT$$GT$11spec_extend17h85d5b49769358198E:
	entry	a1, 32
	l32r	a8, .LCPI19_0
	mov.n	a10, a2
	mov.n	a11, a3
	mov.n	a12, a4
	mov.n	a13, a5
	callx8	a8
	retw.n
.Lfunc_end19:
	.size	_ZN97_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$I$GT$$GT$11spec_extend17h85d5b49769358198E, .Lfunc_end19-_ZN97_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$alloc..vec..spec_extend..SpecExtend$LT$T$C$I$GT$$GT$11spec_extend17h85d5b49769358198E

	.literal_position
	.literal .LCPI20_0, _ZN111_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter_nested..SpecFromIterNested$LT$T$C$I$GT$$GT$9from_iter17h9c39bd364b5704beE
	.section	".text._ZN98_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$I$GT$$GT$9from_iter17hadfd5f725e57b16aE","ax",@progbits
	.global	_ZN98_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$I$GT$$GT$9from_iter17hadfd5f725e57b16aE
	.p2align	2
	.type	_ZN98_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$I$GT$$GT$9from_iter17hadfd5f725e57b16aE,@function
_ZN98_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$I$GT$$GT$9from_iter17hadfd5f725e57b16aE:
	entry	a1, 32
	l32r	a8, .LCPI20_0
	mov.n	a10, a2
	mov.n	a11, a3
	mov.n	a12, a4
	mov.n	a13, a5
	callx8	a8
	retw.n
.Lfunc_end20:
	.size	_ZN98_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$I$GT$$GT$9from_iter17hadfd5f725e57b16aE, .Lfunc_end20-_ZN98_$LT$alloc..vec..Vec$LT$T$GT$$u20$as$u20$alloc..vec..spec_from_iter..SpecFromIter$LT$T$C$I$GT$$GT$9from_iter17hadfd5f725e57b16aE

	.literal_position
	.literal .LCPI21_0, _ZN3std4sync4mpsc12sync_channel17h7ebc3674c83df037E
	.section	.text.make_sync_channel,"ax",@progbits
	.global	make_sync_channel
	.p2align	2
	.type	make_sync_channel,@function
make_sync_channel:
	entry	a1, 32
	movi.n	a11, 4
	l32r	a8, .LCPI21_0
	mov.n	a10, a2
	callx8	a8
	retw.n
.Lfunc_end21:
	.size	make_sync_channel, .Lfunc_end21-make_sync_channel

	.literal_position
	.literal .LCPI22_0, _ZN3std4sync4mpsc7channel17h0bec0d4f8e7e5b2dE
	.section	.text.make_channel,"ax",@progbits
	.global	make_channel
	.p2align	2
	.type	make_channel,@function
make_channel:
	entry	a1, 32
	l32r	a8, .LCPI22_0
	mov.n	a10, a2
	callx8	a8
	retw.n
.Lfunc_end22:
	.size	make_channel, .Lfunc_end22-make_channel

	.type	.Lanon.1480270bc37766ba845fc6673a0d7792.0,@object
	.section	.rodata..Lanon.1480270bc37766ba845fc6673a0d7792.0,"a",@progbits
.Lanon.1480270bc37766ba845fc6673a0d7792.0:
	.ascii	"capacity must be positive"
	.size	.Lanon.1480270bc37766ba845fc6673a0d7792.0, 25

	.type	.Lanon.1480270bc37766ba845fc6673a0d7792.1,@object
	.section	.rodata..Lanon.1480270bc37766ba845fc6673a0d7792.1,"a",@progbits
	.p2align	2, 0x0
.Lanon.1480270bc37766ba845fc6673a0d7792.1:
	.word	.Lanon.1480270bc37766ba845fc6673a0d7792.0
	.asciz	"\031\000\000"
	.size	.Lanon.1480270bc37766ba845fc6673a0d7792.1, 8

	.type	.Lanon.1480270bc37766ba845fc6673a0d7792.2,@object
	.section	.rodata..Lanon.1480270bc37766ba845fc6673a0d7792.2,"a",@progbits
.Lanon.1480270bc37766ba845fc6673a0d7792.2:
	.ascii	"~/.rustup/toolchains/esp/lib/rustlib/src/rust/library/std/src/sync/mpmc/array.rs"
	.size	.Lanon.1480270bc37766ba845fc6673a0d7792.2, 102

	.type	.Lanon.1480270bc37766ba845fc6673a0d7792.3,@object
	.section	.rodata..Lanon.1480270bc37766ba845fc6673a0d7792.3,"a",@progbits
	.p2align	2, 0x0
.Lanon.1480270bc37766ba845fc6673a0d7792.3:
	.word	.Lanon.1480270bc37766ba845fc6673a0d7792.2
	.asciz	"f\000\000\000[\000\000\000\t\000\000"
	.size	.Lanon.1480270bc37766ba845fc6673a0d7792.3, 16

	.type	.Lanon.1480270bc37766ba845fc6673a0d7792.4,@object
	.section	.rodata..Lanon.1480270bc37766ba845fc6673a0d7792.4,"a",@progbits
.Lanon.1480270bc37766ba845fc6673a0d7792.4:
	.ascii	"~/.rustup/toolchains/esp/lib/rustlib/src/rust/library/core/src/iter/traits/iterator.rs"
	.size	.Lanon.1480270bc37766ba845fc6673a0d7792.4, 108

	.type	.Lanon.1480270bc37766ba845fc6673a0d7792.5,@object
	.section	.rodata..Lanon.1480270bc37766ba845fc6673a0d7792.5,"a",@progbits
	.p2align	2, 0x0
.Lanon.1480270bc37766ba845fc6673a0d7792.5:
	.word	.Lanon.1480270bc37766ba845fc6673a0d7792.4
	.asciz	"l\000\000\000\321\007\000\000\t\000\000"
	.size	.Lanon.1480270bc37766ba845fc6673a0d7792.5, 16

	.type	.Lanon.1480270bc37766ba845fc6673a0d7792.6,@object
	.section	.rodata..Lanon.1480270bc37766ba845fc6673a0d7792.6,"a",@progbits
.Lanon.1480270bc37766ba845fc6673a0d7792.6:
	.ascii	"~/.rustup/toolchains/esp/lib/rustlib/src/rust/library/alloc/src/boxed/iter.rs"
	.size	.Lanon.1480270bc37766ba845fc6673a0d7792.6, 99

	.type	.Lanon.1480270bc37766ba845fc6673a0d7792.7,@object
	.section	.rodata..Lanon.1480270bc37766ba845fc6673a0d7792.7,"a",@progbits
	.p2align	2, 0x0
.Lanon.1480270bc37766ba845fc6673a0d7792.7:
	.word	.Lanon.1480270bc37766ba845fc6673a0d7792.6
	.asciz	"c\000\000\000\220\000\000\000.\000\000"
	.size	.Lanon.1480270bc37766ba845fc6673a0d7792.7, 16

	.ident	"rustc version 1.88.0-nightly (2ab28d2e7 2025-06-24) (1.88.0.0)"
	.section	".note.GNU-stack","",@progbits
