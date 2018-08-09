import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/com/flutter/page/user.dart';
import 'package:flutter_app/com/flutter/page/register.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                            "assets/images/login_icon.png",
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
                      decoration: InputDecoration(labelText: "用户名"),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: "密码"),
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
                        child: Text(
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
                      child: Text(
                        "忘记密码？",
                        style: TextStyle(fontSize: 18.0, color: Colors.green),
                      ),
                      onTapDown: (e) {
                        //找回密码
                      },
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text("新用户注册",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.green)),
                        onTapDown: (e) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Register()));
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
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
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  void _vailUser() {
    //检验用户数据是否正确
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => UserCenter()));
  }
}
