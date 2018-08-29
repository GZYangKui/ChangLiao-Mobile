import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/page/subpage/new_trend.dart';

class MinApplication extends StatefulWidget {
  @override
  MinApplicationState createState() => MinApplicationState();
}

class MinApplicationState extends State<MinApplication>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;

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
  }

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: ListView(
        children: <Widget>[
          FadeTransition(
            opacity: _drawerContentsOpacity,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.new_releases),
                  title: Text(
                    "新趋势",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => NewTrend()),
                      ),
                ),
                Divider(
                  height: 3.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
