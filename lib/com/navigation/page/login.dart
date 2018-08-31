import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/com/navigation/page/register.dart';
import 'package:flutter_app/com/navigation/page/user.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter_app/com/navigation/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  final List<String> _counts = [];
  String _userName = "";
  String _password = "";
  bool isSelect = true;
  bool isExpanded = true;
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child:
          isSelect && _counts.length > 0 ? _selectCounts() : _inputCountLogin(),
      onWillPop: () {
        SystemNavigator.pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    handler.loginState = this;
    application.counts.forEach((count) {
      count.forEach((key, value) {
        if (key == "userName") _counts.add(value);
      });
    });
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    if (_counts.length > 0) {
      _userName = _counts[0];
      _password = application.findUser(_userName);
    }
  }

  void _vailUser() async {
    if (_userName.trim() == "") {
      showToast("用户名不能为空!");
      return;
    }
    if (_password.trim() == "") {
      showToast("密码不能为空!");
      return;
    }
    Map requestMes = {
      constants.type: constants.user,
      constants.subtype: constants.login,
      constants.id: _userName,
      constants.password: md5(_password),
      constants.version: constants.currentVersion,
    };
    handler.userName = _userName;
    handler.password = _password;
    handler.initSocket(requestMes);
  }

  void toUserCenter() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => UserCenter()));
  }

  Widget _inputCountLogin() {
    return Scaffold(
      key: key,
      body: Container(
        margin: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/icon.png",
                          width: 70.0,
                          height: 70.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "畅聊",
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "用户名",
                    ),
                    onChanged: (value) => _userName = value,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "密码"),
                    onChanged: (value) => _password = value,
                    obscureText: true,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 50.0,
                      margin: EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 245, 255, 0.8),
                      ),
                      child: const Text(
                        "登录",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromRGBO(248, 248, 255, 1.0)),
                      ),
                    ),
                    onTapDown: (e) {
                      _vailUser();
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    child: const Text(
                      "选择账号",
                      style: TextStyle(fontSize: 18.0, color: Colors.green),
                    ),
                    onTapDown: (e) {
                      if (_counts.length > 0) {
                        _userName = _counts[0];
                        _password = application.findUser(_userName);
                        this.setState(() {
                          isSelect = !isSelect;
                        });
                      } else {
                        showToast("暂无账号!");
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: const Text("新用户注册",
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.green)),
                      onTapDown: (e) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Register()));
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _selectCounts() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
              alignment: Alignment.centerLeft,
              child: Text(
                "畅聊",
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                this.setState(() {
                  this.isExpanded = !isExpanded;
                });
              },
              children: [
                ExpansionPanel(
                  isExpanded: isExpanded,
                  headerBuilder: (BuildContext context, bool isExpand) {
                    return Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/images/head.png"),
                          radius: 30.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              _userName,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  body: Column(
                    children: [
                      Column(
                        children: _counts.map((countName) {
                          return FadeTransition(
                            opacity: _drawerContentsOpacity,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/head.png"),
                              ),
                              title: Text(countName),
                              onTap: () {
                                this.setState(() {
                                  _userName = countName;
                                  _password = application.findUser(_userName);
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            child: new FlatButton(
                              onPressed: () {
                                this.setState(() {
                                  isSelect = !isSelect;
                                  _userName = "";
                                  _password = "";
                                });
                              },
                              textTheme: ButtonTextTheme.accent,
                              child: const Text(
                                "输入账号",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            child: new FlatButton(
                              onPressed: () {
                                _vailUser();
                              },
                              textTheme: ButtonTextTheme.accent,
                              child: const Text(
                                "登录",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
