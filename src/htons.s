.include "telestrat.inc"

.export htons
.export _htons

.proc htons
    ;;@brief htons is not useful in assembly
    ;;@inputA low port
    ;;@inputX High port
    ;;@returnsA low port
    ;;@returnsX high port
    rts
.endproc

.proc _htons
    ;;@brief
    ;;@proto unsigned int htons(unsigned int hostshort);
    rts
.endproc

