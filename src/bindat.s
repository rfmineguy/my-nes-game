.export PalleteData
.export AttributeData
.export WorldData
.export SpriteData
.export CursorXPosTable
.export CursorYPosTable

.segment "STARTUP"
PalleteData:
.byte $0f,$17,$28,$39
.byte $0f,$30,$26,$05
.byte $0f,$20,$10,$00
.byte $22,$16,$27,$18
.byte $0f,$13,$23,$33
.byte $0f,$1c,$2b,$39
.byte $0f,$06,$15,$36
.byte $0a,$05,$26,$30

WorldData:
.incbin "res/world2.bin"

AttributeData:  ; 64 bytes
; bits 0-1 are top right
; bits 2-3 are bottom left
; bits 4-5 are top left
; bits 6-7 are bottom right
.byte %00111111, %00001111, %00001111, %00001111, %00001111, %00001111, %00001111, %11001111 ; row 0
.byte %00110011, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %11001100 ; row 1
.byte %00110011, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %11001100 ; row 2
.byte %00110011, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %11001100 ; row 3
.byte %00110011, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %11001100 ; row 4
.byte %00110011, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %11001100 ; row 5
.byte %00110011, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %11001100 ; row 6
.byte %00110011, %00001111, %00001111, %00001111, %00001111, %00001111, %00001111, %11001100 ; row 7

SpriteData:
.byte $40, $06, $00, $10 ; y-pos, tile-num, pallete-num, x-pos
.byte $00, $00, $00, $00
.byte $00, $00, $00, $00
.byte $00, $00, $00, $00
.byte $00, $00, $00, $00
.byte $00, $00, $00, $00
.byte $00, $00, $00, $00
.byte $00, $00, $00, $00

CursorXPosTable:
.byte $10, $28, $40, $58, $70, $88, $A0, $B8, $D0, $E8

CursorYPosTable:
.byte $40, $70, $E0

.segment "CHARS"
.incbin "res/spritesheet.chr"