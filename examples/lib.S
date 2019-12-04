
.include "lib.inc"

.export u16_add
.export cursor_home
.export outc
.export outnl
.export hex4
.export outhex4
.export outhex8
.export outbin8

; Zero Page usage
cursor_line_ptr = $d8     ; pointer to first character on cursor line in character matrix
cursor_line_ptr_lo = $d8
cursor_line_ptr_hi = $d9
cursor_x = $da
save_x = $e9    ; A place to remember X without trashing A.  Do not use if
                ; invoked or invoking methods use it and do not use within
                ; interrupts
save_y = $fa



; Adds `A` to the 16-bit value at $00+X
;
u16_add:
  clc
  adc $00,x
  bcc @no_overflow
  inc $01,x
 @no_overflow:
  sta $00,x
  rts



; @destroys A
;
cursor_home:
  lda #$0c
  sta cursor_line_ptr_hi
  lda #$00
  sta cursor_line_ptr_lo
  sta cursor_x
  rts



; @destroys   A  save_x  save_y
;
outc:
  cmp #CARRIAGE_RETURN
  beq new_line
  sty save_y
  ldy cursor_x
  sta (cursor_line_ptr),y
  iny
  cpy #SCREEN_COLUMNS
  bcc @same_line
  ldy #0
  lda cursor_line_ptr_lo
  adc #(SCREEN_COLUMNS - 1) ; `- 1` because know that Carry is Set from above
  bcc @no_overflow
  inc cursor_line_ptr_hi
 @no_overflow:
  sta cursor_line_ptr_lo
 @same_line:
  sty cursor_x
  ldy save_y
  rts

new_line:
  stx save_x
  lda #SCREEN_COLUMNS
  ldx #<cursor_line_ptr_lo
  jsr u16_add
  lda #0
  sta cursor_x
  ldx save_x
  rts



; Outputs a newline character
;
outnl:
  lda #CARRIAGE_RETURN
  jmp outc



; Provides the hex representation in ASCII of a 4-bit value
;
; @param  A   The value.  Results are undefined if A > 15
; @return   $30:$39 if A was $00:$09 or $41:$46 (ASCII A:F) if A was $0a:$0f
;
;
hex4:
;  cmp #$0a                      ; If `A` < 10 then C is 0, if >= 10 then C is 1
;  bcc @lt10                     ; Branch if A < 10
;  adc # (-10 + $41 - $30 - 1)   ; $0a should become $41 (i.e. subtract 10 then
;                                ; add $41 though going to add another $30 in
;                                ; the fall-through and Carry is already Set too)
; @lt10:
;  adc #$30                      ; $30 is ASCII '0'

  sed
  cmp #10
  adc #'0'
  cld

  rts



; Outputs a single hex digit.
;
; @param      A     The value to print
;
outhex4:
  and #$0f
  jsr hex4
  jmp outc



; Outputs a byte in hex
;
; @param      A   The byte to print
; @destroys   A Y C
;
outhex8:
  tay         ; Save the lower 4 bits while A is damaged
  lsr
  lsr
  lsr
  lsr
  jsr outhex4
  tya         ; Recall the lower 4 bits
  jmp outhex4



; Output an 8-bit binary representation of the given value
;
outbin8:
  ldy #$08
 @next:
  asl       ; Carry is now what was MSB
  pha       ; Save `A`
  lda #$30  ; ASCII '0'
  adc #$00  ; Will become ASCII '1' if Carry was set
  jsr outc
  pla
  dey
  bne @next
  rts



; ------------------------------------------------------------------------------

