import 'package:path_provider/path_provider.dart';

///
///
/// 读取和保存聊天记录的综合处理类
///
/// 每个用户文件家结构如下
/// -carefree
///  - user
///   -id.json    -----个人信息
///   - friends   -----好友文件夹
///    -friend1
///     - message.json  ----聊天信息
///     - friend1.json  ----好友信息
///    -friend2
///     - message.json  ----聊天信息
///     - friend2.json  ----好友信息
///    -friend3
///     - message.json  ----聊天信息
///     - friend3.json  ----好友信息
///    -friend4
///     - message.json  ----聊天信息
///     - friend4.json  ----好友信息
///    ..........
///
///  id.json/ friend*.json为个人信息/好友信息
///
///  {
/// "userName":"id",
/// "phone":"10086",
/// "mail":"10086@qq.com",
/// "website":"http://navigation.cn",
/// "company":"广州白木城信息科技有限公司",
/// "address":"广州",
/// "brief":"个人简介/个性签名"
/// }
///
///
///
/// message.json为与好友聊天信息
/// {
/// "friend*":"hello",
/// "id":"你好"
/// }
///
///


///
/// 根据好友id写入聊天记录
///
void writerChatRecord(String id) async{
  print("吃鸡");
  String dir = (await getApplicationDocumentsDirectory()).path;
  print(">>>>>>>>>>>>>>>>>>>>>");
  print(dir);
}