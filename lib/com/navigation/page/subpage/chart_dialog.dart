import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/chart_message_item.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart' as handler;
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;

class ChartDialog extends StatefulWidget {
  List<String> _list;
  String _name;

  ChartDialog({List<String> messages, String name}) {
    this._list = messages;
    this._name = name;
  }

  @override
  ChartDialogState createState() => ChartDialogState();
}

class ChartDialogState extends State<ChartDialog> {
  String _message = "";
  Timer timer;
  @override
  void initState() {
    super.initState();
    handler.currentState = this;
    periodicUpdate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._name),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  ChartMessageItem(widget._list[index]),
              itemCount: widget._list.length,
            ),
          ),
          Builder(builder: (BuildContext context)=>
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: TextField(
                    onChanged: (value){
                      _message = value;
                    },
                    controller:TextEditingController(text: _message),
                  ),
                  ),
                  RaisedButton(
                    child: Text("发送"),
                    onPressed: () {
                      _sendMessage(_message);
                    },
                  ),
                ],
              ),
            ],
          ),
          ),
        ],
      ),
    );
  }
  void _sendMessage(String value){
    var message = {
      constants.type: constants.message,
      constants.subtype: constants.text,
      constants.to: widget._name,
      constants.body: _message,
      constants.version: constants.currentVersion
    };
    handler.sendRequest(message);
    widget._list.add(value+constants.messageOwn);
    handler.handlerMessageList(widget._name,value+constants.messageOwn);
    _message="";
  }
  void periodicUpdate(){
    Timer.periodic(Duration(seconds:1),(event){
      this.setState((){
        widget._list =List.from(widget._list);
      });
    });

  }
  @override
  void dispose() {
    super.dispose();
    if(timer!=null&&timer.isActive) timer.cancel();
  }

}
