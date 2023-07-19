.export ReadControls
.include "inc/nes_constants.inc"
.include "inc/variables.inc"

ReadControls:
    ldx zp_buttons_1_curr_frame
    stx zp_buttons_1_prev_frame
    ldx zp_buttons_2_curr_frame
    stx zp_buttons_2_prev_frame

    lda #$00
    sta zp_buttons_1_curr_frame
    sta zp_buttons_2_curr_frame

    lda #$01
    sta CONTROLLER_P1
    sta zp_buttons_2_curr_frame
    lsr A
    sta CONTROLLER_P1

@P1Loop:
    lda CONTROLLER_P1
    and #%00000011
    cmp #$01
    rol zp_buttons_1_curr_frame

    ldx #$01
@P1Pressed:
    lda zp_buttons_1_prev_frame
    eor #%11111111
    and zp_buttons_1_curr_frame
    sta zp_buttons_1_pressed
    
@P2Loop:
    lda CONTROLLER_P2
    and #%00000011
    cmp #$01
    rol zp_buttons_2_curr_frame
    bcc @P1Loop



@ReadControlsEnd:
    rts
