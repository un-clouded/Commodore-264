
TED_INPUT = $ff08
KEYBOARD_COLUMN = $fd30


CHROUT = $ffd2


IRQ_VECTOR = $0314


SCREEN_COLUMNS = 40


CARRIAGE_RETURN = 13


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

