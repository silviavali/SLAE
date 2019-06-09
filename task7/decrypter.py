import codecs

def decrypt(encrypted, key):
	print ("[+] -------- Decryption --------")
	decrypted = ""
	msg = codecs.decode(encrypted, 'hex')

	for i in range(len(msg)):
		c =  msg[i] ^ key[i]
		d = "{:02x}".format(c)
		decrypted += d

	print ("[+] Decrypted string (XX): \n"+decrypted)
	print("[+] Decrypted string (\\xXX):\n" + r"\x" + r"\x".join(decrypted[n : n+2] for n in range(0, len(decrypted), 2)))

encrypted = "c9976b84aa9c553e80bd01ab6395d9d236fafcd1da1376e2ecb69120f7d5d15d1f11f3b81531e4b1ebe176"
key = "81a6b9cc11b37a5ce9d32ed80bdd18393eb275088b5bff05befe12ccff9d58613b597a5e5d002401d0ee73"

decrypt(encrypted, codecs.decode(key, 'hex'))
