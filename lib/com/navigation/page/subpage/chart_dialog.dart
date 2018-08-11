import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/chart_message_item.dart';

class ChartDialog extends StatefulWidget {
  List<String> _list;
  String _name;

  ChartDialog({List<String> messages, String name}) {
    this._list = messages;
    this._name = name;
  }

  @override
  ChartDialogState createState() => ChartDialogState(_name, _list);
}

class ChartDialogState extends State<ChartDialog> {
  String _name;
  List<String> _list;

  ChartDialogState(this._name, this._list);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  ChartMessageItem(_list[index]),
              itemCount: _list.length,
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: TextField()),
                  RaisedButton(
                    child: Text("发送"),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
