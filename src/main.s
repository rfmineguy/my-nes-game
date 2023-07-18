.include "inc/header.inc"
.include "inc/vectors.inc"

.segment "STARTUP"
; automatically calls vec_reset due to VECTORS segment
jmp vec_reset

.segment "VECTORS"
.word vec_nmi
.word vec_reset
.word 0             ; irq vec not used

.segment "CHARS"