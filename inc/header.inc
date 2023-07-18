.segment "HEADER"               ; not used on real hardware (only useful for emulators)
.byte "NES", $1a                ; iNES
.byte $02                       ; 2x
.byte $01
.byte %00000000
.byte $00, $00, $00, $00
.byte $00, $00, $00, $00, $00