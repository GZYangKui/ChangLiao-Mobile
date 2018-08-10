import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  String _userName = "";
  String _password = "";
  String _rePassword = "";
  BuildContext _context;

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
                          "assets/images/login_icon.png",
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
                  child:Builder(builder: (BuildContext context)=>
                  GestureDetector(
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
                    onTapDown: (event){
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

  void _sendRequest(String message) {
    HttpClient client = new HttpClient();
    client.put(constants.host,constants.httpPort, "user/register").then((request){
      request.write(message);
      return request.close();
    }).then((response){
      response.forEach((data){
        response.transform(utf8.decoder).listen((result){
          print(result);
        });
      });
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
          constants.password: "$_password"
        };
        _sendRequest(json.encode(map)+constants.end);

      } else {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("两次密码不匹配")));
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("尚有必要信息为空！")));
    }
  }
}
