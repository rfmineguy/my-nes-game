.export zp_var
.export zp_world_addr
.export zp_buttons_1_curr_frame
.export zp_buttons_1_prev_frame
.export zp_buttons_1_pressed
.export zp_buttons_2_curr_frame
.export zp_buttons_2_prev_frame
.export zp_buttons_2_pressed
.export zp_cursor_index_pos
.export zp_nmi_retraces

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

zp_nmi_retraces:            .res 1