import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;
import 'package:flutter_app/com/navigation/utils/file_handler.dart'
    as fileHandler;

///
/// Application设置界面
///
///
///
class ApplicationSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ApplicationSettingState();
}

class ApplicationSettingState extends State<ApplicationSetting>
    with TickerProviderStateMixin {
  final List<Color> colors = [
    Colors.black,
    Colors.black12,
    Colors.deepPurpleAccent,
    Colors.teal,
    Colors.brown,
    Colors.red,
    Colors.green,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.yellow,
    Colors.purpleAccent,
    Colors.black54
  ];
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  bool isExpand = false;
  bool voiceSwitch = true;
  Color primaryColor = Colors.lightBlue;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    if (application.settings["voiceSwitch"] != null &&
        application.settings["voiceSwitch"] == "false") voiceSwitch = false;
    if (application.settings["primaryColor"] != null &&
        Color(int.parse(application.settings["primaryColor"])) != primaryColor)
      primaryColor = Color(int.parse(application.settings["primaryColor"]));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: Scaffold(
        appBar: AppBar(
          title: Text("设置"),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            FadeTransition(
              opacity: _drawerContentsOpacity,
              child: ListTile(
                leading: Icon(Icons.volume_up),
                title: Text(
                  "新消息提醒",
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: Switch(
                    value: voiceSwitch,
                    onChanged: (value) {
                      this.setState(() {
                        voiceSwitch = value;
                        application.settings["voiceSwitch"] = value.toString();
                      });
                    }),
              ),
            ),
            Divider(
              height: 10.0,
            ),
            _selectTheme(),
            Divider(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectTheme() {
    return Row(
      children: <Widget>[
        Expanded(
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              print(index);
              this.setState(() {
                this.isExpand = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0, right: 30.0),
                        child: Icon(Icons.palette),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "主题",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              width: 20.0,
                              height: 20.0,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                body: Wrap(
                  children: colors.map((color) {
                    return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(3.0),
                        height: 40.0,
                        width: 40.0,
                        color: color,
                      ),
                      onTapDown: (event) {
                        application.settings["primaryColor"] =
                            color.value.toString();
                        this.setState(() {
                          primaryColor = color;
                        });
                      },
                    );
                  }).toList(),
                ),
                isExpanded: this.isExpand,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    fileHandler.updateConfig();
  }
}
