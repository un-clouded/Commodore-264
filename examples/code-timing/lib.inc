
LO = 0
HI = 1


TIMER_B_LO =        $ff02
TIMER_B_HI =        $ff03
CONF_AND_HSP =      $ff07
GLYPH_PTR_AND_SCM = $ff13

; CONF_AND_HSP
FREEZE_MODE = 1 << 5

; GLYPH_PTR_AND_SCM
FSC = 1 << 1



CHROUT = $ffd2



.macro inhibit_interrupts
  sei
.endmacro


.macro permit_interrupts
  cli
.endmacro


.macro set_bit  address, bit_mask
  lda address
  ora # bit_mask
  sta address
.endmacro

.macro clear_bit  address, bit_mask
  lda address
  and # bit_mask ^ %11111111
  sta address
.endmacro


.macro force_single_clock_mode
  set_bit GLYPH_PTR_AND_SCM, FSC
.endmacro

.macro permit_double_clock_mode
  clear_bit GLYPH_PTR_AND_SCM, FSC
.endmacro


.macro enable_freeze_mode
  set_bit CONF_AND_HSP, FREEZE_MODE
.endmacro

.macro disable_freeze_mode
  clear_bit CONF_AND_HSP, FREEZE_MODE
.endmacro

