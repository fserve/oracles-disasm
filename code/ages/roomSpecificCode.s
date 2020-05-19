;;
; @addr{5872}
runRoomSpecificCode: ; 5872
	ld a,(wActiveRoom)
	ld hl, _roomSpecificCodeGroupTable
	call findRoomSpecificData
	ret nc
	rst_jumpTable
.dw _roomSpecificCode0
.dw _roomSpecificCode1
.dw _roomSpecificCode2
.dw _roomSpecificCode3
.dw _roomSpecificCode4
.dw _roomSpecificCode5
.dw setDeathRespawnPoint
.dw _roomSpecificCode7
.dw _roomSpecificCode8
.dw _roomSpecificCode9
.dw _roomSpecificCodeA
.dw _roomSpecificCodeB
.dw _roomSpecificCodeC

	; Random stub not called by anything?
	ret			; 5897

_roomSpecificCodeGroupTable: ; 5898
	.dw _roomSpecificCodeGroup0Table
	.dw _roomSpecificCodeGroup1Table
	.dw _roomSpecificCodeGroup2Table
	.dw _roomSpecificCodeGroup3Table
	.dw _roomSpecificCodeGroup4Table
	.dw _roomSpecificCodeGroup5Table
	.dw _roomSpecificCodeGroup6Table
	.dw _roomSpecificCodeGroup7Table

; Format: room index

_roomSpecificCodeGroup0Table: ; 58a8
	.db $93 $00
	.db $38 $06
	.db $39 $08
	.db $3a $09
	.db $00
_roomSpecificCodeGroup1Table: ; 58b1
	.db $81 $03
	.db $38 $06
	.db $97 $07
	.db $0e $0a
	.db $00
_roomSpecificCodeGroup2Table: ; 58ba
	.db $0e $05
	.db $00
_roomSpecificCodeGroup3Table: ; 58bd
	.db $0f $0b
	.db $00
_roomSpecificCodeGroup4Table: ; 58c0
	.db $60 $01
	.db $52 $02
	.db $e6 $0c
	.db $00
_roomSpecificCodeGroup5Table: ; 58c7
	.db $d2 $04
_roomSpecificCodeGroup6Table:
_roomSpecificCodeGroup7Table: ; 58c9
	.db $00

;;
; @addr{58ca}
_roomSpecificCode0: ; 58ca
	ld a,GLOBALFLAG_WON_FAIRY_HIDING_GAME
	call checkGlobalFlag
	ret nz
	ld hl,$cfd0
	ld b,$10
	jp clearMemory

;;
; @addr{5cd8}
_roomSpecificCode1: ; 5cd8
	ld a, GLOBALFLAG_D3_CRYSTALS
	call checkGlobalFlag
	ret nz
---
	; Create spinner object
	call getFreeInteractionSlot
	ret nz
	ld (hl),$7d
	ld l,Interaction.yh
	ld (hl),$57
	ld l,Interaction.xh
	ld (hl),$01
	ret

;;
; @addr{58ed}
_roomSpecificCode2: ; 58ed
	ld a,GLOBALFLAG_D3_CRYSTALS
	call checkGlobalFlag
	ret z
	; Create spinner if the flag is UNset
	jr ---

;;
; @addr{58f5}
_roomSpecificCode3: ; 58f5
	call getThisRoomFlags
	bit 6,a
	ret nz
	ld a,TREASURE_MYSTERY_SEEDS
	call checkTreasureObtained
	ret nc
	ld hl,wcc05
	res 1,(hl)
	call getFreeInteractionSlot
	ret nz
	ld (hl),$40
	inc l
	ld (hl),$0a
	ld a,$01
	ld (wDiggingUpEnemiesForbidden),a
	ret

;;
; @addr{5915}
_roomSpecificCode7: ; 5915
	ld a,GLOBALFLAG_GAVE_ROPE_TO_RAFTON
	call checkGlobalFlag
	ret z
	call getThisRoomFlags
	bit 6,a
	ret nz
.ifdef ROM_AGES
	ld a,MUS_RALPH
.else
	ld a,$35
.endif
	ld (wActiveMusic2),a
	ret

;;
; @addr{5927}
_roomSpecificCode5: ; 5927
	ld a,GLOBALFLAG_SAVED_NAYRU
	call checkGlobalFlag
	ret nz
	ld a,MUS_SADNESS
	ld (wActiveMusic2),a
	ret

;;
; Something in ambi's palace
; @addr{5933}
_roomSpecificCode4: ; 5933
	ld a,$06
	ld (wMinimapRoom),a
	ld hl,wPastRoomFlags+$06
	set 4,(hl)
	ret

;;
; Check to play ralph music for ralph entering portal cutscene
; @addr{593e}
_roomSpecificCode8: ; 593e
	ld a,(wScreenTransitionDirection)
	cp DIR_RIGHT
	ret nz
	ld a, GLOBALFLAG_RALPH_ENTERED_PORTAL
	call checkGlobalFlag
	ret nz
.ifdef ROM_AGES
	ld a, MUS_RALPH
.else
	ld a,$35
.endif
	ld (wActiveMusic2),a
	ret

;;
; Play nayru music on impa's house screen, for some reason
; @addr{5950}
_roomSpecificCode9: ; 5950
	ld a,GLOBALFLAG_FINISHEDGAME
	call checkGlobalFlag
	ret z
.ifdef ROM_AGES
	ld a, MUS_NAYRU
.else
	ld a,$08
.endif
	ld (wActiveMusic2),a
	ret

;;
; Correct minimap in mermaid's cave present
; @addr{595c}
_roomSpecificCodeA: ; 595c
	ld hl,wMinimapGroup
	ld (hl),$00
	inc l
	ld (hl),$3c
	ret

;;
; Correct minimap in mermaid's cave past
; @addr{5965}
_roomSpecificCodeB: ; 5965
	ld hl,wMinimapGroup
	ld (hl),$01
	inc l
	ld (hl),$3c
	ret

;;
; Something happening on vire black tower screen
; @addr{596e}
_roomSpecificCodeC: ; 596e
	ld hl,wActiveMusic
	ld a,(hl)
	or a
	ret nz
	ld (hl),$ff
	ret
