realign_trigger:
	entry	a1, 160
	movi.n	a8, 63
	movi.n	a9, 64
	and	a8, a1, a8
	sub	a8, a9, a8
	add.n	a1, a1, a8
	addi	a10, a1, 0
	callx8	a8
	retw.n
