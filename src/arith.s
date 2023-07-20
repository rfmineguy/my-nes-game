;.export div
;.export div2
;.export modulus6
;.export Division
.include "inc/variables.inc"

; Divides two 8-bit numbers with an 8-bit result
; zp0=numerator, zp1=denominator
; Out: zp0=quotient, zp1=remainder
div:
	lda #$00
	ldx #$08
	asl zp0
:	rol
	cmp zp1
	bcc :+
	sbc zp1
:	rol zp0
	dex
	bne :-
	sta zp1
	rts


; 8-bit / 8-bit = 8-bit quotient, 8-bit remainder (unsigned)
; 
;     Inputs:
;         zp0 = 8-bit numerator
;         zp1 = 8-bit denominator
;     Outputs:
;         zp0 bit quotient of zp0 / zp1
;         accumulator = remainder of zp0 / zp1
; 
div2:
   lda #0
   ldx #8
   asl zp0
L1:
   rol 
   cmp zp1
   bcc L2
   sbc zp0
L2:
   rol zp0
   dex
   bne L1
   rts 

;   Input
;       zp0 = 8-bit numerator
;       N/A   8-bit denominator (6)
;   Outputs
;       A   = remainder (zp0 % 6)
modulus6:
    ldx #$00
    clc 
    lda zp0
modulus6_L1:
    sbc #6          ; A = A - 6 - C
    bpl modulus6_L1 ; branch on NOT negative
modulus6_end:
    clc 
    adc #6
    rts

;8-bit divide
;by Bregalad
;Enter with A = Dividend, Y=Divisor
;Output with YX = (A/Y) << 8, A = remainder
Division:
	sta zp0		;Stores dividend
	sty zp1		;Stores divisor
	ldy #$00
	sty ResHi	;Clear result, setting up a ring counter
        iny             ;by initializing the result to $0001.
        sty Res         ;When the 1 gets shifted out, we're done

	ldy #$10	;The loop is for 16-bit result
 	asl zp0
	rol A		;Shift divisor in 1 bit
        bcs :+           ;If carry is set, the dividend is already greater
	cmp zp1		;Check if fractional dividend is greater than divisor
	bcc :++
:	sbc zp1 	;Subtract (C is always set)
:	rol Res		;Shift result (1 if subtraction was done, 0 otherwise)
	rol ResHi
	bcc :-
	ldx Res
	ldy ResHi
	rts