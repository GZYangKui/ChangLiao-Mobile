import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/com/navigation/page/login.dart';
import 'package:flutter_app/com/navigation/page/user.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;

Socket socket;

UserCenterState userCenterState;
LoginState     login;

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
    handlerUser("hello");
  }catch(e){
    print("请求异常:$e");
  }
}

void handlerUser(dynamic data)async{
  await Future<bool>((){
    while(true) if(userCenterState!=null) break;
  }).whenComplete((){
    userCenterState.acceptSocketData(data);
  });

}