.include "telestrat.inc"

.export inet_addr
.export _inet_addr


.proc _inet_addr
    ;;@proto inet_addr(const char *cp);

.endproc

.proc inet_addr
    ;;@brief Convert ip str to int 32, returns 255 255 255 255 if error
    ;;@inputA Low addr of string
    ;;@inputX high addr
    ;;@returnsA First byte
    ;;@returnsX Second byte
    ;;@returnsY Third byte
    sta     RES
    stx     RES+1


    ldx     #$00
    stx     RESB ; Current digit

    ldy     #$00

@L1:
    lda     (RES),y
    beq     @out
    cmp     #'.'
    beq     @convert
    cmp     #'0'
    bcc     @error
    cmp     #'9'
    bcs     @error

    sta     TR0,x
    inx
    cpx     #$03
    beq     @error


@out:

    rts

@convert:
    cpx     #03
    bne     @no_three_digit
    lda     TR0
    cmp     #'2'
    bne     @is_not_200

    stx     RESB+1

    lda     #200
    ldx     RESB
    sta     TR3,x

    ldx     RESB+1
    jmp     @no_three_digit

@is_not_200:

    stx     RESB+1

    lda     #100
    ldx     RESB
    sta     TR3,x

    ldx     RESB+1

@no_three_digit:
    cpx     #02
    bne     @no_three_digit


    rts

@error:
    lda     #$FF
    tax
    tay
    sta     RES
    rts

.endproc
