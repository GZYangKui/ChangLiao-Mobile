import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/models/message_list_item_model.dart';
import 'package:flutter_app/com/navigation/page/sub_page/chart_dialog.dart';

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
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            model.name,
                            style: TextStyle(fontSize: 22.0),
                            overflow: TextOverflow.ellipsis,
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
                          width: 30.0,
                          height: 20.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromRGBO(142, 229, 238, 0.8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(7.0),
                            ),
                          ),
                          child: Text(model.messages.length.toString()),
                        ),
                      ],
                    ),
                  ],
                ),
                onTapDown: (event) {
                  Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => ChartDialog(
                                name: model.name,
                                messages: model.messages,
                              ),
                        ),
                      );
                },
              )),
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
