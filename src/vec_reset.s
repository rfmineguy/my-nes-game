.export vec_reset
.include "inc/nes_constants.inc"
.include "inc/variables.inc"
.include "inc/bindat.inc"

.segment "STARTUP"
vec_reset:
    sei         ;disable cpu interrupts
    cld         ;disable decimal mode (NES 6502 doesn't support it)
    ldx #$40
    stx APU_FRAME_COUNTER_REG
    ldx #$ff
    tsx 
    inx 

init_variables:
    lda #00
    sta zp_var
    sta zp_var+1
    sta zp_world_addr
    sta zp_world_addr+1

    ldx #00
    lda #00

clear_mem:              ; Initialize RAM to known state
    sta $0000, X        ;   $0000->$00ff set to 0
    sta $0100, X        ;   $0100->$01ff set to 0
    sta $0200, X        ;   $0200->$02ff set to 0
    sta $0300, X        ;   $0300->$03ff set to 0
    sta $0400, X        ;   $0400->$04ff set to 0
    sta $0500, X        ;   $0500->$05ff set to 0
    sta $0600, X        ;   $0600->$06ff set to 0
    sta $0700, X        ;   $0700->$07ff set to 0
    lda #$ff            ;   -
    sta $0200, X        ;   $0200->$02ff set to 0  (Set to FF)
    lda #$00
    inx 
    bne clear_mem

:
    bit $2002
    bpl :-

    lda #$02        ; Tell the PPU where sprite data will live ($0200)
    sta PPU_OAMDMA  ;  -
    nop             ;  -

    lda #$00        
    sta PPU_MASK    ; disable rendering

    lda #%00000000
    sta PPU_CTRL    ; PPUDATA increment mode = 1 byte

    lda #$3F        ; PPUADDR -> 3f00 (Background pallete memory)
    sta PPU_ADDR    ; -
    lda #$00        ; -
    sta PPU_ADDR    ; -

    ldx #$00
    lda #$00
load_palletes:          ; Load the pallete data into ppu background pallete
    lda PalleteData, X  ;   put PalleteData[X] into A
    sta PPU_DATA        ;   store it into ppu memory (auto inc)
    inx                 ;   increment index
    cpx #$20            ;   check if we've loaded 32 bytes
    bne load_palletes

init_load_world:        ; Load the address of the WorldData into zeropage memory
    lda #<WorldData     ;   put `WorldData & 0xFF` into A  (the low byte)
    sta zp_world_addr   ;   store it in memory
    lda #>WorldData     ;   put `WorldData & 0xFF00` into A (the high byte)
    sta zp_world_addr+1 ;   ...

                        ; Setup PPU for actually loading world data to it
    bit PPU_STATUS      ;   make sure that PPU_ADDR is ready by reading PPU_STATUS
    lda #$20            ;   Load $2000 into PPU_ADDR ($2000 is the location of nametable 0)
    sta PPU_ADDR        ;     -
    lda #$00            ;     -
    sta PPU_ADDR        ;     -

    ldx #$00                ; X will act as the high byte of a two byte address
    ldy #$00                ; Y will act as the low byte of a two byte address
load_world:                 ; Load the memory from WorldData into PPU nametable 0
    lda (zp_world_addr), Y  ;   A = zp_world_addr[Y]
    sta PPU_DATA            ;   Put A into PPU nametable 0, increment PPU_ADDR
    iny                     ;   increment index
    cpx #$03                ;   check if the high byte is 03. if so, the high byte is as high as it will go
    bne :+                  ;   goto next label if `x - 3 != 0`
    cpy #$C0                ;   check if the low byte is C0. if so, we are done (we have loaded the whole world)
    beq load_world_finish   ;    - if `Y - C0 != 0` (if Y - #$C0 > 0 that means we're not done)
:
    cpy #$00                ;   check if Y has wrapped around (FF + 01 = 00)
    bne load_world          ;   if no,  go back to load world
    inx                     ;   if yes, increment address high byte
    inc zp_world_addr+1     ;   if yes, increment zp_world_addr high byte (little endian)
    jmp load_world          ;   go back to load world
load_world_finish:
    ldx #$00
    ldy #$00
set_attributes:
    lda #$55
    sta PPU_DATA
    inx
    cpx #$40
    bne set_attributes

    ldx #$00
    ldy #$00
load_sprites:           ; Load sprite data into the 100 byte block at $0200 we left open
    lda SpriteData, X   ;   A = SpriteData[X]
    sta $0200, X        ;   *($0200 + X) = A
    inx                 ;   -
    cpx #$20            ;   32 bytes of sprite oam data
    bne load_sprites    ;   -

    ;jmp inf_loop
                        ; Something is wrong with this code
                        ; Re-Enable NES features
    cli                 ;   Interrutps = ON
    lda #%10000000      ;   NMI = ON, BCKG (Use CHR2 tiles, $1000)
    sta PPU_CTRL        ;    - clears background OR wrong CH buffer?
    lda #%00011110      ;   SPRITES/BCKG left 8px = ON, SPRITES/BCKG = ON, RENDERING=ON
    sta PPU_MASK        ;    -

inf_loop:
    jmp inf_loop