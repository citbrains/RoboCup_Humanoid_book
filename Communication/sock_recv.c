#include <stdio.h>
#include <arpa/inet.h>
#include <unistd.h>

int main(){
    int sock;
    struct sockaddr_in addr;
    char buf[2048];
    sock = socket(AF_INET, SOCK_DGRAM, 0);
    addr.sin_family = AF_INET;
    addr.sin_port = htons(8000);
    addr.sin_addr.s_addr = INADDR_ANY;
    bind(sock, (struct sockaddr *)&addr, sizeof(addr));    // バインドする
    recv(sock, buf, sizeof(buf), 0);                       // 受信する
    printf("%s\n", buf);
    close(sock);
    return 0;
}

