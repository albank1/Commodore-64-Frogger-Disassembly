;----------------------------------------------------------------------------
;FROGGER CARTRIDGE (1983) DISASSEMBLED CODE
;----------------------------------------------------------------------------
;To run this:
;Build: dasm froggercrt.asm -f3 -frogger.bin
;Then: cartconv -t normal -i frogger.bin -o frogger.crt
;----------------------------------------------------------------------------
;lda	#$06 NUMBER OF LIVES where #$05 is actually 4 lives (frogs)
;sta	$B3	==== STORES NO OF LIVES ===
;To change the number of lives just search for this code and change number
;stored in $B3	
;----------------------------------------------------------------------------

	processor 6502
	org $8000

;----------------------------------------------------------------------------
;Address equates for data/code that lives inside the $8000 page.
;----------------------------------------------------------------------------
W8009 = $8009
W801A = $801A
W8036 = $8036
W803F = $803F
W805E = $805E
W807E = $807E
W8082 = $8082
W8086 = $8086
W808B = $808B
W8094 = $8094
W80A9 = $80A9
W80C0 = $80C0
W80C5 = $80C5
W80C8 = $80C8
W80CC = $80CC
W80D0 = $80D0
W80D4 = $80D4
W80E3 = $80E3
W811B = $811B
W8124 = $8124
W9D6B = $9D6B
W9D6C = $9D6C

;============================================================================
;C64 CARTRIDGE AUTOSTART HEADER - This MUST be at $8000
;============================================================================
CartHeader:
	.word $8906	 ;$8000-8001: Cold start vector -> $8009
	.word $8906 		;$8002-8003: Warm start vector -> $803C
	.byte $C3,$C2,$CD		;$8004-8006: "CBM" signature bytes
	.byte $38,$30		;$8007-8008: "80" - 16K cartridge type marker

	.byte $78,$44,$C8,$44,$18,$45,$68
	.byte $45,$B8,$45,$58,$46,$A8,$46,$F8,$46,$48,$47,$20,$01,$08,$02,$50
	.byte $0D,$50,$0F,$50,$0D,$A0,$0F,$50,$0D,$50,$0A,$50,$09,$50,$0C,$50
	.byte $0F,$50,$0A,$50,$05,$00,$2E,$81,$76,$81,$BE,$81,$06,$82,$4E,$82
	.byte $AE,$82,$31,$96,$82,$31,$C6,$82,$31,$DE,$82,$31,$F6,$82,$51,$1E
	.byte $83,$80,$7E,$83,$40,$5E,$83,$40,$9E,$83,$40,$00,$00,$02,$5D,$5D
	.byte $5D,$5D,$5F,$5D,$53,$68,$5D,$5E,$5E,$5E,$5E,$5E,$5D,$5D,$5D,$55
	; Note number of lives is displayed but overwritten soon 
	;			  *** NUMBER OF LIVES DRAW TO SCREEN
	;			  $62 is 4 lives 
	.byte $5A,$59,$56,$5B,$5D,$63,$5D,$5D,$5D,$5C,$57,$58,$54,$5D,$34,$33
	.byte $37,$38,$37,$35,$36,$39,$38,$3A,$3B,$3C,$3D,$3D,$3E,$31,$31,$31
	.byte $31,$31,$31,$31,$31,$15,$05,$06,$07,$09,$0D,$0F,$12,$13,$14,$20
	.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$10,$81,$86,$8C,$8F,$93
	.byte $94,$97,$89,$8D,$85,$92,$BD,$B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8
	.byte $B9,$00,$79,$69,$71,$18,$E5,$CB,$B1,$08,$A1,$91,$81,$10,$A9,$99
	.byte $89,$24,$F1,$D7,$BD,$00,$81,$65,$49,$1C,$C5,$B1,$9D,$12,$93,$77
	.byte $5B,$26,$CF,$BB,$A7,$11,$21,$21,$12,$11,$21,$21,$11,$11,$21,$11
	.byte $12,$21,$11,$21,$41,$11,$21,$21,$11,$11,$12,$11,$41,$41,$11,$11
	.byte $12,$11,$11,$12,$12,$21,$11,$11,$11,$11,$12,$12,$11,$11,$11,$21
	.byte $11,$11,$11,$12,$11,$12,$12,$21,$21,$11,$12,$01,$00,$01,$01,$00
	.byte $01,$00,$01,$00,$2A,$38,$6A,$78,$AA,$B8,$EA,$F8,$2A,$38,$01,$07
	.byte $02,$11,$20,$00,$00,$00,$02,$02,$0B,$1A,$A9,$00,$00,$00,$01,$0D
	.byte $01,$1A,$00,$00,$00,$00,$01,$05,$02,$14,$26,$00,$00,$00,$02,$03
	.byte $10,$A0,$30,$00,$00,$00,$03,$09,$19,$00,$00,$00,$00,$00,$03,$05
	.byte $0B,$1F,$00,$00,$00,$00,$03,$05,$0E,$18,$22,$2C,$00,$00,$03,$05
	.byte $0F,$19,$23,$2D,$00,$00,$01,$07,$82,$11,$20,$00,$00,$00,$02,$02
	.byte $0B,$15,$9F,$00,$00,$00,$01,$0D,$1A,$00,$00,$00,$00,$00,$01,$05
	.byte $02,$14,$26,$00,$00,$00,$02,$03,$10,$A0,$00,$00,$00,$00,$03,$09
	.byte $0F,$1E,$00,$00,$00,$00,$03,$05,$0B,$1F,$00,$00,$00,$00,$03,$05
	.byte $0E,$18,$22,$2C,$00,$00,$03,$05,$0F,$19,$23,$2D,$00,$00,$01,$07
	.byte $82,$11,$00,$00,$00,$00,$02,$02,$0B,$15,$9F,$00,$00,$00,$01,$0D
	.byte $1A,$00,$00,$00,$00,$00,$01,$05,$02,$14,$26,$00,$00,$00,$02,$03
	.byte $10,$A0,$00,$00,$00,$00,$03,$09,$0F,$1E,$00,$00,$00,$00,$03,$05
	.byte $0B,$1F,$00,$00,$00,$00,$03,$05,$04,$0E,$18,$22,$2C,$00,$03,$05
	.byte $0F,$19,$23,$2D,$00,$00,$01,$07,$82,$11,$00,$00,$00,$00,$02,$02
	.byte $0B,$9F,$00,$00,$00,$00,$01,$0D,$1A,$00,$00,$00,$00,$00,$01,$05
	.byte $02,$14,$00,$00,$00,$00,$02,$03,$10,$A0,$00,$00,$00,$00,$03,$09
	.byte $01,$10,$1F,$00,$00,$00,$03,$05,$0B,$15,$1F,$00,$00,$00,$03,$05
	.byte $0E,$18,$22,$2C,$00,$00,$03,$05,$0F,$19,$23,$2D,$00,$00,$01,$07
	.byte $82,$00,$00,$00,$00,$00,$02,$02,$0B,$1A,$A9,$00,$00,$00,$01,$0D
	.byte $1A,$00,$00,$00,$00,$00,$01,$05,$02,$14,$00,$00,$00,$00,$02,$03
	.byte $10,$A0,$00,$00,$00,$00,$03,$09,$0F,$1E,$00,$00,$00,$00,$03,$05
	.byte $0B,$15,$1F,$00,$00,$00,$03,$05,$04,$0E,$18,$22,$2C,$00,$03,$05
	.byte $05,$0F,$19,$23,$2D,$00,$55,$95,$A5,$65,$E5,$F5,$FD,$FD,$55,$56
	.byte $55,$BF,$FF,$FF,$FF,$FF,$55,$59,$69,$56,$56,$57,$A7,$AA,$55,$56
	.byte $5A,$65,$E5,$F5,$FD,$FD,$55,$69,$65,$BF,$FF,$FF,$FF,$FF,$55,$55
	.byte $55,$55,$55,$57,$A7,$AA,$55,$55,$55,$55,$55,$D5,$F5,$F5,$55,$55
	.byte $55,$7D,$7D,$FF,$FF,$FF,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55
	.byte $55,$55,$55,$55,$51,$55,$55,$41,$55,$55,$41,$55,$55,$55,$55,$55
	.byte $55,$55,$55,$55,$45,$55,$55,$56,$5A,$5A,$6A,$6A,$6F,$6A,$55,$A6
	.byte $EA,$EA,$BA,$AA,$AF,$AA,$55,$A6,$EA,$EA,$BA,$AA,$AF,$AA,$55,$9A
	.byte $AA,$AA,$FB,$AB,$AF,$AB,$55,$B5,$FD,$FD,$EF,$AB,$AB,$BB,$00,$00
	.byte $0A,$0A,$FF,$FF,$FF,$FF,$00,$00,$A0,$A0,$FF,$FF,$FF,$FF,$00,$00
	.byte $00,$00,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$00,$00
	.byte $02,$02,$FF,$FF,$FF,$FF,$00,$00,$A8,$A8,$FF,$FF,$FF,$FF,$00,$00
	.byte $02,$0F,$CF,$CF,$DF,$DF,$00,$00,$80,$F0,$F4,$F4,$F4,$F4,$00,$AA
	.byte $AA,$AA,$28,$FC,$5F,$EF,$00,$00,$00,$00,$00,$FF,$FD,$FE,$00,$00
	.byte $AA,$AA,$A8,$FF,$F7,$DF,$00,$00,$02,$02,$00,$0F,$3F,$FF,$00,$0B
	.byte $0B,$03,$03,$0F,$3F,$3F,$00,$BB,$BB,$CF,$CF,$FF,$F7,$F5,$00,$80
	.byte $80,$00,$01,$FD,$FC,$7C,$00,$3C,$30,$7C,$70,$3C,$30,$3C,$00,$00
	.byte $80,$80,$F0,$F0,$74,$70,$00,$00,$0A,$0A,$7F,$FF,$F5,$F5,$00,$00
	.byte $80,$80,$FD,$FF,$DF,$DF,$00,$00,$02,$02,$07,$1F,$1F,$1F,$55,$55
	.byte $55,$55,$55,$55,$55,$55,$59,$6E,$AA,$55,$55,$55,$55,$55,$55,$55
	.byte $55,$55,$55,$55,$59,$5A,$6A,$AB,$AA,$56,$56,$5A,$55,$55,$55,$55
	.byte $55,$55,$59,$6A,$AA,$AB,$AA,$BA,$AA,$95,$95,$55,$55,$55,$55,$55
	.byte $55,$55,$59,$6A,$AA,$AB,$AA,$BA,$AA,$55,$55,$55,$55,$55,$55,$55
	.byte $55,$55,$55,$56,$AA,$FA,$AA,$AF,$AA,$5A,$5A,$69,$55,$55,$55,$55
	.byte $55,$65,$A9,$BA,$BA,$AA,$AA,$AB,$AA,$95,$55,$55,$55,$55,$55,$55
	.byte $55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$00,$FC
	.byte $FC,$FC,$00,$CF,$CF,$CF,$FF,$EF,$FF,$BF,$FE,$FF,$FF,$EF,$FF,$EF
	.byte $FC,$B0,$F0,$C0,$00,$00,$FF,$C3,$00,$00,$00,$00,$00,$00,$FF,$FB
	.byte $3F,$0E,$0F,$03,$00,$00,$FF,$CF,$FC,$31,$F7,$C6,$07,$03,$7B,$79
	.byte $7D,$7F,$3F,$3D,$1F,$0F,$FF,$C3,$00,$81,$E7,$66,$FF,$FF,$BD,$C3
	.byte $FF,$FF,$FF,$C3,$C3,$C3,$FF,$F3,$3F,$8C,$EF,$63,$E0,$C0,$DE,$9E
	.byte $BE,$FE,$FC,$BC,$F8,$F0,$FF,$EF,$FC,$B0,$F0,$C0,$01,$09,$1A,$2A
	.byte $1A,$09,$00,$00,$00,$00,$FF,$C3,$00,$05,$15,$55,$55,$5A,$AA,$AA
	.byte $5A,$55,$55,$15,$05,$00,$FF,$FB,$3F,$4F,$4F,$43,$00,$00,$80,$80
	.byte $00,$00,$40,$40,$40,$00,$FF,$EF,$FC,$B0,$F0,$C0,$00,$00,$00,$80
	.byte $AA,$AA,$55,$AA,$00,$00,$FF,$C3,$00,$00,$00,$00,$00,$00,$08,$26
	.byte $AA,$AA,$55,$AA,$0A,$00,$FF,$FB,$3F,$0F,$0F,$03,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$FF,$EF,$FC,$B0,$F0,$C0,$20,$A8,$9A,$9A
	.byte $AA,$AA,$A9,$AA,$80,$00,$FF,$C3,$00,$00,$00,$00,$00,$00,$02,$AA
	.byte $A8,$84,$51,$AA,$00,$00,$FF,$FB,$3F,$0F,$0F,$0B,$2A,$A6,$AA,$44
	.byte $00,$00,$11,$AA,$0A,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FC,$FC
	.byte $FC,$FC,$FC,$FC,$FC,$FC,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$C0,$C0
	.byte $C0,$C0,$C0,$C0,$C0,$C0,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$FC
	.byte $FC,$FC,$00,$CF,$CF,$CF,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$3C,$00,$07,$7E,$E0,$03,$7E,$C0,$01,$FF,$80,$00,$7E
	.byte $00,$00,$7E,$00,$0D,$FF,$B0,$1F,$FF,$F8,$0F,$FF,$F0,$07,$FF,$E0
	.byte $03,$FF,$C0,$00,$E7,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$78,$00,$01,$F8,$C0,$03,$E3,$C0,$07,$F7
	.byte $00,$07,$FF,$E0,$03,$FF,$F0,$03,$FF,$F0,$07,$FF,$E0,$07,$F7,$00
	.byte $03,$E3,$C0,$01,$F8,$C0,$00,$78,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$03,$81,$C0,$03
	.byte $00,$C0,$07,$3C,$E0,$07,$7E,$E0,$07,$7E,$E0,$03,$FF,$C0,$00,$FF
	.byte $00,$00,$7E,$00,$00,$7E,$00,$00,$7E,$00,$00,$FF,$00,$00,$FF,$00
	.byte $00,$FF,$00,$00,$E7,$00,$00,$E7,$00,$00,$C3,$00,$00,$C3,$00,$00
	.byte $C3,$00,$01,$81,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FE,$CF,$E1
	.byte $C3,$79,$FF,$F0,$03,$FF,$F8,$03,$FF,$F8,$79,$FF,$F0,$CF,$E1,$C3
	.byte $00,$00,$FE,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$7E,$00,$01,$FF,$80,$03,$FF,$C0,$03
	.byte $FF,$C0,$07,$FF,$E0,$07,$FF,$E0,$07,$FF,$E0,$07,$18,$E0,$03,$3C
	.byte $C0,$01,$E7,$80,$00,$F7,$00,$00,$FF,$00,$18,$DB,$18,$3C,$6C,$3C
	.byte $3E,$00,$7C,$03,$C3,$C0,$00,$7E,$00,$03,$C3,$C0,$3E,$00,$7C,$3C
	.byte $00,$3C,$18,$00,$18,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$1E,$1C,$1C,$33,$36,$36,$63,$63,$63,$03,$63
	.byte $63,$06,$63,$63,$0C,$63,$63,$18,$63,$63,$30,$36,$36,$7F,$1C,$1C
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$CC,$1C,$1C,$CC,$36,$36,$CC,$63,$63,$CC,$63
	.byte $63,$FF,$63,$63,$0C,$63,$63,$0C,$63,$63,$0C,$36,$36,$0C,$1C,$1C
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$08,$00,$00,$2A,$00,$00,$22,$00,$00
	.byte $A8,$00,$02,$8C,$00,$0A,$C0,$00,$A8,$00,$00,$AC,$00,$00,$80,$00
	.byte $00,$33,$33,$00,$AA,$AA,$00,$00,$0A,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$08,$00,$80,$2A,$00,$AA,$AE,$00,$AA,$AA
	.byte $00,$FF,$FF,$00,$AA,$AA,$00,$00,$0A,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$30,$00,$18,$5C,$00,$3C
	.byte $FC,$00,$7E,$E0,$00,$FF,$FC,$01,$CF,$F8,$07,$87,$C0,$0F,$03,$80
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$18,$00,$00,$2E,$00,$F0
	.byte $7E,$03,$FE,$70,$0F,$FF,$FE,$1F,$3F,$FC,$3C,$0F,$C0,$F0,$03,$80
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07
	.byte $00,$E0,$0F,$3C,$F0,$0F,$7E,$F0,$0F,$FF,$F0,$07,$FF,$E0,$03,$FF
	.byte $C0,$03,$FF,$C0,$03,$FF,$C0,$0F,$FF,$F0,$3F,$FF,$FC,$3F,$FF,$FC
	.byte $1F,$FF,$F8,$1F,$FF,$F0,$0F,$FF,$E0,$03,$FF,$80,$00,$FE,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$38,$78,$70,$7C
	.byte $FC,$F8,$7F,$FF,$F8,$7F,$FF,$F8,$3F,$FF,$F0,$3F,$FF,$F0,$3F,$FF
	.byte $F0,$1F,$FF,$E0,$0F,$FF,$C0,$7F,$FF,$F8,$7F,$FF,$F8,$7F,$FF,$F8
	.byte $3F,$FF,$F0,$3F,$FF,$F0,$1F,$FF,$E0,$0F,$FF,$C0,$03,$FF,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0C,$01,$80,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$6C,$00,$18,$00,$30,$00,$00
	.byte $00,$00,$00,$00,$01,$83,$00,$00,$00,$00,$00,$00,$00,$18,$00,$30
	.byte $00,$6C,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$06,$01,$80,$00
	.byte $00,$00,$00,$00,$00,$00,$06,$01,$80,$00,$00,$00,$00,$00,$00,$00
	.byte $C3,$03,$C0,$00,$00,$00,$00,$00,$18,$6C,$30,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$31,$83,$18,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $18,$6C,$33,$00,$00,$00,$C0,$00,$00,$00,$C3,$00,$00,$00,$00,$00
	.byte $00,$00,$03,$00,$C0,$00

L8906:	
	lda	#$06	
	sta	$0318		;Vector: Not maskerable Interrupt (NMI)
	lda	#$89	
	sta	$0319		;Vector: Not maskerable Interrupt (NMI)
	lda	#$00	
	sta	$D011		;VIC control register
	lda	#$03	
	sta	$DD02		;Data direction register port A #2
	lda	#$02	
	sta	$DD00		;Data port A #2: serial bus, RS-232, VIC memory
	lda	#$18	
	sta	$D016		;VIC control register
	lda	#$05	
	sta	$D020		;Border color
	lda	#$00	
	sta	$D021		;Background 0 color
	lda	#$0E	
	sta	$D022		;Background 1 color
	lda	#$09	
	sta	$D023		;Background 2 color
	lda	#$07	
	sta	$D028		;Color sprite 1
	lda	#$09	
	sta	$D029		;Color sprite 2
	lda	#$01	
	sta	$D02A		;Color sprite 3
	sta	$D026		;Multicolor animation 1 register
	lda	#$04	
	sta	$D01C		;Set multicolor mode for sprite 0..7
	lda	#$08	
	sta	$D01D		;(2X) horizontal expansion (X) sprite 0..7
	lda	#$1F	
	sta	$DC0D		;Interrupt control register CIA #1
	sta	$DD0D		;Interrupt control register CIA #2
	lda	$DD0D		;Interrupt control register CIA #2
	lda	$DC0D		;Interrupt control register CIA #1
	lda	#$00	
	sta	$06
	lda	#$D8	
	sta	$07
	lda	#$00	
	tax	
	sta	$11	
	lda	#$01	
	sta	$10	
W8973:
	lda	W801A+1,x	
	beq	W898A	
	sta	$12	
	inx	
	lda	W801A+1,x	
	jsr	W8FC2	
	inx	
	lda	$12	
	jsr	W94D5	
	jmp	W8973	

W898A:
	lda	#$C0	
	sta	$1C	
	lda	#$47	
	sta	$1D	
	lda	#$00	
	sta	$1E	
	lda	#$50	
	sta	$1F	
	ldx	#$00	
W899C:
	lda	W803F+1,x	
	sta	$02	
	inx	
	lda	W803F+1,x	
	sta	$03	
	inx	
	lda	W803F+1,x	
	and	#$F0	
	lsr	
	sta	$0A	
	lda	W803F+1,x	
	inx	
	and	#$0F	
	sta	$1B	
	cmp	#$02	
	beq	W89C2	
	jsr	W8FF5	
	jmp	W899C	

W89C2:
	lda	#$BE	
	sta	$02	
	lda	#$83	
	sta	$03	
	lda	#$77	
	sta	$12	
	lda	#$01	
	sta	$13
	lda	$1C	
	sta	$06
	lda	$1D	
	sta	$07
	jsr	W9084	
	lda	$06
	sta	$1C	
	lda	$07
	sta	$1D	
	lda	#$2E	
	sta	$02	
	lda	#$85	
	sta	$03
	lda	#$17	
	sta	$12
	lda	#$00	
	sta	$13
	lda	$1E	
	sta	$06
	lda	$1F	
	sta	$07
	jsr	W9084	
	lda	$06
	sta	$1E	
	lda	$07
	sta	$1F	
	lda	#$03	
	sta	$01		;6510 I/O register
	lda	#$07	
	sta	$00	
	lda	$1C	
	sta	$06
	lda	$1D	
	sta	$07
	ldx	#$00	
W8A1A:
	lda	W8094+1,x	
	jsr	W94FA	
	inx	
	cpx	#$16	
	bne	W8A1A	
	lda	$06
	sta	$1C	
	lda	$07
	sta	$1D	
	lda	$1E	
	sta	$06
	lda	$1F	
	sta	$07
	ldx	#$00	
W8A37:
	lda	W80A9+2,x	
	jsr	W94FA	
	inx	
	cpx	#$16	
	bne	W8A37	
	lda	$06
	sta	$1E	
	lda	$07
	sta	$1F	
	lda	#$07	
	sta	$01		;6510 I/O register
	lda	#$00	
	sta	$24
	lda	#$58	
	sta	$25
	lda	#$46	
	sta	$02	
	lda	#$85	
	sta	$03
	lda	#$BF	
	sta	$12
	lda	#$03	
	sta	$13
	lda	$24
	sta	$06
	lda	$25
	sta	$07
	jsr	W9084	
	lda	$06
	sta	$24
	lda	$07
	sta	$25
	lda	#$46	
	sta	$02	
	lda	#$85	
	sta	$03
	jsr	W9567	
	lda	#$86	
	sta	$02	
	lda	#$85	
	sta	$03
	jsr	W952D	
	lda	#$C6	
	sta	$02	
	lda	#$85	
	sta	$03
	jsr	W9567	
	lda	#$06	
	sta	$02	
	lda	#$86	
	sta	$03
	jsr	W952D	
	lda	#$86	
	sta	$02	
	lda	#$87	
	sta	$03
	jsr	W952D	
	lda	#$C6	
	sta	$02	
	lda	#$87	
	sta	$03
	jsr	W952D	
	lda	#$C0	
	sta	$04
	lda	#$47	
	sta	$05
	lda	$1C	
	sta	$08
	lda	$1D	
	sta	$09
	lda	#$00	
	sta	$0B	
	lda	#$04	
	sta	$0A
	lda	#$04	
	jsr	W945B	
	lda	#$06	
	jsr	W945B	
	lda	$2D
	ldx	#$04	
	jsr	W94ED	
	lda	#$02	
	jsr	W945B	
	lda	$2D
	ldx	#$04	
	jsr	W94ED	
	ldx	#$03	
	stx	$28
	lda	#$08	
	sta	$0A
W8AF8:
	lda	$28
	asl	
	jsr	W945B	
	dec	$28
	bne	W8AF8	
	lda	$2D
	ldx	#$04	
	jsr	W94ED	
	ldx	#$03	
	stx	$28
	lda	#$01	
	sta	$0B
	lda	#$0D	
	sta	$0A
W8B15:
	lda	$28
	asl	
	jsr	W945B	
	dec	$28
	bne	W8B15	
	lda	#$00	
	sta	$04
	lda	#$50	
	sta	$05
	lda	$1E	
	sta	$08
	lda	$1F	
	sta	$09
	ldx	#$03	
	stx	$28
	lda	#$0E	
	sta	$0A
W8B37:
	lda	$28
	asl	
	jsr	W945B	
	dec	$28
	bne	W8B37	
	lda	$2D
	ldx	#$04	
	jsr	W94ED	
	lda	#$0A	
	sta	$0A
	ldx	#$03	
	stx	$28
	lda	#$00	
	sta	$0B
W8B54:
	lda	$28
	asl	
	jsr	W945B	
	dec	$28
	bne	W8B54	
	lda	#$26	
	sta	$06
	lda	#$44	
	sta	$07
	lda	#$05	
	sta	$10
	lda	#$03	
	sta	$11
	lda	#$52	
	sta	$12
	lda	#$33	
	jsr	W8FC2	
	lda	#$08	
	sta	$06
	lda	#$46	
	sta	$07
	lda	#$00	
	sta	$11
	lda	#$32	
	jsr	W8FC2	
	lda	#$98	
	sta	$06
	lda	#$47	
	sta	$07
	lda	#$31	
	jsr	W8FC2	
	ldx	#$00	
W8B97:
	lda	W805E,x	
	sta	$4400,x	
	inx	
	cpx	#$20	
	bne	W8B97	
	lda	#$FF	
	sta	$7D
	lda	#$03	
	sta	$AC
	lda	$D015
	and	#$FE	
	sta	$D015
	lda	#$00	
	sta	$5B
	sta	$5E
	lda	#$DF	
	sta	$0314		;Vector: Hardware Interrupt (IRQ)
	lda	#$8B	
	sta	$0315		;Vector: Hardware Interrupt (IRQ)
	lda	#$01	
	sta	$D01A		;IRQ mask register
	lda	#$FF	
	sta	$D019		;Interrupt indicator register
	lda	#$A1	
	sta	$D012
	sta	$2E
	lda	#$1B	
	sta	$D011		;VIC control register
	jsr	W9594	
	cli	
W8BDC:
	jmp	W8BDC	

	lda	#$14	
	sta	$D018		;VIC memory control register
	lda	$2E
	cmp	#$FC	
	bne	W8BED	
	jmp	W8ED4	

W8BED:
	lda	#$FC	
	sta	$D012
	sta	$2E
	lda	#$1B	
	sta	$D011		;VIC control register
	lda	#$FF	
	sta	$DC03		;Data direction register port B #1
	lda	#$00	
	sta	$DC02		;Data direction register port A #1
	sta	$DC01		;Data port B #1: keyboard, joystick, paddle
	ldx	$DC00		;Data port A #1: keyboard, joystick, paddle, optical pencil
	cpx	$54
	beq	W8C3E	
	stx	$54
	lda	#$FF	
	sta	$DC02		;Data direction register port A #1
	lda	#$00	
	sta	$DC03		;Data direction register port B #1
	sta	$DC00		;Data port A #1: keyboard, joystick, paddle, optical pencil
	ldy	$DC01		;Data port B #1: keyboard, joystick, paddle
	cpy	$55
	beq	W8C3E	
	sty	$55
	cpx	#$FE	
	bne	W8C30	
	cpy	#$EF	
	bne	W8C30	
	jsr	W9599	
W8C30:
	cpx	#$FE	
	bne	W8C3E	
	cpy	#$DF	
	bne	W8C3E	
	lda	#$01	
	eor	$5B
	sta	$5B
W8C3E:
	cpx	#$FE	
	bne	W8C4F	
	cpy	#$BF	
	bne	W8C4F	
	lda	$5E
	eor	#$01	
	sta	$5E
	jsr	W9594	
W8C4F:
	lda	#$FF	
	ldx	$81
	sta	$DC02,x		;Data direction register port A #1
	sta	$DC00,x		;Data port A #1: keyboard, joystick, paddle, optical pencil
	lda	#$00	
	ldx	$5F
	sta	$DC02,x		;Data direction register port A #1
	lda	$DC00,x		;Data port A #1: keyboard, joystick, paddle, optical pencil
	cmp	$58
	beq	W8C7C	
	sta	$58
	and	#$10	
	bne	W8C7C	
	lda	$7E
	eor	#$0F	
	sta	$7E
	ldx	$6E
	beq	W8C7C	
	eor	#$0F	
	sta	$D418		;Select volume and filter mode
W8C7C:
	lda	$77
	bne	W8C90	
	lda	$6E
	beq	W8C8A	
	lda	$6F		;Sign comparison result of #1 with #2
	cmp	#$07	
	beq	W8C98	
W8C8A:
	jsr	W90A9	
	jmp	W8F01	

W8C90:
	bpl	W8C98	
	jsr	W90FE	
	jmp	W8F01	

W8C98:
	lda	$7E
	beq	W8C9F	
	jmp	W8F01	

W8C9F:
	dec	$48
	beq	W8CA6	
	jmp	W8D8E	

W8CA6:
	lda	#$1E	
	sta	$48
	inc	$B1
	lda	$B1
	cmp	#$0C	
	bmi	W8CB4	
	lda	#$00	
W8CB4:
	sta	$B1
	and	#$01	
	beq	W8CBD	
	jmp	W8D8E	

W8CBD:
	lda	#$67	
	cmp	$47FA	
	bne	W8CC6	
	lda	#$68	
W8CC6:
	sta	$47FA	
	lda	$B4		;RS-232 output bits counter/Tape timer
	bpl	W8CEA	
	jsr	W9C7C	
	bmi	W8D01	
	stx	$B4		;RS-232 output bits counter/Tape timer
	lda	#$3D	
	sta	$4E
	lda	#$0D	
	sta	$4D
	jsr	W9432	
	lda	#$04	
	sta	$B5
	lda	#$01	
	sta	$A7,x
	jmp	W8D01	

W8CEA:
	lda	$79
	bne	W8D01	
	dec	$B5
	bne	W8D01	
	ldx	$B4
	stx	$49
	jsr	W9407	
	lda	#$00	
	sta	$A7,x
	lda	#$FF	
	sta	$B4		;RS-232 output bits counter/Tape timer
W8D01:
	lda	$AE
	bne	W8D24	
	jsr	W9C7C	
	bmi	W8D5A	
	stx	$B8
	lda	#$43	
	sta	$4E
	lda	#$0D	
	sta	$4D
	jsr	W9432	
	lda	#$02	
	sta	$B7		;Length of current file name
	lda	#$02	
	sta	$AE
	sta	$A7,x		;Input bit of RS-232/Transient cassette
	jmp	W8D5A	

W8D24:
	dec	$B7
	bpl	W8D5A	
	dec	$AE
	beq	W8D4A	
	ldx	$B8
	lda	$A7,x		;Input bit of RS-232/Transient cassette
	bmi	W8D58	
	stx	$49
	lda	#$49	
	sta	$4E
	lda	#$0D	
	sta	$4D
	jsr	W9432	
	lda	#$FE	
	sta	$A7,x		;Input bit of RS-232/Transient cassette
	lda	#$04	
	sta	$B7		;Length of current file name
	jmp	W8D5A	

W8D4A:
	ldx	$B8
	stx	$49
	jsr	W9407	
	lda	#$00	
	sta	$A7,x		;Input bit of RS-232/Transient cassette
	jmp	W8D5A	

W8D58:
	dec	$AE
W8D5A:
	lda	$7D
	bpl	W8D70	
	lda	$5E
	beq	W8D8E	
	lda	$81
	eor	#$01	
	sta	$81
	ldx	#$00	
	jsr	W9D2D	
	jmp	W8D8E	

W8D70:
	lda	$7D
	ora	$85
	ora	$86
	bne	W8D8E	
	dec	$47
	bne	W8D83	
	lda	#$6B	
	sta	$53
	jsr	W99B2	
W8D83:
	lda	$47
	cmp	#$05	
	bne	W8D8E	
	lda	#$05	
	jsr	W9B73	
W8D8E:
	jsr	W9683	
	jsr	W9A62	
	jsr	W988D	
	jsr	W9793	
	ldx	$7F
	stx	$86
	beq	W8DA3	
	dex	
	stx	$7F
W8DA3:
	lda	$B6		;Buffer of RS-232 output byte
	bne	W8DC4	
	lda	$D010		;Position X MSB sprites 0..7
	and	#$02	
	bne	W8DC4	
	lda	$D002		;Position X sprite 1
	cmp	#$0F	
	bcs	W8DC4	
	lda	$D015
	ora	#$02	
	sta	$D015
	lda	$D01E		;Animations contact
	lda	#$01	
	sta	$B6		;Buffer of RS-232 output byte
W8DC4:
	lda	$85
	bne	W8DD2	
	lda	$86
	bne	W8DD2	
	lda	$7D
	beq	W8E3F	
	bpl	W8DD5	
W8DD2:
	jmp	W8F01	

W8DD5:
	cmp	#$5A	
	beq	W8DE9	
	cmp	#$41	
	beq	W8DE9	
	cmp	#$28	
	bne	W8DF0	
	lda	#$64	
	sta	$47F8	
	jmp	W8DF0	

W8DE9:
	lda	$53
	sta	$47F8	
	inc	$53
W8DF0:
	dec	$7D
	bne	W8E4C	
	lda	$84
	beq	W8E39	
	ldx	$81
	lda	$B3
	bne	W8E1E	
	lda	#$01	
	sta	$82,x
	lda	$D015
	and	#$FE	
	sta	$D015
	lda	$82
	beq	W8E1E	
	lda	$83
	beq	W8E1E	
	lda	#$FF	
	sta	$7D
	lda	#$06	
	jsr	W9B73	
	jmp	W8E3F	

W8E1E:
	lda	$5E
	beq	W8E39	
	txa	
	eor	#$01	
	tax	
	ldy	$82,x
	bne	W8E39	
	stx	$81
	eor	#$01	
	sta	$5F
	ldx	#$00	
	jsr	W9D09	
	lda	#$FF	
	sta	$77
W8E39:
	jsr	W9640	
	jmp	W8F01	

W8E3F:
	lda	$79
	bne	W8E4C	
	ldx	$5F
	lda	$DC00,x		;Data port A #1: keyboard, joystick, paddle, optical pencil
	cmp	$46
	bne	W8E4F	
W8E4C:
	jmp	W8E96	

W8E4F:
	sta	$46
	ror	
	bcc	W8E60	
	ror	
	bcc	W8E6C	
	ror	
	bcc	W8E78	
	ror	
	bcc	W8E84	
	jmp	W8E96	

W8E60:
	lda	#$01	
	sta	$31
	lda	#$62
	sta	$47F8	
	jmp	W8E8D	

W8E6C:
	lda	#$02	
	sta	$31
	lda	#$71	
	sta	$47F8	
	jmp	W8E8D	

W8E78:
	lda	#$04	
	sta	$31
	lda	#$72	
	sta	$47F8	
	jmp	W8E8D	

W8E84:
	lda	#$08	
	sta	$31
	lda	#$63	
	sta	$47F8	
W8E8D:
	lda	#$01	
	sta	$79
	lda	#$00	
	jsr	W9B73	
W8E96:
	lda	$79
	beq	W8F01	
	lda	$45
	bpl	W8EA2	
	lda	#$0F	
	sta	$45
W8EA2:
	lda	$31
	ror	
	bcc	W8EB0	
	jsr	W8F0C	
	jsr	W8F0C	
	jmp	W8F01	

W8EB0:
	ror	
	bcc	W8EBC	
	jsr	W8F32	
	jsr	W8F32	
	jmp	W8F01	

W8EBC:
	ror	
	bcc	W8EC8	
	jsr	W8F56	
	jsr	W8F56	
	jmp	W8F01	

W8EC8:
	ror	
	bcc	W8F01	
	jsr	W8F8C	
	jsr	W8F8C	
	jmp	W8F01	

W8ED4:
	lda	#$12	
	sta	$D018		;VIC memory control register
	lda	#$A1	
	sta	$D012		;Reading/Writing IRQ balance value
	sta	$2E
	lda	#$1B	
	sta	$D011		;VIC control register
	lda	$7E
	bne	W8F01	
	lda	$77
	cmp	#$FE	
	bne	W8EF5	
	jsr	W9115	
	jmp	W8F01	

W8EF5:
	jsr	W933F	
	jsr	W933F	
	jsr	W933F	
	jsr	W9BBA	
W8F01:
	lda	#$01	
	sta	$D019		;Interrupt indicator register
	pla	
	tay	
	pla	
	tax	
	pla	
	rti	

W8F0C:
	ldy	$D001		;Position Y sprite 0
	dey	
	cpy	#$37	
	bne	W8F16	
	ldy	#$38	
W8F16:
	sty	$D001		;Position Y sprite 0
	dec	$45
	bmi	W8F1E	
	rts	

W8F1E:
	ldx	#$60	
	jsr	W99D1	
	dec	$4A
	lda	$4A
	cmp	$4B
	bpl	W8F31	
	sta	$4B
	lda	#$01	
	sta	$7A
W8F31:
	rts	

W8F32:
	ldy	$D001		;Position Y sprite 0
	iny	
	cpy	#$E9	
	bne	W8F3C	
	ldy	#$E8	
W8F3C:
	sty	$D001		;Position Y sprite 0
	dec	$45
	bmi	W8F44	
	rts	

W8F44:
	ldx	#$6F	
	jsr	W99D1	
	inc	$4A
	lda	#$0A	
	cmp	$4A
	bpl	W8F55	
	lda	#$0A	
	sta	$4A
W8F55:
	rts	

W8F56:
	sec	
	lda	$D000		;Position X sprite 0
	sbc	#$01	
	sta	$2D
	bcs	W8F6B	
	lda	$D010		;Position X MSB sprites 0..7
	and	#$FE	
	sta	$D010		;Position X MSB sprites 0..7
	jmp	W8F7C	

W8F6B:
	lda	$D010		;Position X MSB sprites 0..7
	and	#$01	
	bne	W8F7C	
	lda	$2D
	cmp	#$10	
	bne	W8F7A	
	lda	#$11	
W8F7A:
	sta	$2D
W8F7C:
	lda	$2D
	sta	$D000		;Position X sprite 0
	dec	$45
	bmi	W8F86	
	rts	

W8F86:
	ldx	#$70	
	jsr	W99D1	
	rts	

W8F8C:
	clc	
	lda	$D000		;Position X sprite 0
	adc	#$01	
	sta	$2D
	bcc	W8FA1	
	lda	$D010		;Position X MSB sprites 0..7
	ora	#$01	
	sta	$D010		;Position X MSB sprites 0..7
	jmp	W8FB2	

W8FA1:
	lda	$D010		;Position X MSB sprites 0..7
	and	#$01	
	beq	W8FB2	
	lda	$2D
	cmp	#$48	
	bne	W8FB0	
	lda	#$47	
W8FB0:
	sta	$2D
W8FB2:
	lda	$2D
	sta	$D000		;Position X sprite 0
	dec	$45
	bmi	W8FBC	
	rts	

W8FBC:
	ldx	#$61	
	jsr	W99D1	
	rts	

W8FC2:
	sta	$2D
	lda	#$00	
	sta	$29
	sta	$2A
	tay	
W8FCB:
	lda	$2D
	sta	($06),y
	inc	$29
	iny	
	cpy	$12
	bne	W8FD7	
	rts	

W8FD7:
	lda	$29
	cmp	$10
	bne	W8FCB	
	lda	#$00	
	sta	$29
W8FE1:
	lda	$2A
	cmp	$11
	bne	W8FED	
	lda	#$00	
	sta	$2A
	beq	W8FCB	
W8FED:
	iny	
	inc	$2A
	cpy	$12
	bne	W8FE1	
	rts	

W8FF5:
	lda	#$00	
	sta	$2C
	sta	$2D
	lda	$1E	
	sta	$06
	lda	$1F	
	sta	$07
	lda	$1B	
	beq	W9013	
	lda	$1C	
	sta	$06
	lda	$1D	
	sta	$07
	lda	#$55	
	sta	$2D
W9013:
	lda	#$07	
	jsr	W9076	
	ldy	#$08	
	sty	$21
	ldy	#$00	
	sty	$20
W9020:
	ldy	$20
	lda	($02),y	
	inc	$2C
	sta	($06),y
	ldy	$21
	sta	($08),y
	inc	$20
	lda	$2C
	cmp	$0A
	beq	W9045	
	dec	$21
	bne	W9020	
	lda	#$10	
	jsr	W94D5	
	lda	#$08	
	jsr	W94E1	
	jmp	W9013	

W9045:
	lda	#$10	
	sta	$12
	lda	#$10	
	jsr	W94D5	
	lda	#$00	
	sta	$11
	lda	#$01	
	sta	$10
	lda	$2D
	jsr	W8FC2	
	lda	#$10	
	jsr	W9076	
	lda	$1B	
	beq	W906D	
	lda	$08
	sta	$1C	
	lda	$09
	sta	$1D	
	rts	

W906D:
	lda	$08
	sta	$1E	
	lda	$09
	sta	$1F	
	rts	

W9076:
	clc	
	adc	$06
	sta	$08
	lda	$07
	adc	#$00	
	sta	$09
	lda	$08
	rts	

W9084:
	ldy	#$00	
W9086:
	lda	($02),y	
	sta	($06),y
	inc	$02	
	bne	W9090	
	inc	$03
W9090:
	inc	$06
	bne	W9096	
	inc	$07
W9096:
	lda	$12
	sec	
	sbc	#$01	
	sta	$12
	bcs	W9086	
	lda	$13
	sec	
	sbc	#$01	
	sta	$13
	bcs	W9086	
	rts	

W90A9:
	lda	$7D
	bmi	W90B2	
	lda	#$08	
	jsr	W9B73	
W90B2:
	ldy	$AC
	iny	
	cpy	#$05	
	bne	W90BB	
	ldy	#$00	
W90BB:
	sty	$AC
	ldx	$AD
	inx	
	cpx	#$03	
	bne	W90C6	
	ldx	#$00	
W90C6:
	stx	$AD
	lda	$AF
	clc	
	sed	
	adc	#$01	
	sta	$AF
	cld	
	lda	$D015
	cpy	#$00	
	bne	W90DA	
	and	#$FB	
W90DA:
	cpy	#$01	
	bmi	W90E0	
	ora	#$04	
W90E0:
	cpy	#$02	
	bmi	W90E8	
	ldy	#$01	
	sty	$B0
W90E8:
	sta	$D015
	lda	$D01E
	lda	#$05	
	sta	$B2
	lda	#$00	
	sta	$85
	ldy	#$04	
W90F8:
	sta	$00A7,y
	dey	
	bpl	W90F8	
W90FE:
	lda	#$07	
	ldy	#$FF	
W9102:
	sta	$4477,y	
	dey	
	bne	W9102	
	ldy	#$91	
W910A:
	sta	$4576,y	
	dey	
	bne	W910A	
	lda	#$FE	
	sta	$77
	rts	

W9115:
	ldy	#$04	
	sty	$49
W9119:
	lda	#$0D	
	sta	$4D
	lda	$00A7,y
	beq	W913E	
	bmi	W912C	
	cmp	#$01	
	beq	W9144	
	cmp	#$02	
	beq	W914E	
W912C:
	cmp	#$FE	
	beq	W9158	
	lda	#$37	
	sta	$4E
	lda	#$05	
	sta	$4D
	jsr	W9432	
	jmp	W915F	

W913E:
	jsr	W9407	
	jmp	W915F	

W9144:
	lda	#$3D	
	sta	$4E
	jsr	W9432	
	jmp	W915F	

W914E:
	lda	#$43	
	sta	$4E
	jsr	W9432	
	jmp	W915F	

W9158:
	lda	#$49	
	sta	$4E
	jsr	W9432	
W915F:
	dec	$49
	ldy	$49
	bpl	W9119	
	lda	#$11	
	ldy	#$FF	
W9169:
	sta	$4657,y	
	dey	
	bne	W9169	
	ldy	#$41	
W9171:
	sta	$4756,y	
	dey	
	bne	W9171	
	lda	#$01	
	sta	$77
	rts	

W917C:
	lda	$0F
	sta	$64
	jsr	W9D4C	
W9183:
	iny	
	lda	($04),y
	bne	W9189	
	rts	

W9189:
	sta	$0C
	lda	$0D
	stx	$23
	sty	$22
	cmp	#$01	
	bne	W91AD	
	lda	$0C
	and	#$80	
	beq	W91A7	
	lda	$0C
	and	#$7F	
	sta	$0C
	jsr	W9255	
	jmp	W91C1	

W91A7:
	jsr	W9212	
	jmp	W91C1	

W91AD:
	cmp	#$02	
	bne	W91B7	
	jsr	W92E9	
	jmp	W91C1	

W91B7:
	sec	
	lda	$0F
	sbc	#$05	
	sta	$50
	jsr	W92CA	
W91C1:
	ldy	$22
	ldx	$23
	jmp	W9183	

W91C8:
	lda	$0F
	asl	
	tax	
	lda	W8009,x	
	clc	
	sta	$15
	adc	#$28	
	sta	$17
	inx	
	lda	W8009,x	
	sta	$16
	adc	#$00	
	sta	$18
	lda	$0C
	and	#$7F	
	clc	
	ldx	$0F
	adc	$8B,x
	sta	$2D
	ldy	W811B,x	
	beq	W91F6	
	sec	
	sbc	#$01	
	jmp	W91F8	

W91F6:
	adc	#$01	
W91F8:
	cmp	#$32	
	bcc	W91FE	
	sbc	#$32	
W91FE:
	tay	
	cpy	#$28	
	bpl	W920F	
	lda	#$07	
	cpx	#$05	
	bmi	W920B	
	lda	#$11	
W920B:
	sta	($15),y
	sta	($17),y
W920F:
	ldy	$2D
	rts	

W9212:
	jsr	W91C8	
	lda	#$01	
	sta	$0B
	ldx	$78
	lda	W80C5,x	
	sta	$19
	lda	#$02	
	sta	$14
	jsr	W9298	
	lda	#$00	
	sta	$2B
W922B:
	tya	
	cmp	#$32	
	bcc	W9233	
	sbc	#$32	
	tay	
W9233:
	cpy	#$28	
	bpl	W9240	
	lda	$19
	sta	($15),y
	clc	
	adc	#$01	
	sta	($17),y
W9240:
	inc	$2B
	iny	
	lda	$2B
	cmp	$0E
	bne	W922B	
	inc	$19
	inc	$19
	lda	#$03	
	sta	$14
	jsr	W9298	
	rts	

W9255:
	jsr	W91C8	
	lda	#$01	
	sta	$0B
	ldx	$78
	lda	W80D0+1,x	
	sta	$19
	lda	#$03	
	sta	$14
	jsr	W9298	
	lda	#$00	
	sta	$2B
W926E:
	tya	
	cmp	#$32	
	bcc	W9276	
	sbc	#$32	
	tay	
W9276:
	cpy	#$28	
	bpl	W9283	
	lda	$19
	sta	($15),y
	clc	
	adc	#$01	
	sta	($17),y
W9283:
	inc	$2B
W9285:
	iny	
	lda	$2B
	cmp	#$04	
	bne	W926E	
	inc	$19
	inc	$19
	lda	#$03	
	sta	$14
	jsr	W9298	
	rts	

W9298:
	tya	
	bpl	W92A1	
	clc	
	adc	#$32	
	jmp	W92A7	

W92A1:
	cmp	#$32	
	bcc	W92A7	
	sbc	#$32	
W92A7:
	tay	
	cpy	#$28	
	bpl	W92B8	
	lda	$19
	sta	($15),y
	inc	$19
	lda	$19
	sta	($17),y
	dec	$19
W92B8:
	inc	$19
	inc	$19
	lda	$0B
	beq	W92C4	
	iny	
	jmp	W92C5	

W92C4:
	dey	
W92C5:
	dec	$14
	bne	W9298	
	rts	

W92CA:
	jsr	W91C8	
	lda	$50
	asl	
	asl	
	clc	
	adc	$78
	tax	
	lda	W80D4+1,x	
	sta	$19
	lda	$0E
	sta	$14
	ldx	$0F
	lda	W811B,x	
	sta	$0B
	jsr	W9298	
	rts	

W92E9:
	lda	#$00	
	sta	$0B
	sta	$2B
	ldx	$0F
	lda	$9D,x		;Flag: 80=direct mode 00=program mode
	clc	
	adc	$B1
	cmp	#$0C	
	bmi	W92FD	
	sec	
	sbc	#$0C	
W92FD:
	sta	$A2,x
	sta	$30
	ldx	$78
	ldy	$0C
	cpy	#$80	
	bmi	W9323	
	lda	$30
	cmp	#$07	
	bmi	W9323	
	cmp	#$09	
W9311:
	bmi	W9317	
	cmp	#$0A	
	bmi	W931D	
W9317:
	lda	W80C8+1,x	
	jmp	W9326	

W931D:
	lda	W80CC+1,x	
	jmp	W9326	

W9323:
	lda	W80C0+1,x	
W9326:
	sta	$27
	jsr	W91C8	
W932B:
	lda	$27
	sta	$19
	lda	#$04	
	sta	$14
	jsr	W9298	
	inc	$2B
	lda	$2B
	cmp	$0E
	bne	W932B	
	rts	

W933F:
	ldx	$0F
	dec	$32,x
	beq	W9348	
	jmp	W93FE	

W9348:
	jsr	W99E0	
	lda	#$04	
	sec	
	sbc	$94,x
	cmp	$3B,x
	bmi	W9356	
	lda	$3B,x
W9356:
	sta	$3B,x
	clc	
	adc	$94,x
	sta	$94,x
	cmp	#$04	
	bmi	W9383	
	lda	#$00	
	sta	$94,x
	lda	W811B,x	
	bne	W9376	
	lda	$8B,x
	sec	
	sbc	#$01	
	bpl	W9381	
	lda	#$31	
	jmp	W9381	

W9376:
	lda	$8B,x
	clc	
	adc	#$01	
	cmp	#$32	
	bne	W9381	
	lda	#$00	
W9381:
	sta	$8B,x
W9383:
	lda	$94,x
	sta	$78
	jsr	W917C	
	ldx	$0F
	cpx	#$05	
	bpl	W93FE	
	lda	#$10	
	sta	$69
	lda	#$D0	
	sta	$6A
	cpx	#$03	
	bne	W93AB	
	lda	#$02	
	sta	$67
	lda	#$D0	
	sta	$68
	lda	#$02	
	sta	$6B
	jsr	W9CAC	
W93AB:
	cpx	#$00	
	bne	W93BE	
	lda	#$04	
	sta	$67
	lda	#$D0	
	sta	$68
	lda	#$04	
	sta	$6B
	jsr	W9CAC	
W93BE:
	cpx	#$02	
	bne	W93C5	
	jsr	W9ACB	
W93C5:
	cpx	$4A
	bne	W93FE	
	lda	$79
	beq	W93D3	
	lda	$31
	and	#$03	
	bne	W93FE	
W93D3:
	lda	$45
	sta	$4C 
	lda	$3B,x
	asl	
	sta	$51
	lda	W811B,x	
	beq	W93EF	
W93E1:
	lda	#$02
	sta	$45
	jsr	W8F8C	
	dec	$51
	bne	W93E1	
	jmp	W93FA	

W93EF:
	lda	#$02	
	sta	$45
	jsr	W8F56	
	dec	$51
	bne	W93EF	
W93FA:
	lda	$4C 
	sta	$45
W93FE:
	dec	$0F
	bpl	W9406	
	ldx	#$08	
	stx	$0F
W9406:
	rts	

W9407:
	lda	$49
	asl	
	asl	
	asl	
	tay	
	iny	
	iny	
	iny	
	lda	#$03	
	sta	$26
	lda	#$34	
	sta	$4E
W9418:
	lda	#$0D	
	sta	$D828,y		;Color RAM
	sta	$D850,y		;Color RAM
	lda	$4E
	sta	$4428,y	
	lda	#$5D	
	sta	$4450,y	
	inc	$4E
	iny	
	dec	$26
	bne	W9418	
	rts	

W9432:
	lda	#$03	
	sta	$26
	lda	$49
	asl	
	asl	
	asl	
	tay	
	iny	
	iny	
	iny	
W943F:
	lda	$4D
	sta	$D828,y		;Color RAM
	sta	$D850,y		;Color RAM
	lda	$4E
	sta	$4428,y	
	inc	$4E
	lda	$4E
	sta	$4450,y	
	inc	$4E
	iny	
	dec	$26
	bne	W943F	
	rts	

W945B:
	sta	$2C
	lda	$04
	pha	
	lda	$05
	pha	
W9463:
	ldy	#$00	
	clc	
W9466:
	lda	#$00	
	sta	$2B
	lda	$04
	sta	$02	
	lda	$05
	sta	$03
	lda	$08
	sta	$06
	lda	$09
	sta	$07
W947A:
	lda	($02),y	
	ldx	$0B
	beq	W9484	
	ror	
	jmp	W9485	

W9484:
	rol	
W9485:
	php	
	sta	($06),y
	inc	$2B
	lda	$2B
	cmp	$0A
	beq	W949E	
	lda	#$10	
W9492:
	jsr	W94E1	
	lda	#$10	
	jsr	W94D5	
	plp	
	jmp	W947A	

W949E:
	lda	#$01	
	ldx	$0B
	beq	W94A6	
	lda	#$80	
W94A6:
	plp	
	bcc	W94AD	
	ora	($08),y
	sta	($08),y
W94AD:
	iny	
	cpy	#$10	
	bne	W9466	
	dec	$2C
	beq	W94C1	
	lda	$08
	sta	$04
	lda	$09
	sta	$05
	jmp	W9463	

W94C1:
	pla	
	sta	$05
	pla	
	sta	$04
	lda	$0A
	asl	
	asl	
	asl	
	asl	
	sta	$2D
	ldx	#$08	
	jsr	W94ED	
	rts	

W94D5:
	clc	
	adc	$06
	sta	$06
	lda	$07
	adc	#$00	
	sta	$07
	rts	

W94E1:
	clc	
	adc	$02	
	sta	$02	
	lda	$03
	adc	#$00	
	sta	$03
	rts	

W94ED:
	clc	
	adc	$00,x	
	sta	$00,x	
	inx	
	lda	$00,x	
	adc	#$00	
	sta	$00,x	
	rts	

W94FA:
	clc	
	asl	
	php	
	asl	
	asl	
	sta	$02	
	lda	#$00	
	adc	#$D0	
	sta	$03
	pla	
	and	#$01	
	asl	
	asl	
	adc	$03
	sta	$03
	ldy	#$00	
W9512:
	lda	($02),y	
	sta	($06),y
	iny	
	cpy	#$08	
	bne	W9512	
	lda	#$08	
	jsr	W94D5	
	rts	

W9521:
	sta	$06
	lda	#$00	
	sta	$07
W9527:
	dey	
	sta	($06),y
	bne	W9527	
	rts	

W952D:
	ldy	#$3E	
	sty	$21
	ldy	#$3C	
	sty	$20
W9535:
	lda	#$03	
	sta	$28
W9539:
	ldx	#$08	
	ldy	$20
	lda	($02),y	
W953F:
	ror	
	rol	$2D
	dex	
	bne	W953F	
	lda	$2D
	ldy	$21
	sta	($24),y
	dec	$21
	bmi	W955F	
	inc	$20
	dec	$28
	bne	W9539	
	lda	$20
	sec	
	sbc	#$06	
	sta	$20
	jmp	W9535	

W955F:
	ldx	#$24	
	lda	#$40	
	jsr	W94ED	
	rts	

W9567:
	ldy	#$3E	
	sty	$21
	ldy	#$02	
	sty	$20
W956F:
	ldx	#$03	
W9571:
	ldy	$20
	lda	($02),y	
	ldy	$21
	sta	($24),y
	dec	$21
	bmi	W958C	
	dec	$20
	dex	
	bne	W9571	
	clc	
	lda	$20
	adc	#$06	
	sta	$20
	jmp	W956F	

W958C:
	ldx	#$24	
	lda	#$40	
	jsr	W94ED	
	rts	

W9594:
	ldx	#$01	
	jmp	W95A0	

W9599:
	lda	#$08	
	jsr	W9B73	
	ldx	#$00	
W95A0:
	ldy	#$3B	
	lda	#$77	
	jsr	W9521	
	ldy	#$08	
	sty	$9E
	sty	$0F
W95AD:
	jsr	W99E0	
	dec	$0F
	bpl	W95AD	
	lda	#$01	
	sta	$5F
	ldy	$5E
	bne	W95BE	
	sta	$83
W95BE:
	sta	$31
	sta	$44
	lda	#$FF	
	sta	$45
	lda	#$06		;==== NUMBER OF LIVES ====
	sta	$B3		;==== STORES NO OF LIVES ===
	lda	#$32	
	sta	$D002		;Position X sprite 1
	lda	#$6D	
	sta	$D004		;Position X sprite 2
	lda	#$4A	
	sta	$D005		;Position Y sprite 2
	lda	#$D0	
	sta	$BD
	lda	#$00	
	sta	$BE
	lda	#$5A	
	sta	$BF
	lda	#$08	
	sta	$C0
	sta	$0F
	lda	#$68	
	sta	$D007		;Position Y sprite 3
	jsr	W9A0A	
	lda	#$00	
	sta	$D015
	sta	$D010		;Position X MSB sprites 0..7
	lda	#$79	
	sta	$D003		;Position Y sprite 1
	lda	#$60	
	sta	$47F9	
	lda	#$68	
	sta	$47FA	
	lda	#$1E	
	sta	$48
	lda	#$0C	
	sta	$C2
	jsr	W9640	
	cpx	#$00	
	beq	W962E	
	lda	#$FF	
	sta	$7D
	lda	#$03	
	sta	$AC
	sta	$AF
	lda	$D015
	and	#$FE	
	sta	$D015
	jmp	W963A	

W962E:
	lda	#$FF	
	sta	$77
	lda	#$05	
	sta	$B2
	lda	#$01	
	sta	$AF
W963A:
	ldx	#$01	
	jsr	W9D09	
	rts	

W9640:
	lda	#$1E	
	sta	$47
	lda	#$0A	
	sta	$4A
	sta	$4B 
	lda	$D015
	and	#$02	
	bne	W9655	
	lda	#$00	
	sta	$B6		;Buffer of RS-232 output byte
W9655:
	lda	#$00	
	sta	$84
	sta	$4F
	lda	#$A0	
	sta	$D000		;Position X sprite 0
	lda	#$E8	
	sta	$D001		;Position Y sprite 0
	lda	#$60	
	sta	$47F8	
	lda	#$0D	
	sta	$D027		;Color sprite 0
	lda	$D015
	ora	#$01	
	sta	$D015
	lda	$D01E		;Animations contact
	lda	$D010		;Position X MSB sprites 0..7
	and	#$FE	
	sta	$D010		;Position X MSB sprites 0..7
	rts	

W9683:
	lda	$81
	clc	
	adc	#$5F		;===================================
	sta	$4404		;PLAYER NUMBER
	jsr	W9763	
	ldx	#$00	
	ldy	#$0C	
W9692:
	lda	$87,x
	and	#$0F	
	clc	
	adc	#$5E	
	sta	$4400,y	
	dey	
	lda	$87,x
	lsr	
	lsr	
	lsr	
	lsr	
	clc	
	adc	#$5E	
	sta	$4400,y	
	dey	
	inx	
	cpy	#$08	
	bne	W9692	
	lda	$B3
	clc	
	adc	#$5D	
	cmp	#$5D	
	bne	W96BA	
	lda	#$5E		;$5E is the 0 character
W96BA:
	sta	$4417		;Displays this to screen - number of lives
	lda	$47
	sta	$27
	ldx	#$20	
W96C3:
	ldy	#$52	
W96C5:
	lda	$27
	beq	W96DC	
	tya	
	sta	$4400,x	
	dec	$27
	dey	
	cpy	#$4E	
	bne	W96C5	
	lda	$27
	beq	W96DC	
	inx	
	jmp	W96C3	

W96DC:
	inx	
	cpx	#$28	
	beq	W96E9	
	lda	#$5D	
	sta	$4400,x	
	jmp	W96DC	

W96E9:
	ldx	#$00	
W96EB:
	lda	W808B,x	
	sta	$47E2,x	
	inx	
	cpx	#$02	
	bne	W96EB	
	clc	
	lda	$AF
	and	#$0F	
	adc	#$3F	
	sta	$47E5	
	lda	$AF
	lsr	
	lsr	
	lsr	
	lsr	
	clc	
	adc	#$3F	
	sta	$47E4	
	lda	$7F
	beq	W9736	
	ldx	#$00	
W9712:
	lda	W8086,x	
	sta	$47D0,x	
	inx	
	cpx	#$05	
	bne	W9712	
	lda	$59
	and	#$0F	
	clc	
	adc	#$3F	
	sta	$47D7	
	lda	$59
	lsr	
	lsr	
	lsr	
	lsr	
	clc	
	adc	#$3F	
	sta	$47D6	
	jmp	W9743	

W9736:
	ldx	#$00	
W9738:
	lda	W808B+2,x	
	sta	$47D0,x	
	inx	
	cpx	#$08	
	bne	W9738	
W9743:
	lda	$5B
	beq	W9755	
	ldx	#$00	
W9749:
	lda	W8082,x	
	sta	$47C1,x	
	inx	
	cpx	#$04	
	bne	W9749	
	rts	

W9755:
	ldx	#$00	
W9757:
	lda	W807E,x	
	sta	$47C1,x	
	inx	
	cpx	#$04	
	bne	W9757	
	rts	

W9763:
	clc	
	sed	
	php	
	ldx	#$00	
W9768:
	plp	
	lda	$87,x
	adc	$7A,x
	sta	$87,x
	php	
	inx	
	cpx	#$02	
	bne	W9768	
	plp	
	cld	
	lda	#$00	
	sta	$7A
	sta	$7B
	lda	$88
	and	#$F0	
	cmp	$8A
	beq	W9792	
	sta	$8A
	ldx	$B3
	inx	
	cpx	#$0A	
	bne	W9790	
	ldx	#$09	
W9790:
	stx	$B3
W9792:
	rts	

W9793:
	lda	$7D
	bne	W97BB	
	lda	#$6B	
	sta	$53
	lda	$D001		;Position Y sprite 0
	cmp	#$98	
	bpl	W97BC	
	ldx	$D000		;Position X sprite 0
	lda	$D010		;Position X MSB sprites 0..7
	and	#$01	
	beq	W97B4	
	cpx	#$44	
	bcc	W97BC	
	jsr	W99B2	
	rts	

W97B4:
	cpx	#$14	
	bcs	W97BC	
	jsr	W99B2	
W97BB:
	rts	

W97BC:
	lda	$D01F		;Animation/background contact
	ldx	$79
	bne	W982D	
	ldx	$D001		;Position Y sprite 0
	cpx	#$E8	
	bcs	W982D	
	cpx	#$A8	
	bmi	W97D6	
	and	#$01	
	beq	W982D	
	jsr	W99B2	
	rts	

W97D6:
	cpx	#$98	
	bpl	W97DE	
	cpx	#$48	
	bmi	W982E	
W97DE:
	lda	$D01E
	sta	$5A
	and	#$01	
	beq	W982D	
	lda	$5A
	and	#$02	
	beq	W9803	
	lda	#$01	
	sta	$4F
	lda	$D015
	and	#$FD	
	sta	$D015
	lda	#$07	
	sta	$D027		;Color sprite 0
	lda	#$01	
	jsr	W9B73	
W9803:
	lda	$5A
	and	#$04	
	beq	W9813	
	lda	$47FA	
	cmp	#$68	
	beq	W9813	
	jsr	W99B2	
W9813:
	lda	$5A
	and	#$08	
	beq	W981D	
	jsr	W99B2	
	rts	

W981D:
	lda	$5A
	and	#$10	
	beq	W982D	
	lda	$47FC	
	cmp	#$76	
	bne	W982D	
	jsr	W99B2	
W982D:
	rts	

W982E:
	lda	#$0D	
	sta	$D027
	jsr	W9984	
	bmi	W987C	
	tax	
	lda	$A7,x
	bmi	W987C	
	bne	W9880	
W983F:
	stx	$49
	lda	#$37	
	sta	$4E
	lda	#$05	
	sta	$4D
	jsr	W9432	
	lda	#$FF	
	sta	$A7,x
	lda	#$02	
	jsr	W9B73	
	ldx	$47
	jsr	W9948	
	sta	$7A
	lda	#$60	
	sta	$7F
	sta	$86
	jsr	W9763	
	dec	$B2
	bne	W987B	
	lda	#$00	
	sta	$77
	lda	#$07	
	jsr	W9B73	
	lda	#$01	
	sta	$85
	sta	$7B
	jsr	W9763	
W987B:
	rts	

W987C:
	jsr	W99B2	
	rts	

W9880:
	cmp	#$01	
	bne	W983F	
	lda	#$FF	
	sta	$B4
	inc	$4F
	jmp	W983F	

W988D:
	lda	$79
	bne	W989D	
	lda	$7D
	bne	W989D	
	lda	$4A
	bmi	W989D	
	cmp	#$05	
	bmi	W989E	
W989D:
	rts	

W989E:
	ldx	$4A
	stx	$64
	jsr	W9D4C	
	lda	$0E
	asl	
	asl	
	asl	
	asl	
	sec	
	sbc	#$04	
	sta	$66
	lda	$0E
	asl	
	asl	
	adc	#$12	
	sta	$65
W98B8:
	iny	
	lda	($04),y
	beq	W9922	
	asl	
	asl	
	ldx	$0D
	cpx	#$01	
	beq	W98D7	
	ldx	$4A
	sec	
	sbc	$94,x
	clc	
	adc	#$04	
	sta	$63
	sec	
	sbc	$66
	sta	$62
	jmp	W98E2	

W98D7:
	ldx	$4A
	clc	
	adc	$94,x
	sta	$62
	adc	$65
	sta	$63
W98E2:
	lda	$8B,x
	asl	
	asl	
	sta	$2D
	clc	
	adc	$62
	bcs	W98F1	
	cmp	#$C8	
	bcc	W98F4	
W98F1:
	sec	
	sbc	#$C8	
W98F4:
	sta	$60
	lda	$2D
	clc	
	adc	$63
	bcs	W9901	
	cmp	#$C8	
	bcc	W9904	
W9901:
	sec	
	sbc	#$C8	
W9904:
	sta	$61
	lda	$D010		;Position X MSB sprites 0..7
	lsr	
	lda	$D000		;Position X sprite 0
	ror	
	sec	
	sbc	#$06	
	ldx	$61
	cpx	$60
	bcc	W992A	
	cmp	$60
	bcc	W98B8	
	cmp	$61
	bcs	W98B8	
	jmp	W9935	

W9922:
	lda	#$6D	
	sta	$53
	jsr	W99B2	
W9929:
	rts	

W992A:
	cmp	$60
	bcs	W9935	
	cmp	$61
	bcc	W9935	
	jmp	W98B8	

W9935:
	lda	$0D
	cmp	#$02	
	bne	W9929	
	lda	($04),y
	bpl	W9947	
	ldx	$4A
	lda	$A2,x		;Real time clock HMS (1/60 sec)
	cmp	#$09	
	beq	W9922	
W9947:
	rts	

W9948:
	sed	
	clc	
	lda	#$00	
W994C:
	dex	
	bmi	W9954	
	adc	#$02	
	jmp	W994C	

W9954:
	sta	$59
	adc	#$05	
	ldx	$4F
	bne	W9969	
	tax	
	lda	$D015
	and	#$FE	
	sta	$D015
	txa	
	jmp	W997E	

W9969:
	cpx	#$01	
	bne	W9977	
	ldx	#$65	
	stx	$47F8	
	adc	#$14	
	jmp	W997E	

W9977:
	ldx	#$66	
	stx	$47F8	
	adc	#$28	
W997E:
	ldx	#$05	
	stx	$7D
	cld	
	rts	

W9984:
	lda	$D010		;Position X MSB sprites 0..7
	and	#$01	
	bne	W9990	
	ldx	#$00	
	jmp	W9992	

W9990:
	ldx	#$08	
W9992:
	lda	$D000		;Position X sprite 0
	cmp	W8124,x	
	bcc	W99AC	
	inx	
	cmp	W8124,x	
	bcc	W99AF	
	inx	
	cpx	#$08	
	beq	W99AC	
	cpx	#$0A	
	beq	W99AC	
	jmp	W9992	

W99AC:
	lda	#$FF	
	rts	

W99AF:
	txa	
	lsr	
	rts	

W99B2:
	lda	#$5A	
	sta	$7D
	lda	$53
	cmp	#$6B	
	bne	W99C0	
	lda	#$04	
	bne	W99C2	
W99C0:
	lda	#$03	
W99C2:
	jsr	W9B73	
	lda	#$0D	
	sta	$D027
	nop		;originally dec $B3 ==== REDUCES NUMBER OF LIVES === 
	nop		;nop, nop gives infinite lives
	lda	#$01	
	sta	$84
	rts	

W99D1:
	stx	$47F8	
	lda	$D01F
	lda	#$00	
	sta	$79
	lda	$48
	sta	$5D
	rts	

W99E0:
	clc	
	lda	$AD
	ldy	$5B
	beq	W99E9	
	adc	#$03	
W99E9:
	sta	$2D
	stx	$23
	ldx	$0F
	asl	
	asl	
	asl	
	adc	$2D
	adc	$0F
	tay	
	lda	W80E3+2,y	
	and	#$0F	
	sta	$32,x
	lda	W80E3+2,y	
	lsr	
	lsr	
	lsr	
	lsr	
	sta	$3B,x
	ldx	$23
	rts	

W9A0A:
	lda	$D007		;Position Y sprite 3
	cmp	#$68	
	beq	W9A29	
	lda	#$68	
	sta	$D007		;Position Y sprite 3
	lda	$BD
	sta	$B9
	lda	$BE
	sta	$BA
	lda	$BF
	sta	$BB
	lda	$C0
	sta	$BC
	jmp	W9A41	

W9A29:
	lda	#$98	
	sta	$D007		;Position Y sprite 3
	sta	$D009		;Position Y sprite 4
	lda	#$82	
	sta	$B9
	lda	#$08	
	sta	$BA
	lda	#$5A	
	sta	$BB
	lda	#$08	
	sta	$BC		;Pointer: current file name
W9A41:
	lda	$B9
	sta	$D006		;Position X sprite 3
	lda	$D010		;Position X MSB sprites 0..7
	and	#$F7	
	ora	$BA
	sta	$D010		;Position X MSB sprites 0..7
	lda	#$01	
	sta	$C1
	lda	#$69	
	sta	$47FB	
	lda	$D015
	and	#$F7	
	sta	$D015
	rts	

W9A62:
	lda	#$01	
	sta	$52
	jsr	W9B53	
	lda	$D010		;Position X MSB sprites 0..7
	and	#$08	
	cmp	$BA
	bne	W9A8D	
	lda	$D006		;Position X sprite 3
	cmp	$B9
	bne	W9A8D	
W9A79:
	lda	#$01	
	eor	$C1
	sta	$C1
	beq	W9A87	
	lda	#$69	
	sta	$47FB	
	rts	

W9A87:
	lda	#$73	
	sta	$47FB	
	rts	

W9A8D:
	lda	$D010		;Position X MSB sprites 0..7
	and	#$08	
	cmp	$BC		;Pointer: current file name
	bne	W9A9D	
	lda	$D006		;Position X sprite 3
	cmp	$BB
	beq	W9A79	
W9A9D:
	dec	$C2
	bne	W9AB5	
	lda	#$0C	
	sta	$C2		;I/O starting address
	lda	$C1		;I/O starting address
	beq	W9ABA	
	lda	#$69	
	cmp	$47FB	
	bne	W9AB6	
	lda	#$6A	
	sta	$47FB	
W9AB5:
	rts	

W9AB6:
	sta	$47FB	
	rts	

W9ABA:
	lda	#$73	
	cmp	$47FB	
	bne	W9AC7	
	lda	#$74	
	sta	$47FB	
	rts	

W9AC7:
	sta	$47FB	
	rts	

W9ACB:
	lda	$3B,x
	asl	
	sta	$52
	lda	#$BD	
	sta	$67
	lda	#$00	
	sta	$68
	lda	#$BE	
	sta	$69
	lda	#$00	
	sta	$6A
	lda	#$08	
	sta	$6B
	jsr	W9CAC	
	lda	#$BF	
	sta	$67
	lda	#$C0	
	sta	$69
	jsr	W9CAC	
	lda	#$98	
	cmp	$D007
	beq	W9B18	
	lda	$C1
	sta	$2D
	lda	#$01	
	sta	$C1
	lda	$BD
	sta	$B9
	lda	$BE
	sta	$BA
	lda	$BF
	sta	$BB
	lda	$C0
	sta	$BC
	jsr	W9B53	
	lda	$2D
	sta	$C1
W9B18:
	lda	$D015
	and	#$08	
	bne	W9B3A	
	lda	$B0
	beq	W9B52	
	lda	$D010		;Position X MSB sprites 0..7
	and	#$08	
	beq	W9B52	
	lda	$D006		;Position X sprite 3
	cmp	#$5A	
	bcc	W9B52	
	lda	$D015
	ora	#$08	
	sta	$D015
	rts	

W9B3A:
	lda	$D010		;Position X MSB sprites 0..7
	and	#$08	
	beq	W9B52	
	lda	$D006		;Position X sprite 3
	cmp	#$5A	
	bcc	W9B52	
	lda	#$10	
	jsr	W9C9A	
	bne	W9B52	
	jsr	W9A0A	
W9B52:
	rts	

W9B53:
	lda	#$06	
	sta	$67
	lda	#$D0	
	sta	$68
	lda	#$10	
	sta	$69
	lda	#$D0	
	sta	$6A
	lda	#$08	
	sta	$6B
	lda	$52
	sta	$6D
	lda	$C1
	sta	$6C
	jsr	W9CB6	
	rts	

W9B73:
	sta	$75
	lda	$6E
	bne	W9BAE	
W9B79:
	lda	$75
	sta	$6F
	lda	#$01	
	sta	$6E
	sta	$73
	lda	$6F
	asl	
	tax	
	lda	W9D6B,x	
	sta	$56
	lda	W9D6C,x	
	sta	$57
	ldy	#$00	
	lda	($56),y
	and	#$7F	
	sta	$70
	sta	$72
	dec	$72
	lda	($56),y
	and	#$80	
	sta	$76
	iny	
	lda	($56),y
	sta	$71
	lda	#$02	
	jsr	W9C70	
W9BAD:
	rts	

W9BAE:
	lda	$75
	cmp	$6F
	bcc	W9BAD	
	lda	#$01	
	sta	$74
	bne	W9B79	
W9BBA:
	lda	$6E
	beq	W9C10	
	lda	$74
	beq	W9BC9	
	lda	#$00	
	sta	$74
	jmp	W9C61	

W9BC9:
	lda	$73
	beq	W9C11	
	lda	#$00	
	sta	$D418
	sta	$D405
	sta	$0C
	sta	$13
	sta	$D417
	lda	#$08	
	sta	$D403		;Voice 1: Wave form pulsation amplitude (hi byte)
	sta	$D40A		;Voice 2: Wave form pulsation amplitude (hi byte)
	sta	$D411		;Voice 3: Wave form pulsation amplitude (hi byte)
	ldx	#$00	
	ldy	#$00	
W9BEB:
	lda	($56),y
	and	#$F0	
	sta	$D406,x
	lda	($56),y
	asl	
	asl	
	asl	
	asl	
	ora	#$01	
	sta	$D404,x
	txa	
	clc	
	adc	#$07	
	tax	
	iny	
	cpy	#$03	
	bne	W9BEB	
	lda	#$03	
	jsr	W9C70	
	lda	#$00	
	sta	$73
W9C10:
	rts	

W9C11:
	inc	$72
	lda	$72
	cmp	$70
	bne	W9C10	
	lda	#$00	
	sta	$72
	lda	#$0F	
	sta	$D418
	ldx	#$00	
	ldy	#$00	
W9C26:
	lda	($56),y
	cmp	#$FF	
	beq	W9C5D	
	lda	$76
	beq	W9C3C	
	lda	($56),y
	sta	$D401,x		;Voice 1: Frequency control (hi byte)
	lda	#$00	
	sta	$D400,x		;Voice 1: Frequency control (lo byte)
	beq	W9C4D	
W9C3C:
	lda	($56),y
	lsr	
	lsr	
	sta	$D401,x		;Voice 1: Frequency control (hi byte)
	lda	($56),y
	ror	
	ror	
	ror	
	and	#$C0	
	sta	$D400,x		;Voice 1: Frequency control (lo byte)
W9C4D:
	txa	
	clc	
	adc	#$07	
	tax	
	iny	
	cpy	$71
	bne	W9C26	
	lda	$71
	jsr	W9C70	
	rts	

W9C5D:
	lda	#$00	
	sta	$6E
W9C61:
	lda	#$00	
	sta	$D418		;Select volume and filter mode
	sta	$D404		;Voice 1: Control registers
	sta	$D40B		;Voice 2: Control registers
	sta	$D412		;Voice 3: Control registers
	rts	

W9C70:
	clc	
	adc	$56
	sta	$56
	lda	#$00	
	adc	$57
	sta	$57
	rts	

W9C7C:
	ldx	$80
	inx	
	cpx	#$05	
	bne	W9C85	
	ldx	#$00	
W9C85:
	lda	$A7,x
	bne	W9C95	
	lda	#$05	
	jsr	W9C9A	
	bne	W9C95	
	stx	$49
	stx	$80
	rts	

W9C95:
	stx	$80
	ldx	#$FF	
	rts	

W9C9A:
	cmp	$5D
	bcs	W9CA1	
W9C9E:
	lda	#$01	
	rts	

W9CA1:
	lda	$5D
	cmp	$5C
	beq	W9C9E	
	sta	$5C
	lda	#$00	
	rts	

W9CAC:
	lda	$3B,x
	asl	
	sta	$6D
	lda	W811B,x	
	sta	$6C
W9CB6:
	stx	$23
	ldx	#$00	
W9CBA:
	lda	($67,x)
	tay	
	lda	$6C
	beq	W9CE8	
	lda	($69,x)
	cpy	#$FF	
	bne	W9CCB	
	ora	$6B
	sta	($69,x)
W9CCB:
	and	$6B
	beq	W9CDD	
	cpy	#$8F	
	bne	W9CDD	
	lda	$6B
	eor	#$FF	
	and	($69,x)
	sta	($69,x)
	ldy	#$FF	
W9CDD:
	iny	
W9CDE:
	tya	
	sta	($67,x)
	dec	$6D
	bne	W9CBA	
	ldx	$23
	rts	

W9CE8:
	cpy	#$00	
	bne	W9D05	
	lda	($69,x)
	and	$6B
	beq	W9CFD	
	lda	$6B
	eor	#$FF	
	and	($69,x)
	sta	($69,x)
	jmp	W9D05	

W9CFD:
	lda	($69,x)
	ora	$6B
	sta	($69,x)
	ldy	#$8F	
W9D05:
	dey	
	jmp	W9CDE	

W9D09:
	ldy	#$15	
W9D0B:
	lda	$D000,y		;Position X sprite 0
	cpy	#$11	
	beq	W9D24	
	cpy	#$12	
	beq	W9D24	
	cpx	#$00	
	bne	W9D24	
	sta	$2D
	lda	$00FF,y		;Transient data area of BASIC
	sta	$D000,y		;Position X sprite 0
	lda	$2D
W9D24:
	sta	$00FF,y		;Transient data area of BASIC
	dey	
	bne	W9D0B	
	jmp	W9D32	

W9D2D:
	ldy	#$04	
	jmp	W9D34	

W9D32:
	ldy	#$3C	
W9D34:
	lda	$0086,y
	cpx	#$00	
	bne	W9D45	
	sta	$2D
	lda	$00C2,y
	sta	$0086,y
	lda	$2D
W9D45:
	sta	$00C2,y
	dey	
	bne	W9D34	
	rts	

W9D4C:
	lda	$AC
	asl	
	tax	
	lda	W8036,x	
	sta	$04
	inx	
	lda	W8036,x	
	sta	$05
	lda	$64
	asl	
	asl	
	asl	
	tay	
	lda	($04),y
	sta	$0D
	iny	
	lda	($04),y
	sta	$0E
	rts	

	.byte $98,$9E,$93,$9F,$5B,$9F,$13,$9F,$B6,$9E,$E2,$9F,$DA,$9D,$58,$9E
	.byte $7D,$9D,$0C,$03,$94,$94,$94,$71,$2D,$00,$59,$2D,$38,$59,$22,$00
	.byte $59,$2D,$38,$71,$2D,$00,$59,$2D,$38,$59,$22,$00,$59,$2D,$38,$77
	.byte $32,$00,$77,$32,$3C,$71,$26,$00,$71,$32,$3C,$64,$32,$00,$00,$32
	.byte $3C,$00,$22,$00,$00,$32,$3C,$77,$32,$00,$77,$32,$3C,$71,$22,$00
	.byte $71,$32,$3C,$64,$32,$00,$64,$32,$3C,$96,$22,$00,$96,$32,$3C,$86
	.byte $32,$00,$77,$32,$3C,$71,$22,$00,$64,$32,$3C,$59,$2D,$38,$FF,$04
	.byte $02,$94,$94,$04,$64,$2A,$64,$2A,$64,$2A,$64,$2A,$00,$32,$00,$32
	.byte $64,$32,$64,$32,$86,$2A,$86,$2A,$86,$2A,$00,$00,$86,$32,$86,$32
	.byte $86,$32,$86,$32,$A9,$22,$A9,$22,$A9,$22,$A9,$22,$96,$32,$86,$32
	.byte $7F,$32,$71,$32,$64,$2A,$64,$2A,$64,$2A,$64,$2A,$64,$32,$64,$32
	.byte $64,$32,$64,$32,$59,$26,$59,$26,$59,$26,$00,$00,$64,$32,$64,$32
	.byte $64,$32,$00,$00,$4B,$2D,$4B,$2D,$4B,$2D,$00,$00,$64,$32,$64,$32
	.byte $64,$32,$00,$00,$55,$22,$55,$22,$55,$22,$00,$00,$64,$32,$64,$32
	.byte $64,$32,$00,$00,$43,$2A,$43,$2A,$43,$2A,$43,$2A,$FF,$0C,$02,$94
	.byte $94,$04,$59,$38,$64,$43,$71,$38,$77,$43,$86,$38,$00,$43,$71,$38
	.byte $00,$43,$59,$38,$64,$43,$71,$38,$64,$43,$59,$38,$00,$43,$59,$38
	.byte $00,$43,$59,$38,$64,$43,$71,$38,$77,$43,$86,$38,$00,$43,$71,$38
	.byte $00,$43,$86,$3C,$77,$43,$71,$3C,$64,$43,$59,$38,$FF,$81,$03,$84
	.byte $44,$24,$09,$24,$17,$26,$FE,$FE,$2F,$FE,$FE,$30,$FE,$FE,$39,$FE
	.byte $FE,$3A,$FE,$FE,$4B,$E2,$FE,$42,$4C,$E3,$FF,$81,$03,$C4,$24,$14
	.byte $08,$2D,$E2,$1B,$FE,$FE,$18,$79,$FE,$16,$43,$FE,$14,$3D,$FE,$12
	.byte $FE,$FE,$10,$32,$FE,$10,$2E,$FE,$0F,$2B,$FE,$10,$43,$FE,$0D,$3F
	.byte $FE,$0B,$24,$FE,$0C,$21,$FE,$0B,$1F,$FE,$0A,$1E,$32,$0A,$1D,$30
	.byte $09,$1B,$2D,$09,$2C,$3E,$09,$19,$FE,$08,$19,$FE,$08,$17,$26,$07
	.byte $17,$43,$07,$17,$42,$07,$14,$3F,$06,$15,$2F,$07,$14,$2E,$13,$2C
	.byte $FE,$06,$13,$1E,$06,$12,$1D,$FF,$81,$02,$64,$14,$04,$08,$0F,$07
	.byte $10,$1E,$27,$22,$65,$26,$74,$2B,$09,$32,$FE,$36,$FE,$2F,$38,$28
	.byte $31,$23,$2B,$1F,$2B,$1D,$58,$1E,$3B,$22,$65,$25,$73,$2B,$1E,$32
	.byte $27,$33,$1D,$2C,$1D,$26,$34,$22,$66,$1E,$2A,$1F,$57,$1E,$5E,$23
	.byte $6A,$28,$21,$2D,$1E,$1F,$34,$32,$27,$2B,$1D,$25,$31,$22,$11,$FF
	.byte $81,$02,$54,$24,$04,$04,$0E,$17,$26,$16,$31,$16,$1C,$17,$28,$16
	.byte $2B,$18,$27,$1B,$28,$1C,$2A,$16,$1E,$18,$30,$1B,$34,$1C,$10,$1C
	.byte $40,$1F,$33,$1F,$44,$04,$1F,$03,$1B,$1D,$2E,$08,$23,$1B,$23,$1D
	.byte $2A,$13,$1D,$1D,$41,$1E,$44,$FF,$81,$01,$B4,$04,$04,$0A,$0B,$0B
	.byte $0C,$0E,$0B,$0C,$0C,$0D,$0D,$0B,$0C,$0D,$0C,$0E,$0F,$0E,$0C,$0E
	.byte $0F,$10,$0E,$0E,$0F,$0F,$10,$0D,$0F,$0F,$10,$12,$10,$0F,$10,$12
	.byte $13,$10,$10,$10,$12,$14,$12,$11,$12,$14,$16,$19,$12,$14,$16,$19
	.byte $1B,$13,$16,$18,$1A,$1D,$14,$18,$1A,$1D,$1E,$16,$19,$1D,$1F,$24
	.byte $2B,$1C,$1E,$24,$2B,$32,$FF,$03,$01,$94,$04,$04,$2D,$00,$28,$00
	.byte $26,$00,$2D,$00,$28,$00,$26,$00,$2D,$00,$28,$00,$26,$FF,$AA,$55
	.byte $55,$AA,$55,$55,$AA
