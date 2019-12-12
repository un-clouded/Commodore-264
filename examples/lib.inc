
TIMER_A_LO =        $ff00
TIMER_A_HI =        $ff01
TIMER_B_LO =        $ff02
TIMER_B_HI =        $ff03
TIMER_C_LO =        $ff04
TIMER_C_HI =        $ff05
CONF_AND_HSP =      $ff07
TED_INPUT =         $ff08
INTERRUPTS =        $ff09
INTERRUPT_CONTROL = $ff0a
RASTER_LINE =       $ff0b
BORDER_COLOR =      $ff19
KEYBOARD_COLUMN =   $fd30

; CONF_AND_HSP
REVERSE_ENABLE =    0 << 7
REVERSE_DISABLE =   1 << 7
PAL_NTSC =          1 << 6
NO_FREEZE =         0 << 5
HI_RES_MODE =       0 << 4
MULTICOLOR_MODE =   1 << 4
WIDTH_38_COLUMNS =  0 << 3
WIDTH_40_COLUMNS =  1 << 3
HSP = 0


CHROUT = $ffd2


IRQ_VECTOR = $0314


; for references to `label+LO` and `label+HI`
LO = 0
HI = 1


SCREEN_COLUMNS = 40
SCREEN_ROWS =    25


CARRIAGE_RETURN = 13
CR = 13
LF = 10
NUL = 0


BLACK =         $00
WHITE =         $01
RED =           $02
CYAN =          $03
PURPLE =        $04   ; PLUM
GREEN =         $05
BLUE =          $06
YELLOW =        $07
ORANGE =        $08
BROWN =         $09   ; OCHRE
YELLOW_GREEN =  $0a
PINK =          $0b
BLUE_GREEN =    $0c   ; MINT
LIGHT_BLUE =    $0d   ; BLUEGREY
DARK_BLUE =     $0e   ; VOILET
LIGHT_GREEN =   $0f   ; VERY similar to GREEN


JOY1_SEL = %00000010
JOY2_SEL = %00000100

JOY_UP =    %00000001
JOY_DOWN =  %00000010
JOY_LEFT =  %00000100
JOY_RIGHT = %00001000
JOY1_FIRE = %01000000
JOY2_FIRE = %10000000


; Pushes A, X and Y (in that order) to the stack
;
.macro phaxy
  pha
  txa
  pha
  tya
  pha
.endmacro


; Pulls Y, X and A (in that order) from the stack
;
.macro plyxa
  pla
  tay
  pla
  tax
  pla
.endmacro


; Branch if the result is zero (alias for BEQ)
;
.macro bzr label
  beq label
.endmacro


; Branch if the result is non-zero (alias for BNE)
;
.macro bnz label
  bne label
.endmacro


; Branch if A is less than the operand (alias for BNE)
;
.macro blt label
  bcc label
.endmacro


; Branch if A is greater than or equal to the operand (alias for BNE)
;
.macro bge label
  bcs label
.endmacro


.macro init_stack
  ldx #$ff
  txs
.endmacro

