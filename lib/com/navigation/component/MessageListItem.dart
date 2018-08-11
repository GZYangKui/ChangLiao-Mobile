import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/model/message_list_item_model.dart';

///
/// 消息列表itme
///
class MessageListItem extends StatefulWidget {
  final MessageListItemModel model;

  MessageListItem(this.model);

  @override
  MessageListItemState createState() => MessageListItemState(model);
}

class MessageListItemState extends State<MessageListItem> {
  final MessageListItemModel model;

  MessageListItemState(this.model);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          "assets/images/message.png",
          width: 50.0,
          height: 50.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        model.name,
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Text(_calTime()),
                  ],
                ),
                SizedBox(
                  height: 3.00,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        model.messages[model.messages.length - 1],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      child: Text(model.messages.length.toString()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// 计算当前时间
  ///
  String _calTime() {
    final DateTime dateTime = DateTime.now();
    final int hour = dateTime.hour;
    final int minute = dateTime.minute;
    if (minute.toInt() < 10)
      return "$hour:0$minute";
    else
      return "$hour:$minute";
  }
}
