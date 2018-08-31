import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/page/subpage/webview.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;

class About extends StatefulWidget {
  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  Color primaryColor = Colors.lightBlue;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primaryColor:primaryColor),
      child: Scaffold(
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
                        child: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          minRadius: 60.0,
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
                        "版本:0.2",
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
                            _openLink(
                                "https://github.com/GZYangKui/flutter-IM");
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
      ),
    );
  }

  void _updateProgram(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("检测更新中.....")));
  }

  void _openLink(String url) async {
    Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => WebViewStateful(
                  url: url,
                ),
          ),
        );
  }
}
