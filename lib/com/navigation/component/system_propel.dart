import 'package:flutter/cupertino.dart';
import 'package:flutter_app/com/navigation/models/system_propel_model.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart' as handler;

///
///
///
/// 系统推送消息
/// @message 推送内容
/// @type 推送类型(目前只有好友请求和好友回复两种类型)
///
///

class SystemPropel extends StatefulWidget {
  final SystemPropelModel _model;

  SystemPropel(this._model);

  @override
  SystemPropelState createState() => SystemPropelState();
}

class SystemPropelState extends State<SystemPropel> {
  @override
  Widget build(BuildContext context) {
    switch (widget._model.type) {
      case constants.response:
        return _showResponse();
      default:
        return _showRequest();
    }
  }

  Widget _showRequest() {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(style: BorderStyle.solid),
          bottom: BorderSide(style: BorderStyle.solid),
          right: BorderSide(style: BorderStyle.solid),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "好友请求",
                style: TextStyle(fontSize: 23.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              widget._model.message,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(5.0),
            child: widget._model.isDeal
                ? (widget._model.isAccept
                    ? Text(
                        "你已经同意该好友请求",
                        style: TextStyle(fontSize: 17.0),
                      )
                    : Text(
                        "你已经拒绝该好友请求",
                        style: TextStyle(fontSize: 17.0),
                      ))
                : _showHandler(),
          ),
        ],
      ),
    );
  }

  Widget _showResponse() {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(style: BorderStyle.solid),
          bottom: BorderSide(style: BorderStyle.solid),
          right: BorderSide(style: BorderStyle.solid),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: Text("好友回复",style: TextStyle(fontSize: 23.0),),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(widget._model.message,style: TextStyle(fontSize: 17.0),),
          ),
        ],
      ),
    );
  }
  Widget _showHandler() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.green),
                    bottom: BorderSide(color: Colors.green),
                    left: BorderSide(color: Colors.green),
                    right: BorderSide(color: Colors.green))),
            margin: EdgeInsets.only(right: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "同意",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          onTapDown: (e) {
            _sendResponse(true);
          },
        ),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.red),
                    bottom: BorderSide(color: Colors.red),
                    left: BorderSide(color: Colors.red),
                    right: BorderSide(color: Colors.red))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "拒绝",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          onTapDown: (e) {
            _sendResponse(false);
          },
        ),
      ],
    );
  }
  void _sendResponse(bool isAccept) {
    widget._model.isDeal = true;
    widget._model.isAccept = isAccept;
    Map message = {
      constants.type: constants.friend,
      constants.subtype: constants.response,
      constants.to: widget._model.to,
      constants.accept: isAccept,
      constants.version: constants.currentVersion
    };
    handler.sendRequest(message);
    this.setState(() {
      handler.systemPropel=new List.from(handler.systemPropel);
    });

  }
}
