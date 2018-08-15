import 'dart:async';
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
  Timer _timer;

  List<MessageListItem> messageListItem = [];

  @override
  void initState() {
    super.initState();
    _initData();
    _timer = Timer.periodic(Duration(seconds: 1), (e){
      this.setState((){});
    });
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
  @override
  void dispose() {
    super.dispose();
    if(_timer!=null&&_timer.isActive) _timer.cancel();
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
