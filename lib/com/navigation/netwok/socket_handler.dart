import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/com/navigation/models/contacts_list_model.dart';
import 'package:flutter_app/com/navigation/models/system_propel_model.dart';
import 'package:flutter_app/com/navigation/page/login.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;

///
/// 整个app向服务器发送请求和接收服务器回复的综合处理类,
/// 此类不涉及有关ui部分的操作,只负责产生数据,某个页面需要数据直接获取即可.
/// @socket   整个app socket
/// @contactsList 储存联系人列表
/// @leftMessage 储存离线消息
/// @systemPropel为系统推送消息
///

Socket socket;
List<Entry> contactsList = [];
List<Entry> leftMessage = [];
List<SystemPropelModel> systemPropel = [];

LoginState login;
String userName;
String password;

Future<Socket> initSocket() {
  if (socket != null) {
    socket.destroy();
    socket.close();
  }
  return Socket.connect(constants.server, constants.tcpPort);
}

void socketHandler() async {
  if (socket != null) {
    socket.done.catchError(() {}, test: (e) {
      print("网络异常........");
      return true;
    });
    socket.transform(utf8.decoder).listen((data) {
      print(data.toString());
      var result = json.decode(data);
      var type = result[constants.type];
      switch (type) {
        case constants.user:
          handlerUser(result);
          break;
        case constants.friend:
          handlerFriend(result);
          break;
      }
    });
  }
}

///
///
///
/// 向服务器发送数据
///
///
void sendRequest(Map message) {
  print(message.toString());
  socket.write(json.encode(message) + constants.end);
}

///
///
/// 处理type为user的所有socket事件
///
///

void handlerUser(dynamic data) async {
  var subtype = data[constants.subtype];
  if (subtype == "login") {
    var status = data["login"];
    if (status) {
      var friends = data["friends"];
      if (friends.length > 0) {
        List<Entry> list = [];
        for (var friend in friends) list.add(Entry(friend["id"]));
        contactsList.add(Entry("我的好友", list));
      }
      login.toUserCenter();
    } else {
      socket?.close();
      login.showAlertMessage("登录失败,请检查用户名/密码!");
    }
  }
}

///
///
///处理type为friend的所有socket事件
///
void handlerFriend(dynamic data) {
  var subtype = data[constants.subtype];
  if (subtype == constants.request) {
    systemPropel.add(SystemPropelModel(data[constants.message],
        data[constants.subtype], data[constants.from]));
  }
  if (subtype == constants.response) {
    systemPropel.add(SystemPropelModel(
        data[constants.accept]
            ? "${data[constants.from]}接受你的好友请求"
            : "${data[constants.from]}拒绝你的好友请求",
        constants.response,
        data["from"]));
  }
}
