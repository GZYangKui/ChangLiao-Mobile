import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/beautiful/CustomerOval.dart';

class About extends StatefulWidget {
  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("关于"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 150.0,
            child: Column(
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
                Text("版本:0.1"),
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
                      Text("版本更新"),
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
}
