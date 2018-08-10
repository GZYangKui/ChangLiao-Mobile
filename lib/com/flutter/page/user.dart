import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/com/flutter/beautiful/CustomerOval.dart';

class UserCenter extends StatefulWidget {
  @override
  UserCenterState createState() => UserCenterState();
}

class UserCenterState extends State<UserCenter> {
  String _title = "消息";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text(_title),
      ),
      drawer: Drawer(
        child: _applicationDrawer(),
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

  Widget _applicationDrawer() {
    return Builder(
      builder: (BuildContext context) => ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(205, 205, 193, 0.8),
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                clipper: CustomerOval(),
                                child: Image.asset(
                                  "assets/images/head.png",
                                  width: 100.0,
                                  height: 100.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                                child: Text(
                                  "无畏勇者",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
