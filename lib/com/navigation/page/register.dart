import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter_app/com/navigation/utils/utils.dart';
import 'package:http/http.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  String _userName = "";
  String _password = "";
  String _rePassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          "assets/images/icon.png",
                          width: 100.0,
                          height: 100.0,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(
                          "加入我们，一起畅聊",
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/user.png",
                    width: 30.0, height: 30.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "用户名"),
                    onChanged: (value) {
                      _userName = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/password.png",
                  width: 30.0,
                  height: 30.0,
                ),
                Expanded(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: "密码"),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/password.png",
                  width: 30.0,
                  height: 30.0,
                ),
                Expanded(
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: "确认密码"),
                    onChanged: (value) {
                      _rePassword = value;
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Builder(
                    builder: (BuildContext context) => GestureDetector(
                          child: Builder(
                            builder: (BuildContext context) => Container(
                                  height: 40.0,
                                  margin: EdgeInsets.only(top: 10.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 245, 255, 0.8),
                                  ),
                                  child: Text("注册"),
                                ),
                          ),
                          onTapDown: (event) {
                            _vailData(context);
                          },
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _sendRequest(String message, BuildContext context) {
    put("${constants.http}${constants.domain}/${constants.user}/${constants.register}",body: message).then((response){
      if(response.statusCode==200) {
        var result = json.decode( utf8.decode(response.bodyBytes));
        if (result["register"]) {
          _showMessage(context, "注册成功!");
        } else {
          _showMessage(context, result["info"]);
        }
      }else{
        _showMessage(context, "服务器异常,请重试!");
      }
      });
  }

  void _vailData(BuildContext context) {
    if (_userName.trim() != "" &&
        _password.trim() != "" &&
        _rePassword.trim() != "") {
      if (_password == _rePassword) {
        Map map = {
          constants.type: constants.user,
          constants.subtype: constants.register,
          constants.id: "$_userName",
          constants.password: md5("$_password"),
          constants.version: constants.currentVersion
        };
        _sendRequest(json.encode(map) + constants.end, context);
      } else {
        _showMessage(context, "两次密码不一致!");
      }
    } else {
      _showMessage(context, "尚有必要信息为空!");
    }
  }

  void _showMessage(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
