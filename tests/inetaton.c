#include <stdio.h>
#include <stdint.h>

#include "inetextend.h"

void display(int32_t inp, unsigned char error, char *str) {
    if (error == 1) {
        printf("IP : %d.%d.%d.%d\n", (unsigned char)(inp >> 24), (unsigned char)(inp >> 16) & 0xff, (unsigned char)(inp >> 8) & 0xff, (unsigned char)(inp & 0xff));
        printf("%d" ,inp[0]);
    }
    else
        printf("Invalid conversion for : %s\n", str);
}

int main() {
    uint32_t inp = 0;
    uint8_t error = 0;

    error = inet_aton("1.2.3.4", &inp);
    display(inp, error,"1.2.3.4");

    error = inet_aton("27.1.29.30", &inp);
    display(inp, error,"27.28.29.30");

    error = inet_aton("192.168.0.1", &inp);
    display(inp, error, "192.168.0.1");

    error = inet_aton("251.168.0.1", &inp);
    display(inp, error, "251.168.0.1");

    error = inet_aton("0.168.0.1", &inp);
    display(inp, error, "0.168.0.1");

    error = inet_aton("255.255.255.1", &inp);
    display(inp, error,"255.255.255.1");

    error = inet_aton("a.255.255.1", &inp);
    display(inp, error, "a.255.255.1");

    error = inet_aton(".255.255.1", &inp);
    display(inp, error,".255.255.1");

    error = inet_aton("1", &inp);
    display(inp, error,"1");

}
