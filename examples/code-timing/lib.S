
.include "lib.inc"


.export phex16



hex4:
  sed
  cmp #10
  adc #'0'
  cld
  rts



; Prints an 4-bit value in hex
;
; @param  A   The value.  Must be in the range 0 to 15
;
phex4:
  jsr hex4
  jmp CHROUT



; Prints an 8-bit value in hex
;
; @param  A   The value
;
phex8:
  pha         ; Save the lower 4 bits while A is damaged
  lsr
  lsr
  lsr
  lsr
  jsr phex4
  pla         ; Recall the lower 4 bits
  and #$0f
  jmp phex4



; Prints a 16-bit value in hex
;
; @param  A   LO byte
; @param  Y   HI byte
;
phex16:
  pha
  tya
  jsr phex8
  pla
  jmp phex8

