import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/system_propel.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;

///
///
///系统推送界面
///
///

class SystemInform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SystemInformState();
}

class SystemInformState extends State<SystemInform> {
  @override
  void initState() {
    super.initState();
    handler.currentState=this;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("系统消息"),
        centerTitle: true,
      ),
      body: handler.systemPropel.length > 0 ? _showPropel() : _showEmpty(),
    );
  }

  Widget _showPropel() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          SystemPropel(handler.systemPropel[index]),
      itemCount: handler.systemPropel.length,
    );
  }

  Widget _showEmpty() {
    return Container(
      margin: EdgeInsets.only(top:(ui.window.physicalSize.height/ui.window.devicePixelRatio)*0.2),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Image.asset("assets/images/icon.png"),
          Text("暂无系统消息",style: TextStyle(fontSize: 20.0),),
        ],
      ),
    );
  }
}
