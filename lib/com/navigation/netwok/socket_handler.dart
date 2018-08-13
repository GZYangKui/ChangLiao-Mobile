import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
/// @timer 定时器,定时向服务器发送数据以确保,连接正常可用
///

Socket socket;
List<Entry> contactsList = [];
List<Entry> leftMessage = [];
List<SystemPropelModel> systemPropel = [];

Timer timer;
LoginState loginState;
String userName;
String password;
State currentState;

///
///
/// 初始化连接
///

Future<Socket> initSocket() {
  if (socket != null) {
    socket.destroy();
    socket.close();
  }
  return Socket.connect(constants.server, constants.tcpPort);
}
///
///
/// 处理服务器返回来的数据
///
///
void socketHandler() async {
  if (socket != null) {
    socket.done.catchError(() {}, test: (e) {
      if(timer!=null&&timer.isActive){
        timer.cancel();
      }
      ///
      /// todo 此处有点不友好不建议这样做
      ///
      if(currentState!=null){
        Login login = Login();
        dispose();
        Navigator.push(currentState.context, MaterialPageRoute(builder: (BuildContext context)=>login));
      }
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
      loginState.toUserCenter();
    } else {
      socket?.close();
      loginState.showAlertMessage("登录失败,请检查用户名/密码!");
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
///
///
/// 心跳机制定时向服务器发送空包检验socket是否可用
///
///

void heartBeat(){
  timer = Timer.periodic(Duration(seconds: 10),(event){
    socket.write("");
  });

}


///
///
///退出登录时释放掉该用户所有信息
///
///

void dispose(){
  socket?.destroy();
  socket.close();
  contactsList?.clear();
  leftMessage?.clear();
  systemPropel?.clear();
}
