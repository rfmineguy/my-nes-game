.export vec_nmi
.include "inc/nes_constants.inc"

.segment "STARTUP"
vec_nmi:
    bit PPU_STATUS          ; read PPU_STATUS
    ; prepare ppu sprites

    lda #$20                ; $0200 (Sprite data) -> PPU
    sta PPU_OAMDATA         ; -
    lda #%00011110
    sta PPU_MASK
    rti