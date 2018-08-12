import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/message_list_item.dart';
import 'package:flutter_app/com/navigation/models/message_list_item_model.dart';

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
  List<MessageListItem> messageListItem = [
    MessageListItem(MessageListItemModel(messags: ["hello"], name: "Tom")),
    MessageListItem(MessageListItemModel(messags: ["hello"], name: "Jack"))
  ];

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

  void _dealDragUpdate(){

  }
}
