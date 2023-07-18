.export PalleteData
.export WorldData
.export SpriteData

.segment "STARTUP"
PalleteData:
.byte $0f,$17,$28,$39
.byte $0f,$30,$26,$05
.byte $0f,$20,$10,$00
.byte $0f,$13,$23,$33
.byte $0f,$1c,$2b,$39
.byte $0f,$06,$15,$36
.byte $0a,$05,$26,$30
.byte $22,$16,$27,$18

WorldData:
.incbin "res/world_empty.bin"

SpriteData:
.byte $10, $00, $00, $08 ; y-pos, tile-num, pallete-num, x-pos
.byte $10, $01, $00, $10
.byte $18, $02, $00, $08
.byte $18, $03, $00, $10
.byte $20, $04, $00, $08
.byte $20, $05, $00, $10
.byte $28, $06, $00, $08
.byte $28, $07, $00, $10

.segment "CHARS"
.incbin "res/spritesheet.chr"