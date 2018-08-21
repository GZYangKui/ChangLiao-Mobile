import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;

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
///  id.json/ friend*.json为个人信息/好友信息(无密码)
///
///  {
/// "id":"id",
/// "password":"*********",
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
///@dir app文件路径
///
String dir;

///
///
///
///初始化文件状态
///
void initFileState() async {
  ///获取app文件路径
  dir = (await getApplicationDocumentsDirectory()).path;
  Directory directory = Directory("$dir/${constants.carefree}");
  bool isExist = await directory.exists();
  if (!isExist) directory.createSync();
}

///
///
/// 创建用户目录
///
///
void createUserDir(String id, String password, List<dynamic> friends) async {
  Directory directory = Directory("$dir/${constants.carefree}/$id");
  bool isExist = await directory.exists();
  if (!isExist) {
    directory.createSync();
    File file = File("$dir/${constants.carefree}/$id/$id.json");
    if (!await file.exists()) {
      file.createSync();
      file.writeAsStringSync(json.encode({
        constants.id: id,
        constants.password: password,
        constants.phone: null,
        constants.mail: null,
        constants.website: null,
        constants.company: null,
        constants.address: null,
        constants.brief: "这家伙很懒什么都没留下!"
      }));
    }

    Directory friends =
        Directory("$dir/${constants.carefree}/$id/${constants.friends}");
    if (!await friends.exists()) {
      friends.createSync();
    }
  }
  updateFriends(friends, "$dir/${constants.carefree}/$id/${constants.friends}");
}

///
///
/// 更新/写入好友列表
///
///
void updateFriends(List<dynamic> friends, String path) async {
  Directory directory = Directory(path);
  Stream<FileSystemEntity> list = directory.list();
  if (await list.length == 0) {
    for (var friend in friends) {
      Directory friendDir = Directory("$path/${friend["id"]}");
      friendDir.createSync();
      File file = File("$path/${friend["id"]}/${friend["id"]}.json");
      file.createSync();
      file.writeAsStringSync(json.encode({
        constants.id: friend["id"],
        constants.phone: null,
        constants.mail: null,
        constants.website: null,
        constants.company: null,
        constants.address: null,
        constants.brief: "这家伙很懒什么都没留下!"
      }));
    }
  } else {
    ///TODO 添加缺省好友

  }
}

///
/// 根据id得到个人信息
///
///
Future<dynamic> loadPersonInfo(String id) async {
  String infoDir;
  if (id == handler.userName)
    infoDir = "$dir/${constants.carefree}/${handler.userName}/$id.json";
  else
    infoDir =
        "$dir/${constants.carefree}/${handler.userName}/${constants.friends}/$id/$id.json";
  File file = File(infoDir);
  var result = json.decode(file.readAsStringSync());
  return result;
}

///
///
/// 根据id更改个人信息
///
Future<File> savePersonInfo(String id, dynamic data) async {
  String infoDir;
  if (id == handler.userName)
    infoDir = "$dir/${constants.carefree}/${handler.userName}/$id.json";
  else
    infoDir =
        "$dir/${constants.carefree}/${handler.userName}/${constants.friends}/$id/$id.json";
  File file = File(infoDir);
  var result = file.writeAsString(json.encode(data));
  return result;
}
