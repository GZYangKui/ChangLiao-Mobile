import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/com/navigation/beautiful/CustomerOval.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: new Text("关于"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipOval(
                        clipper: CustomerOval(50.0, 50.0, 60.0),
                        child: Image.asset(
                          "assets/images/icon.png",
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "版本:1.0",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          "开源地址:github",
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.lightBlue),
                        ),
                        onTapDown: (e) {
                          _openLink("https://github.com/GZYangKui/flutter-IM");
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "版本更新",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Builder(
                              builder: (BuildContext context) => IconButton(
                                    icon: Icon(Icons.update),
                                    onPressed: () {
                                      _updateProgram(context);
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateProgram(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("检测更新中.....")));
  }

  void _openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      key.currentState.showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "调起系统浏览器失败",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              RaisedButton(
                child: Text(
                  "复制链接",
                  style: TextStyle(fontSize: 18.0),
                ),
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.red),
                ),
                onPressed: () {
                  ClipboardData(text: url);
                },
              )
            ],
          ),
        ),
      );
    }
  }
}
