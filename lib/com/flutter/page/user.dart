import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_app/com/flutter/beautiful/CustomerOval.dart';
import 'package:flutter_app/com/flutter/component/personInfo.dart';
import 'package:flutter_app/com/flutter/component/search.dart';

class UserCenter extends StatefulWidget {
  @override
  UserCenterState createState() => UserCenterState();
}

class UserCenterState extends State<UserCenter> with SingleTickerProviderStateMixin {
  static final List<Tab> _tabs = [
    Tab(
      text: "消息",
    ),
    Tab(
      text: "联系人",
    ),
    Tab(
      text: "动态",
    )
  ];
   TabController _tabController;
  int _currentIndex = 0;
  List<String> _titles = [
    "消息","联系人","动态"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text(_titles[_currentIndex]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Search()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: _applicationDrawer(),
      ),
      body: TabBarView(
        children: _tabs,
        controller: _tabController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message), title: Text("消息")),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_calendar), title: Text("联系人")),
          BottomNavigationBarItem(
              icon: Icon(Icons.streetview), title: Text("动态")),
        ],
        onTap: (index) {
          this.setState(() {
            _currentIndex = index;
          });
          _tabController.animateTo(index);
        },
        currentIndex: _currentIndex,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController= TabController(initialIndex: 0, length: _tabs.length, vsync:this);
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
                        color: Color.fromRGBO(200, 245, 150, 0.8),
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
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PersonInfo()));
                                },
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.settings),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "设置",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.info),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "关于",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.share),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "分享",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.exit_to_app),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "注销",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}