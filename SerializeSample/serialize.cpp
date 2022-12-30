#include "sample.pb.h" // protoファイルから生成したC++コード
#include <iostream>
#include <string>

int main(int argc, const char **argv)
{
    RobotPosition pos;   //インスタンスを宣言
    pos.set_x(7.65876);  //xに値をセット
    pos.set_y(3.15283);  //yに値をセット
    std::cout << "---Data in a pos---" << std::endl;
    std::cout << "x::" << pos.x() << " y::" << pos.y() << std::endl; //pos内のx、yにアクセス

    RobotData robot1;          //インスタンスを宣言
    robot1.set_name("Mika J"); //nameに値をセット
    robot1.set_robot_id(346);  //robot_idに値をセット
    RobotPosition* ptr = robot1.mutable_position(); //robotが持つpositionフィールドのポインタを取得
    *ptr = pos;  //上で取得したポインタを使ってposを代入
    std::cout << "\n---Data in a robot1---" << std::endl;
    std::cout << robot1.DebugString(); //デバッグ用文字列の取得

    std::string serialized_data = robot1.SerializeAsString(); //バイナリにシリアライズ
    std::cout << "\n---serialized data---" << std::endl;
    std::cout << serialized_data << std::endl; //シリアライズしたデータを表示

    RobotData another_robot; //RobotData型のインスタンスをもう一つ宣言
    std::cout << "\n---another robot data---" << std::endl;
    std::cout << another_robot.DebugString(); //今構築したanother_robotの中身を表示

    another_robot.ParseFromString(serialized_data); //robot1をシリアライズしたバイナリをデシリアライズして代入
    std::cout << "\n---another robot data from robot1---" << std::endl;
    std::cout << another_robot.DebugString(); //デシリアライズしたデータの表示
    return 0;
}
