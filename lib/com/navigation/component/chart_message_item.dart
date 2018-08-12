import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/beautiful/CustomerOval.dart';

///
///
/// 聊天消息列表item
///

class ChartMessageItem extends StatefulWidget {
  final String _message;

  ChartMessageItem(this._message);

  @override
  ChartMessageItemState createState() => ChartMessageItemState(_message);
}

class ChartMessageItemState extends State<ChartMessageItem> {
  final String _message;

  ChartMessageItemState(this._message);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipOval(
          child: IconButton(
            icon: Image.asset(
              "assets/images/sender.png",
              width: 100.0,
              height: 100.0,
            ),
            onPressed: () {},
          ),
          clipper: CustomerOval(30.0, 30.0, 70.0),
        ),
        Container(
          margin: EdgeInsets.only(top: 15.0),
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(250, 250, 210, 1.0),
              borderRadius: BorderRadius.all(Radius.circular(5.00),)
          ),
          width: 150.0,
          child: Text(_message,style: TextStyle(fontSize: 20.0),),
        ),
      ],
    );
  }
}
