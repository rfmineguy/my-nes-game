; general cpu regs
.define CPU_RAM_ADDR           $0000
.define CPU_PPU_CTRL_REGS      $2000
.define CPU_APU_REGS           $4000

; Controller ports
.define CONTROLLER_P1          $4016
.define CONTROLLER_P2          $4017

; Controller button flags
.define BUTTON_A               %10000000
.define BUTTON_B               %01000000
.define BUTTON_SEL             %00100000
.define BUTTON_STT             %00010000
.define BUTTON_UP              %00001000
.define BUTTON_DOWN            %00000100
.define BUTTON_LEFT            %00000010
.define BUTTON_RIGHT           %00000001

; APU registers
.define APU_FRAME_COUNTER_REG  $4017

; PPU registers
.define PPU_CTRL               $2000
.define PPU_MASK               $2001
.define PPU_STATUS             $2002
.define PPU_OAMADDR            $2003
.define PPU_OAMDATA            $2004
.define PPU_SCROLL             $2005
.define PPU_ADDR               $2006
.define PPU_DATA               $2007
.define PPU_OAMDMA             $4014

; pattern tables
.define PPU_PATTERN_TABLE_ZERO $0000
.define PPU_PATTERN_TABLE_ONE  $1000

; name tables
.define PPU_NAME_TABLE_ZERO    $2000
.define PPU_NAME_TABLE_ONE     $2400
.define PPU_NAME_TABLE_TWO     $2800
.define PPU_NAME_TABLE_THREE   $2C00

; attribute tables
.define PPU_ATTR_TABLE_ZERO    $23C0
.define PPU_ATTR_TABLE_ONE     $27C0
.define PPU_ATTR_TABLE_TWO     $2BC0
.define PPU_ATTR_TABLE_THREE   $2FC0

; pallete data
.define PPU_PALLETE_BG         $3F00
.define PPU_PALLETE_SP         $3F10

; useful values
.define NES_PIXELS_WIDE        #256
.define NES_TILES_WIDE         NES_PIXELS_WIDE/#8   ;32

.define NES_PIXELS_TALL        #240
.define NES_TILES_TALL         NES_PIXELS_TALL/#8   ;30