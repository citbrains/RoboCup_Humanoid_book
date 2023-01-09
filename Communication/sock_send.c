#include <arpa/inet.h>                 // ソケット間通信に必要なヘッダ
#include <unistd.h>

int main()
{
    int sock;                          // ソケットの番号
    struct sockaddr_in addr;           // ソケット間通信用のデータ構造体
    char msg[] = "Hello World\n";
    sock = socket(AF_INET, SOCK_DGRAM, 0); // ソケットの生成
    addr.sin_family = AF_INET;         // 通信プロトコルの指定
    addr.sin_port = htons(8000);	// ポートの指定
    addr.sin_addr.s_addr = inet_addr("127.0.0.1"); // IPアドレス
    sendto(sock, msg, sizeof(msg), 0, (struct sockaddr *)&addr, sizeof(addr));
                                       // データを送信
    close(sock);                       // ソケットを解放
    return 0;
}

