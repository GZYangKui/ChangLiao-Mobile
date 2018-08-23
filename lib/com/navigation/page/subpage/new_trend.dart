import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 此页是new_trend的一个精简版界面
///
///
class NewTrend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewTrendState();
}

class NewTrendState extends State<NewTrend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新趋势"),
        centerTitle: true,
      ),
      body: TabBarView(children: []),
    );
  }
}
