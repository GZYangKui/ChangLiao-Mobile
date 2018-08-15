import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/chart_message_item.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;

class ChartDialog extends StatefulWidget {
 final List<String> _list;
  String _name;

  ChartDialog({List<String> messages, String name}):
    this._list =messages,
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
    _timer = Timer.periodic(Duration(milliseconds: 20), (e) {
      this.setState(() {});
    });
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
      constants.body: _message,
      constants.version: constants.currentVersion
    };
    handler.sendRequest(message);
    _message = "";
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null && _timer.isActive) _timer.cancel();
  }
}

class MyController extends TextEditingController {
  MyController({String text, TextSelection textSelection}) : super(text: text) {
    this.text = text;
    super.selection = textSelection;
  }
}
