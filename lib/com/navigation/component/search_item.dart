import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;

class UserItem extends StatefulWidget {
  final String userId;

  UserItem(this.userId);

  @override
  UserItemState createState() => UserItemState();
}

class UserItemState extends State<UserItem> {
  UserItemState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.blue,
                            child: Image.asset(
                              "assets/images/person.png",
                              width: 40.0,
                              height: 40.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                widget.userId,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: InputDecorator(
                    decoration: InputDecoration(icon: Icon(Icons.add)),
                  ),
                  onPressed: () {
                    var message = {
                      constants.type: constants.friend,
                      constants.subtype: constants.request,
                      constants.to: widget.userId,
                      constants.message: "${handler.userName}请求添加你为好友!",
                      constants.version: constants.currentVersion
                    };
                    handler.sendRequest(message);
                    Scaffold
                        .of(context)
                        .showSnackBar(SnackBar(content: Text("请求已发送")));
                  },
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
