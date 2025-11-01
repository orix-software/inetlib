---

## inet_aton

***Description***

Convert ip str to int 32 (net work notation : big endian), returns 255 255 255 255 if error

***Input***

* Accumulator : Low addr of string
* X Register : high addr


***Modify***

* RESB
* RES
* TR0
* TR1; TR0 indexed
* TR2; TR0 indexed
* TR3; TR0 indexed

***Returns***

* X Register : X = 1 error, is not an ip





 lda #<ip_str
 ldx #>ip_str
 jsr inet_aton
 rts
ip_str:
 .asciiz 192.168.1.1
```

