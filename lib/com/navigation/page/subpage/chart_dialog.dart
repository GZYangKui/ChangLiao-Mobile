import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/chart_message_item.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;

class ChartDialog extends StatefulWidget {
  final List<String> _list;
  final String _name;

  ChartDialog({List<String> messages, String name})
      : this._list = messages,
        this._name = name;

  @override
  ChartDialogState createState() => ChartDialogState();
}

class ChartDialogState extends State<ChartDialog> {
  String _message = "";
  Timer _timer;

  @override
  void initState() {
    super.initState();
    handler.currentState = this;
    _timer = Timer.periodic(Duration(milliseconds: 30), (event) {
      this.setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._name),
        centerTitle: true,
        actions: <Widget>[
          Tooltip(
            child: IconButton(
              icon: Image.asset(
                "assets/images/clear.png",
                width: 40.0,
                height: 40.0,
              ),
              onPressed: () {
                _clearMessage();
              },
            ),
            message: "清除聊天记录",
          ),
        ],
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
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    _message = value;
                  },
                  controller: MyController(
                      text: _message,
                      textSelection: TextSelection(
                          baseOffset: _message.length,
                          extentOffset: _message.length)),
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
    );
  }

  void _sendMessage(String value) {
    widget._list.add(value + constants.messageOwn);
    var message = {
      constants.type: constants.message,
      constants.subtype: constants.text,
      constants.to: widget._name,
      constants.body: value,
      constants.version: constants.currentVersion
    };
    handler.sendRequest(message);
    _message = "";
  }

  void _clearMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
            title: Text("警告"),
            children: [
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "确定要清空聊天记录?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("取消"),
                        onPressed: () => Navigator.pop(context),
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      RaisedButton(
                        child: Text("确定"),
                        onPressed: () {
                          handler.clearMessage(widget._name);
                          Navigator.pop(context);
                        },
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null && _timer.isActive) _timer.cancel();
    if(widget._list.length==0) handler.clearMessage(widget._name);
  }
}

class MyController extends TextEditingController {
  MyController({String text, TextSelection textSelection}) : super(text: text) {
    this.text = text;
    super.selection = textSelection;
  }
}
