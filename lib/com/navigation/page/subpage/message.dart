import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/message_list_item.dart';
import 'package:flutter_app/com/navigation/models/message_list_item_model.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart' as handler;
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;

///
///
/// 消息界面
///
///
class Message extends StatefulWidget {
  @override
  MessageState createState() => MessageState();
}

class MessageState extends State<Message> {

  List<MessageListItem> messageListItem = [];

  @override
  void initState() {
    super.initState();
    _offlineMessage();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: RefreshIndicator(
          child: ListView(
            children: messageListItem,
          ),
          onRefresh: () {
            return TickerFuture.complete();
          }),
    );
  }
  ///
  /// 请求离线消息
  /// todo 将其加入到handler的Map中去
  ///
  ///
  void _offlineMessage(){
    Map requestMes = {
      constants.type:constants.user,
      constants.subtype:constants.offline,
      constants.id:handler.userName,
      constants.password:handler.password,
      constants.version:constants.currentVersion
    };
    HttpClient client = HttpClient();
    client.put(constants.server, constants.httpPort,"/${constants.user}/${constants.offline}")
        .then((request){
      request.write(json.encode(requestMes));
      return request.close();
    }).then((response){
      response.transform(utf8.decoder).listen((data){
        var result = json.decode(data);
        print(result.toString());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  ///
  ///
  /// 初始化数据
  ///
  ///
  void _initData(){
    Map<String,List<String>> map = handler.messageList;
    map.forEach((id,messages){
      messageListItem.add(MessageListItem(MessageListItemModel(messags: messages,name: id)));
    });
  }

}
