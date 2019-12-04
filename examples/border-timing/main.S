
.include "../lib.inc"


INTERRUPT_AT_LINE = 203   ; After the visible area has been rendered each frame


; --------------------------------------------------------------------------- 80

main:

  jsr setup_irq_handler

  clc
 @loop:
  bcc @loop


; --------------------------------------------------------------------------- 80

loop:

  ; Code for each frame goes here

  ldy #$10
 @outer:
  ldx #$80
 @inner:
  dex
  bpl @inner
  dey
  bpl @outer

  rts


; --------------------------------------------------------------------------- 80

setup_irq_handler:

  ; Disable interrupts so that the CPU doesn't try to service an interrupt when
  ; the vector is half-changed
  sei

  lda #<irq_handler
  sta IRQ_VECTOR
  lda #>irq_handler
  sta IRQ_VECTOR+1

  ; Interrupt on raster line match but nothing else
  lda #%00000010 | ((INTERRUPT_AT_LINE >> 8) & $01)
  sta INTERRUPT_CONTROL
  lda #<INTERRUPT_AT_LINE
  sta RASTER_LINE

  ; Re-enable maskable interrupts
  cli

  rts


; --------------------------------------------------------------------------- 80

irq_handler:

  ; The border goes white to indicate time consumed by code during a frame
  nop ; Two NOPs get to the beginning of the next raster line (including lda, sta)
  nop
  lda #$40 + ORANGE
  sta BORDER_COLOR

  jsr loop

  ; The border should go black to indicate the time during a frame that is
  ; available for more code
  lda #BLACK
  sta BORDER_COLOR

  ; The interrupt should be acknowledged otherwise it will recur immediately
  inc INTERRUPTS

  ; Restore the register values that were saved by the ROM-based IRQ handler
  plyxa

  rti

