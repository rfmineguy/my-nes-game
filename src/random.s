.export prng
.include "inc/variables.inc"

; https://www.nesdev.org/wiki/Random_number_generator
; Returns a random 8-bit number in A (0-255), clobbers Y (unknown).
prng:
	lda zp_prng_seed+1
	tay ; store copy of high byte
	; compute zp_prng_seed+1 ($39>>1 = %11100)
	lsr ; shift to consume zeroes on left...
	lsr
	lsr
	sta zp_prng_seed+1 ; now recreate the remaining bits in reverse order... %111
	lsr
	eor zp_prng_seed+1
	lsr
	eor zp_prng_seed+1
	eor zp_prng_seed+0 ; recombine with original low byte
	sta zp_prng_seed+1
	; compute zp_prng_seed+0 ($39 = %111001)
	tya ; original high byte
	sta zp_prng_seed+0
	asl
	eor zp_prng_seed+0
	asl
	eor zp_prng_seed+0
	asl
	asl
	asl
	eor zp_prng_seed+0
	sta zp_prng_seed+0
	rts