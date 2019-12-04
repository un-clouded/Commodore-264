
; Version 2.11.0-1 warns of absent STARTUP and ZPSAVE segments, 2.16-2 of
; STARTUP and INIT, so define them to avoid warnings even though they're empty
.segment "STARTUP"
.segment "ZPSAVE"
.segment "INIT"

