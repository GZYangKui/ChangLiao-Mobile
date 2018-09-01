import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 图片选择器
///
class SelectPicture extends StatefulWidget {
  final String title;

  SelectPicture(this.title);

  @override
  State<StatefulWidget> createState() => SelectPictureState();
}

class SelectPictureState extends State<SelectPicture> {
  final List<String> tabs = ["美女", "帅哥", "风景"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          bottom: TabBar(
              tabs: tabs.map((title) {
            return Tab(
              text: title,
            );
          }).toList()),
        ),
        body: TabBarView(children: [
          GridView.count(
            crossAxisCount: 5,
            children: <Widget>[],
          ),
          GridView.count(
            crossAxisCount: 5,
            children: <Widget>[],
          ),
          GridView.count(
            crossAxisCount: 5,
            children: <Widget>[],
          ),
        ]),
      ),
    );
  }
}
