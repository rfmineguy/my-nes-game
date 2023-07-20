.export roll_dice_1
.export roll_dice_2

.include "inc/variables.inc"
.include "inc/random.inc"

roll_dice_1:
rng_dice1_lp:
    lda zp_nmi_retraces
    sta zp_prng_seed
    jsr prng
    and #%00000111
    sta zp_dice_1
    cmp #6
    beq rng_dice1_lp
    cmp #7
    beq rng_dice1_lp
    rts 

roll_dice_2:
rng_dice2_lp:
    lda zp_nmi_retraces
    sta zp_prng_seed
    jsr prng
    and #%000000111
    sta zp_dice_2
    cmp #6
    beq rng_dice2_lp
    cmp #7
    beq rng_dice2_lp
    rts 