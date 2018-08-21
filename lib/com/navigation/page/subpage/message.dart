import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/message_list_item.dart';
import 'package:flutter_app/com/navigation/models/message_list_item_model.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;
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
  List<MessageListItemModel> _list = [];
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (e) {
      this.setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _initData();
    return Tab(
      child: RefreshIndicator(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                MessageListItem(_list[index]),
            itemCount: _list.length,
          ),
          onRefresh: () {
            return TickerFuture.complete();
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null && _timer.isActive) _timer.cancel();
    if (_list != null) _list.clear();
  }

  ///
  ///
  /// 初始化数据
  ///
  ///
  void _initData() {
    if (_list.length > 0) _list.clear();
    handler.messageList.forEach((key, value) {
      _list.add(MessageListItemModel(messags: value, name: key));
    });
  }
}
