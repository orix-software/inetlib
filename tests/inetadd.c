#include <stdio.h>
#include "inet.h"

int main() {
    long int ip;

    ip = inet_addr("127.0.0.1");
    ip = inet_addr("192.168.0.1");
    ip = inet_addr("0.168.0.1");
    ip = inet_addr("255.255.255.1");
    ip = inet_addr("a.255.255.1");
    ip = inet_addr(".255.255.1");
    ip = inet_addr("1");

}