import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/com/navigation/models/contacts_list_model.dart';
import 'package:flutter_app/com/navigation/page/login.dart';
import 'package:flutter_app/com/navigation/page/user.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;

Socket socket;
List<Entry> contactsList = [];
List<Entry> leftMessage  = [];
UserCenterState userCenterState;
LoginState     login;
String         userName;
String         password;

Future<Socket> initSocket(){
    return Socket.connect(constants.server, constants.tcpPort);
}
void socketHandler() async{
  if(socket!=null){
    socket.transform(utf8.decoder).listen((data){
      var result = json.decode(data);
      var type   = result[constants.type];
      switch(type){
        case constants.user: handlerUser(result); break;
      }
    });
  }
}

void sendRequest(String message){
  try {
    socket.write(message);
    print(message);
  }catch(e){
    print("请求异常:$e");
  }
}

///
///
/// 处理type为user的所有socket事件
///
///

void handlerUser(dynamic data)async{
  print(data);
  var subtype = data[constants.subtype];
  if(subtype=="login"){
    var status = data["login"];
    if(status){
      var friends = data["friends"];
      if(friends.length>0){
        List<Entry> list=[];
        for(var friend in friends) list.add(Entry(friend["id"]));
        contactsList.add(Entry("我的好友",list));
      }
      login.toUserCenter();
    }else{
      socket?.close();
      login.showAlertMessage("登录失败,请检查用户名/密码!");
    }
  }
}