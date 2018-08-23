import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/page/subpage/new_trend.dart';

class DynamicState extends StatefulWidget {
  @override
  DynamicOfState createState() => DynamicOfState();
}

class DynamicOfState extends State<DynamicState> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.free_breakfast),
                      Expanded(
                        child: Text(
                          "我的空间",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
              onTapDown: (e) {
                Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text("该功能将在下一个版本开放!")));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.new_releases),
                      Expanded(
                        child: Text(
                          "新趋势",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
              onTapDown: (e) {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>NewTrend()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
