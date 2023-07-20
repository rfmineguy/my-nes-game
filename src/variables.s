.export zp_var
.export zp_world_addr
.export zp_buttons_1_curr_frame
.export zp_buttons_1_prev_frame
.export zp_buttons_1_pressed
.export zp_buttons_2_curr_frame
.export zp_buttons_2_prev_frame
.export zp_buttons_2_pressed
.export zp_cursor_index_pos
.export zp_cursor_vertical_pos ; 0 - top player, 1 - center area, 2 - bottom player
.export zp_prng_seed
.export zp_dice_1
.export zp_dice_2
.export zp_nmi_retraces
.export zp0
.export zp1
.export Res
.export ResHi

.segment "ZEROPAGE"
zp_var:                     .res 2
zp_world_addr:              .res 2
zp_buttons_1_curr_frame:    .res 1
zp_buttons_1_prev_frame:    .res 1
zp_buttons_1_pressed:       .res 1
zp_buttons_2_curr_frame:    .res 1
zp_buttons_2_prev_frame:    .res 1
zp_buttons_2_pressed:       .res 1
zp_cursor_index_pos:        .res 1
zp_cursor_vertical_pos:     .res 1

zp_prng_seed:               .res 2
zp_dice_1:                  .res 1
zp_dice_2:                  .res 1

zp0:                        .res 1  ; for 'div' subroutine (see arith.s)
zp1:                        .res 1  ;  -
Res:                        .res 1
ResHi:                      .res 1 

zp_nmi_retraces:            .res 1