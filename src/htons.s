.include "telestrat.inc"

.export htons
.export _htons

.proc htons
    ;;@brief htons is not useful in assembly
    rts
.endproc

.proc _htons
    ;;@brief

    stx     RES
    tax

    lda     RES

    jmp     htons


.endproc

