.include "telestrat.inc"


.export _inet_aton
.import inet_aton

.import popax
.importzp ptr1

.proc _inet_aton
    ;;@proto long inet_aton(const char *cp, unsigned long *inp);
    ;;@brief returns in BIG ENDIAN

    sta     ptr1        ; Ptr to store int
    stx     ptr1+1      ; ptr to store int

    jsr     popax

    ; A & X contains str
    jsr     inet_aton

    cpx     #$01
    beq     @return_error

    lda     TR4
    ldy     #$00
    sta     (ptr1),y
    iny
    lda     TR5
    sta     (ptr1),y
    iny
    lda     TR6
    sta     (ptr1),y
    iny
    lda     TR7
    sta     (ptr1),y

    lda     #$01

    rts

@return_error:
    lda     #$FF

    rts
.endproc
