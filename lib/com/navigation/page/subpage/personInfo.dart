import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart' as handler;

class PersonInfo extends StatefulWidget {
  @override
  PersonInfoState createState() => PersonInfoState();
}

class PersonInfoState extends State<PersonInfo> {
  @override
  void initState() {
    super.initState();
    handler.currentState = this;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人信息"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.perm_identity),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "用户名"),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.phone),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "手机"),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.email),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "邮箱"),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.link),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "个人主页"
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.work),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "公司"
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.location_on),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "所在地"
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.info),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "个人简介"
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveMessage();
        },
        child: Icon(Icons.send),
      ),
    );
  }
  void _saveMessage(){



  }
}
