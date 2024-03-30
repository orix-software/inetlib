.include "telestrat.inc"

.export inet_aton

.proc inet_aton
    ;;@brief Convert ip str to int 32, returns 255 255 255 255 if error
    ;;@inputA Low addr of string
    ;;@inputX high addr
    ;;@modifyMEM_RESB
    ;;@modifyMEM_RES
    ;;@modifyMEM_TR0
    ;;@modifyMEM_TR3
    ;;@returnsMEM_TR4 First byte
    ;;@returnsMEM_TR5 Second byte
    ;;@returnsMEM_TR6 Third byte
    ;;@returnsMEM_TR7 Last byte

    sta     RES
    stx     RES+1

    ldx     #$00
    stx     RESB ; Current digit
    stx     TR4
    stx     TR5
    stx     TR6
    stx     TR7

    ldy     #$00

@L1:
    lda     (RES),y
    beq     @out
    cmp     #'.'
    beq     @convert
    cmp     #'0'
    bcc     @error
    cmp     #':'
    bcs     @error

    sta     TR0,x
    inx
    cpx     #$04
    beq     @error
    iny
    bne     @L1

@out:
    lda     RESB
    cmp     #03
    bne     @error ; Missing digit
    nop     ; For reloc binary bug
    ; TR4,TR5,TR6,TR7 contains digit
    jsr     @compute

    lda     TR4
    beq     @error ; First_byte_is_zero


    ldx     #$00
    rts

@error:
    ldx     #$01
    rts

@convert:
    jsr     @compute
    ldx     #$00
    iny
    jmp     @L1

@compute:
    cpx     #01
    beq     @one_digit

    cpx     #02
    beq     @two_digit

    cpx     #03
    beq     @three_digit
    bne     @error

@one_digit:
    ldx     RESB
    lda     TR0

@one_digit_entry:
    sec
    sbc     #$30
    clc
    adc     TR4,x
    sta     TR4,x
    inc     RESB

    rts

@two_digit:
    ;jmp     @two_digit
    lda     TR0

@two_digit_entry:
    sec
    sbc     #$30
    sta     TR0
    jsr     @mult10
    ldx     RESB
    sta     TR4,x
    lda     TR1
    jmp     @one_digit_entry


@three_digit:
    lda     TR0
    cmp     #'2'
    beq     @is_200

    lda     #100

@three_digit_entry:
    ldx     RESB
    sta     TR4,x

    lda     TR1
    sec
    sbc     #$30
    sta     TR0
    jsr     @mult10
    ldx     RESB
    clc
    adc     TR4,x
    sta     TR4,x

    lda     TR2
    jmp     @one_digit_entry


@is_200:
    lda     #200
    bne     @three_digit_entry

@mult10:
    asl     ;*2
    sta     RESB+1
    adc     RESB+1
    adc     RESB+1
    adc     RESB+1
    adc     RESB+1
    rts

@under_10:
    sec
    sbc     #$30
    rts

.endproc
