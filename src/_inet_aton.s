.include "telestrat.inc"


.export _inet_aton
.import inet_aton

.import popax
.importzp ptr1

.proc _inet_aton
    ;;@proto inet_aton(const char *cp, unsigned long *inp);

    sta     ptr1        ; Ptr to store inp
    stx     ptr1+1      ; ptr to store inp

    jsr     popax
    sta     RES
    stx     RES+1
    jsr     inet_aton

    sty     RESB
    ldy     #$00
    sta     (ptr1),y
    iny
    txa
    sta     (ptr1),y
    iny
    lda     RESB
    sta     (ptr1),y
    iny
    lda     RES
    sta     (ptr1),y


    rts
.endproc
