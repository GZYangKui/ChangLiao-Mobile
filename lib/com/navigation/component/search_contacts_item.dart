import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;
import 'package:flutter_app/com/navigation/page/subpage/chart_dialog.dart';

class SearchContactsItem extends StatefulWidget {
  final String _name;

  SearchContactsItem(this._name);

  @override
  State<StatefulWidget> createState() => SearchContactsItemState();
}

class SearchContactsItemState extends State<SearchContactsItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.green,
                  child: Image.asset(
                    "assets/images/icon.png",
                    width: 45.0,
                    height: 45.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            widget._name,
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 0.0,
                        height: 2.0,
                      ),
                      Row(
                        children: <Widget>[Text("暂无个性签名")],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 3.0,
            ),
          ],
        ),
      ),
      onTapDown: (e) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ChartDialog(
                  messages: handler.getChatRecorder(widget._name),
                  name: widget._name,
                ),
          ),
        );
      },
    );
  }
}
