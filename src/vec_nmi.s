.export vec_nmi
.export wait_nmi
.include "inc/nes_constants.inc"
.include "inc/controllers.inc"
.include "inc/variables.inc"

.segment "STARTUP"
wait_nmi:
    lda zp_nmi_retraces
@notYet:
    cmp zp_nmi_retraces
    beq @notYet
    rts

vec_nmi:
    jsr ReadControls

    bit PPU_STATUS          ; read PPU_STATUS
    lda #$00                ; zero x scroll
    sta PPU_SCROLL          ; -
    lda #$00                ; zero y scroll
    sta PPU_SCROLL          ; -

    ; prepare ppu sprites
    lda #$02                ; $0200 (Sprite data) -> PPU
    sta PPU_OAMDMA          ; -

    lda #%00011110          ; show sprites/background (everywhere)
    sta PPU_MASK            ; -
    inc zp_nmi_retraces
    rti