.ifdef BUILD_VANILLA

; Garbage data/code

	m_BreakableTileData %00000000 %00010000 %0000 $0 $df $37 ; $2f
	m_BreakableTileData %00110000 %00000000 %0000 $0 $06 $01 ; $30
	m_BreakableTileData %00100101 %00000001 %0000 $0 $06 $01 ; $31
	m_BreakableTileData %00111110 %10000000 %1011 $0 $1f $00 ; $32


_fake_specialObjectLoadAnimationFrameToBuffer:
	ld hl,w1Companion.visible
	bit 7,(hl)
	ret z

	ld l,<w1Companion.var32
	ld a,(hl)
	call $4524
	ret z

	ld a,l
	and $f0
	ld l,a
	ld de,w6SpecialObjectGfxBuffer|(:w6SpecialObjectGfxBuffer)
	jp $3f17


	ld a,(hl)
	ret z

	ld l,<w1Companion.var32
	ld a,(hl)
	call $4524
	ret z

	ld a,l
	and $f0
	ld l,a
	ld de,w6SpecialObjectGfxBuffer|(:w6SpecialObjectGfxBuffer)
	jp $3f31

.endif