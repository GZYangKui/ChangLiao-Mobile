import 'dart:convert';

import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart' as handler;

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
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.account_box),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 5.00),
                      child: Text(
                        widget.userId,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ],
          ),
          flex: 8,
        ),
        Expanded(
          child: Align(
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
                _sendRequest(json.encode(message)+constants.end);
              },
            ),
          ),
          flex: 2,
        ),
      ],
    );
  }
  void _sendRequest(String message) async{
     handler.sendRequest(message);
  }
}
