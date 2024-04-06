# Assembly

## inet_aton

***Description***

Convert ip str to int 32, returns 255 255 255 255 if error

***Input***

* Accumulator : Low addr of string
* X Register : high addr

***Modify***

* RESB
* RES
* TR0

***Returns***

* X Register : X = 1 error, is not an ip

* TR4 : First byte

* TR5 : Second byte

* TR6 : Third byte

* TR7 : Last byte


***Example***

```ca65
 lda #<ip_str
 ldx #>ip_str
 jsr inet_aton
 rts
ip_str:
 .asciiz 192.168.1.1
```



