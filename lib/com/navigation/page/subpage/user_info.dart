import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/new_trend_star.dart';
import 'package:flutter_app/com/navigation/component/user_info_item.dart';
import 'package:flutter_app/com/navigation/page/subpage/picture_select.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;

class UserInfo extends StatefulWidget {
  final String userName;

  UserInfo(this.userName);

  @override
  State<StatefulWidget> createState() => UserInfoState();
}

class TabItem {
  String title;
  IconData icon;

  TabItem({this.icon, this.title});
}

class UserInfoState extends State<UserInfo>
    with SingleTickerProviderStateMixin {
  final List<String> menuItem = ["更换背景"];
  final List<TabItem> _tabs = [
    TabItem(title: "个人信息", icon: Icons.info),
    TabItem(title: "收藏", icon: Icons.collections)
  ];
  TabController _controller;

  Color primaryColor = Colors.lightBlue;

  @override
  void initState() {
    super.initState();
    primaryColor = application.settings["primaryColor"] == null
        ? Colors.lightBlue
        : Color(
            int.parse(application.settings["primaryColor"]),
          );
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              application.images["user_background"],
            ],
          ),
          bottom: TabBar(
            tabs: _tabs.map((tab) {
              return Tab(
                text: tab.title,
                icon: Icon(tab.icon),
              );
            }).toList(),
            controller: _controller,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: <Widget>[
                UserInfoItem(),
              ],
            ),
            NewTrendStar(),
          ],
          controller: _controller,
        ),
      ),
    );
  }
}
