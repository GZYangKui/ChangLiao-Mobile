import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/com/navigation/beautiful/CustomerOval.dart';
import 'package:flutter_app/com/navigation/component/message_list_item.dart';
import 'package:flutter_app/com/navigation/component/system_propel.dart';
import 'package:flutter_app/com/navigation/models/message_list_item_model.dart';
import 'package:flutter_app/com/navigation/page/subpage/about_program.dart';
import 'package:flutter_app/com/navigation/page/subpage/contacts.dart';
import 'package:flutter_app/com/navigation/page/subpage/dynamic_state.dart';
import 'package:flutter_app/com/navigation/page/subpage/message.dart';
import 'package:flutter_app/com/navigation/page/subpage/personInfo.dart';
import 'package:flutter_app/com/navigation/page/subpage/search.dart';
import 'package:flutter_app/com/navigation/page/login.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart' as handler;
import 'package:flutter_app/com/navigation/page/subpage/system_inform.dart';

class UserCenter extends StatefulWidget {
  @override
  UserCenterState createState() => UserCenterState();
}

class UserCenterState extends State<UserCenter>
    with SingleTickerProviderStateMixin {

  static final List<StatefulWidget> _tabs = [
    Message(),
    Contacts(),
    DynamicState()
  ];
  TabController _tabController;
  int _currentIndex = 0;
  final List<String> _titles = ["消息", "联系人", "动态"];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>SystemInform())),
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
            BottomNavigationBarItem(
                icon: Icon(Icons.message), title: Text("消息")),
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
      ),
      onWillPop: () {
        SystemNavigator.pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    handler.currentState = this;
    _tabController = TabController(initialIndex: 0, length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      this.setState(() {
        this._currentIndex = _tabController.index;
      });
    });
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
                        color: Colors.lightBlue,
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
                                clipper: CustomerOval(50.0, 50.0, 40.0),
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
                                  handler.userName,
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
                onTapDown: (e) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => About()));
                },
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
                onTapDown: (e) {
                  _logout();
                },
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    if(handler.socket!=null){
      handler.socket.destroy();
      handler.socket.close();
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
            title: Text("消息"),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text("你确定要退出当前账号?")],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("取消"),
                    onPressed: () =>Navigator.pop(context),
                  ),
                  SizedBox(
                    width: 10.0,
                    height: 0.0,
                  ),
                  RaisedButton(
                    child: Text("确定"),
                    onPressed: () {
                      handler.dispose();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Login()));
                    },
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
