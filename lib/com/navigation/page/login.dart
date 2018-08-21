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

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String _userName = "";
  String _password = "";
  GlobalKey<ScaffoldState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                      decoration: InputDecoration(labelText: "用户名"),
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
                        child: const Text("新用户注册",
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
    handler.loginState = this;
  }

  void _vailUser() async {
    if (_userName.trim() == "") {
      showAlertMessage("用户名不能为空!");
      return;
    }
    if (_password.trim() == "") {
      showAlertMessage("密码不能为空!");
      return;
    }
    Map requestMes = {
      constants.type: constants.user,
      constants.subtype: constants.login,
      constants.id: _userName,
      constants.password: md5(_password),
      constants.version: constants.currentVersion,
    };
    try {
      handler.socket = await handler.initSocket();
      handler.socketHandler();
      _showToast("登录中..");
      handler.sendRequest(requestMes);
      handler.userName = _userName;
      handler.password = md5(_password);
    } catch (e) {
      showAlertMessage("网络异常");
      return;
    }
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        bgcolor: "#e74c3c",
        textcolor: '#ffffff');
  }

  void toUserCenter() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => UserCenter()));
    _showToast("登录成功");
  }

  void showAlertMessage(String message) {
    key.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
