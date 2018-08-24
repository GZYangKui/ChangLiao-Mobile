import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;

///
/// Application设置界面
///
///
///
class ApplicationSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ApplicationSettingState();
}

class ApplicationSettingState extends State<ApplicationSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.volume_up),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "新消息提醒",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Switch(
                        value: application.voiceSwitch,
                        onChanged: (value) {
                          this.setState(() {
                            application.voiceSwitch = value;
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 0.0,
          ),
          Row(
            children: <Widget>[
              Icon(Icons.brightness_2),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "夜间模式",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Switch(
                        value: application.nightModel,
                        onChanged: (value) {
                          this.setState(() {
                            application.nightModel = value;
                          });
                        })
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 0.0,
          ),
        ],
      ),
    );
  }
}
