
.include "lib.inc"

.import phex16



.data

timer_after_test: .word $ffff
cycles_for_test: .word $ffff

.code



main:

  ; Set the address of the subroutine under test
  lda #<bench_this
  sta subroutine_address+0
  lda #>bench_this
  sta subroutine_address+1

  ; Interrupts should be inhibited for the duration of the test
  inhibit_interrupts

  ; Set "freeze" mode to prevent TED from stunning the CPU for display accesses
  ; and forcing single-clock mode
  enable_freeze_mode
  force_single_clock_mode

  ; Set the timer value prior to the test
  lda #$ff
  sta TIMER_B_LO
  sta TIMER_B_HI

  ; Invoke the subroutine under test
      subroutine_address = *+1
  jsr $ffff

  ; Read the timer value after return from the subroutine
  lda TIMER_B_LO
  ldy TIMER_B_HI  ; TIMER_B_HI might have been decremented since TIMER_B_LO was read
  cmp TIMER_B_LO  ; If TIMER_B_LO has underflowed since it was read two
                  ; instructions back then A < TIMER_B_LO and Carry will be Clear
  bcs no_underflow
    iny
no_underflow:
  sta timer_after_test+LO
  sty timer_after_test+HI

  permit_double_clock_mode
  disable_freeze_mode

  ; Interrupts should be permitted once again
  permit_interrupts

  ; The timer began with a value of $ffff and had a value of timer_after_test
  ; soon after the subroutine returned.  The difference (minus cycles for jsr,
  ; rts and lda) Should be the clock cycles spent in the subroutine.
  ; Subroutines that take longer than 65,000 cycles to complete (~ 1/13th sec)
  ; will be misrepresented as taking less time

  ; Work out the cycles take by the core of the routine under test
  sec
  lda # $ff - 6 * 2 - 3     ; The JSR and RTS should be 6 cycles each and the
                            ; LDA (abs) 4, so pre-subtract those here.  Only 3
                            ; is subtracted for the LDA, perhaps because the
                            ; value of TIMER_B_LO is latched before the fourth
                            ; cycle of the LDA instruction?
  sbc timer_after_test+LO
  sta cycles_for_test+LO
  lda #$ff
  sbc timer_after_test+HI
  sta cycles_for_test+HI

  ; Print the cycles
  lda #'$'
  jsr CHROUT
  lda cycles_for_test+LO
  ldy cycles_for_test+HI
  jsr phex16

  rts



bench_this:
  clc
  adc #$00
  rts

