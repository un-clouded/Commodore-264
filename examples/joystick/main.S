
.include "lib.inc"


.import cursor_home
.import outnl
.import outbin8



main:
  jsr cursor_home

  ldy #JOY1_SEL
  jsr scan_joystick
  jsr outbin8nl

  ldy #JOY2_SEL
  jsr scan_joystick
  jsr outbin8nl

  jmp main



; Outputs the binary representation of the value in A followed by a newline
;
outbin8nl:
  jsr outbin8
  jmp outnl



scan_joystick:
  ; None of the keyboard columns should be selected
  lda #$ff
  sta KEYBOARD_COLUMN
  tya
  sta TED_INPUT
  lda TED_INPUT
  rts

