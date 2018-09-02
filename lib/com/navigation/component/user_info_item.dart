import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;
import 'package:flutter_app/com/navigation/utils/file_handler.dart'
    as fileHandler;

Map<String, dynamic> userInfo = {};

class UserInfoItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoItem> {
  final List<String> _items = ["账号", "用户名", "个性签名", "个人邮箱", "手机号", "个人网址"];
  final List<InfoItem> panels = [];
  @override
  void initState() {
    super.initState();
    for (var item in _items)
      panels.add(InfoItem(title: item, itemValue: _checkData(item)));
    _loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        this.setState(() {
          panels[index].isExpanded = !isExpanded;
        });
      },
      children: panels.map((panel) {
        return panel.buildExpansionPanel;
      }).toList(),
    );
  }

  void _loadInfo() async {
    userInfo = await fileHandler.obtainUsers(userId: handler.userId);
    this.setState(() {
      userInfo = Map.from(userInfo);
    });
  }

  String _checkData(String title) {
    switch (title) {
      case "用户名":
        return userInfo["userName"] ?? handler.userId;
      case "个性签名":
        return userInfo["userName"] ?? "";
      case "个人邮箱":
        return userInfo["mail"] ?? "";
      case "手机号":
        return userInfo["phone"] ?? "";
      case "个人网址":
        return userInfo["website"] ?? "";
      default:
        return handler.userId;
    }
  }
}

class InfoItem {
  String title;
  bool isExpanded = false;
  String itemValue;

  InfoItem({@required this.title, @required this.itemValue});
  ExpansionPanel get buildExpansionPanel => ExpansionPanel(
        headerBuilder: (BuildContext context, bool expanded) => ListTile(
              leading: Text(title),
              title: Text(itemValue),
            ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "修改：",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: TextField(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    onSave();
                  },
                  child: Text(
                    "确定",
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ],
        ),
        isExpanded: title != "账号" ? isExpanded : false,
      );
  void onSave() async {}
}
