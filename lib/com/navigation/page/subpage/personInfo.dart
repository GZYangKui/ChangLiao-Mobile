import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;
import 'package:flutter_app/com/navigation/utils/file_handler.dart'
    as fileHandler;
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;

class PersonInfo extends StatefulWidget {
  final String _name;

  PersonInfo(this._name);

  @override
  PersonInfoState createState() => PersonInfoState();
}

class PersonInfoState extends State<PersonInfo> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  Color primaryColor = Colors.lightBlue;
  dynamic info;
  @override
  void initState() {
    super.initState();
    handler.currentState = this;
    if (application.settings["primaryColor"] != null &&
        Color(int.parse(application.settings["primaryColor"])) != primaryColor)
      primaryColor = Color(int.parse(application.settings["primaryColor"]));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: Scaffold(
        key: key,
        appBar: AppBar(
          title: Text(widget._name),
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
                      decoration: InputDecoration(
                          hintText: info == null ? "用户名" : info["id"]),
                      onChanged: (value) => info["id"] = value,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.phone),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: info == null ? "手机" : info["phone"]),
                      onChanged: (value) => info["phone"] = value,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.email),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: info == null ? "邮箱" : info["mail"]),
                      onChanged: (value) => info["mail"] = value,
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
                          hintText: info == null ? "个人主页" : info["website"]),
                      onChanged: (value) => info["website"] = value,
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
                          hintText: info == null ? "公司" : info["company"]),
                      onChanged: (value) => info["company"] = value,
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
                          hintText: info == null ? "所在地" : info["address"]),
                      onChanged: (value) => info["address"] = value,
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
                          hintText: info == null ? "个人简介/个性签名" : info["brief"]),
                      onChanged: (value) => info["brief"] = value,
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
      ),
    );
  }

  void _saveMessage() {}
  void _showMessage(String message) {
    key.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
