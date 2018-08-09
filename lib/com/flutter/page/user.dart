import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserCenter extends StatefulWidget {
  @override
  UserCenterState createState() => UserCenterState();
}

class UserCenterState extends State<UserCenter> {
  String _title ="消息";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text(_title),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Text("hello"),
          ],
        ),
      ),
      body: ListView(),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.message), title: Text("消息")),
        BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_calendar), title: Text("联系人")),
        BottomNavigationBarItem(
            icon: Icon(Icons.streetview), title: Text("动态")),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }
}
