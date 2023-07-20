.include "inc/variables.inc"
.export draw_buff_reset
.export draw_buff_append_byte

draw_buff_reset:
    lda #00
    sta vram_draw_buffer_size
    rts

; append byte to the draw buffer
draw_buff_append_byte:
    ldx vram_draw_buffer_size
    sta vram_draw_buffer, X
    inc vram_draw_buffer_size
    rts