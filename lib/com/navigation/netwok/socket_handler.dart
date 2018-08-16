import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/models/contacts_list_model.dart';
import 'package:flutter_app/com/navigation/models/system_propel_model.dart';
import 'package:flutter_app/com/navigation/page/login.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:http/http.dart';

///
/// 整个app向服务器发送请求和接收服务器回复的综合处理类,
/// 此类强烈不建议与ui部分发生直接交互,只负责产生数据,某个页面需要数据直接获取即可.
/// @socket   整个app socket
/// @contactsList 储存联系人列表
/// @systemPropel为系统推送消息
/// @timer 定时器,定时向服务器发送数据以确保,连接正常可用
/// @ messageList 消息列表 key代表好友名称 value代表和该好友聊天的所有消息
///
///
///

Socket socket;
List<Entry> contactsList = [];
List<SystemPropelModel> systemPropel = [];
Map<String, List<String>> messageList = {};

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
  return Socket.connect(constants.domain, constants.tcpPort);
}

///
///
/// 处理服务器返回来的数据id
///
///
void socketHandler() async {
  if (socket != null) {
    socket.done.catchError(() {}, test: (e) {
      if (timer != null && timer.isActive) {
        timer.cancel();
      }

      ///
      /// todo 此处有点不友好不建议这样做
      ///
      if (currentState != null) {
        Login login = Login();
        dispose();
        Navigator.push(currentState.context,
            MaterialPageRoute(builder: (BuildContext context) => login));
      }
      return true;
    });
    socket.transform(utf8.decoder).listen((data) {
      var result = json.decode(data);
      var type = result[constants.type];
      switch (type) {
        case constants.user:
          handlerUser(result);
          break;
        case constants.friend:
          handlerFriend(result);
          break;
        case constants.message:
          handlerMessage(result);
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
void sendRequest(Map message) async {
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
      _offlineMessage();
    } else {
      dispose();
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
    if (data[constants.accept]) {
      systemPropel.add(SystemPropelModel("${data[constants.from]}同意添加你为好友!",
          constants.response, data["from"]));
      handlerContacts(data[constants.from]);
    } else {
      systemPropel.add(SystemPropelModel("${data[constants.from]}拒绝添加你为好友!",
          constants.response, data["from"]));
    }
  }
}

///
///
/// 心跳机制定时向服务器发送空包检验socket是否可用
///
///

void heartBeat() {
  timer = Timer.periodic(Duration(seconds: 10), (event) {
    socket.write("");
  });
}

///
///
/// 处理所有type为message的服务器返回数据
/// 目前只有subtype为text的数据,在将来可能添加image voice等
///
///
void handlerMessage(dynamic data) {
  var subtype = data["subtype"];
  var id = data[constants.from];
  var body = data[constants.body];
  if (subtype == constants.text) {
    handlerMessageList(id, body);
  }
}

///
/// 如果存在该用户信息连天记录,更新记录
/// 如果不存存在添加记录
///
///
void handlerMessageList(String id, String message) async {
  if (messageList.containsKey(id)) {
    messageList.update(id, (old) {
      old.add(message);
      return old;
    });
  } else {
    List<String> list = List();
    list.add(message);
    messageList.putIfAbsent(id, () => list);
  }
}

///
/// 如果好友列表中已经存在该用户,将不做任何处理,如果不存在将其加入到好友列表中去
/// 目前服务端对好友默认是我的好友目录下,暂不支持分组,分组功能将会留在以后实现
/// @ isExist 判断是否已经时好友关系
///
void handlerContacts(String id) {
  var isExist = false;
  if (contactsList.length > 0) {
    var list = contactsList[0].list;
    for (Entry e in list) if (e.title == id) isExist = true;
    if (!isExist) {
      for (Entry entry in contactsList) {
        if (entry.title == "我的好友") entry.list.add(Entry(id));
      }
    }
  } else {
    List<Entry> list = List();
    list.add(Entry(id));
    contactsList.add(Entry("我的好友", list));
  }
}

///
/// 通过用户id查找相应的聊天记录
///
///
List<String> getChatRecorder(String id) {
  List<String> record = [];
  if (messageList.containsKey(id)) {
    messageList.forEach((key, list) {
      if (key == id) {
        record = list;
        return;
      }
    });
  }else{
    messageList.putIfAbsent(id, ()=>record);
  }
  return record;
}

///
/// 请求获取离线消息
/// todo 将其加入到handler的Map中去
///
///
void _offlineMessage() {
  Map requestMes = {
    constants.type: constants.user,
    constants.subtype: constants.offline,
    constants.id: userName,
    constants.password: password,
    constants.version: constants.currentVersion
  };
  put("${constants.http}${constants.domain}/${constants.user}/${constants.offline}"
      ,body:"${json.encode(requestMes)}${constants.end}")
      .then((response){
        if(response.statusCode == 200){
          var result = json.decode(utf8.decode(response.bodyBytes));
          print("offline:$result");
        }
  });
}

///
///
///退出登录时释放掉该用户所有信息
///
///

void dispose() {
  socket?.destroy();
  socket.close();
  contactsList?.clear();
  systemPropel?.clear();
  messageList?.clear();
}
