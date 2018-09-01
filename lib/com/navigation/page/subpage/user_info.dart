import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/new_trend_star.dart';
import 'package:flutter_app/com/navigation/component/user_info_item.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;

class UserInfo extends StatefulWidget {
  final String userName;

  UserInfo(this.userName);

  @override
  State<StatefulWidget> createState() => UserInfoState();
}

class _Page {
  final String title;
  final IconData icon;
  _Page({this.title, this.icon});
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class UserInfoState extends State<UserInfo>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
  final double expandHeight = 200.0;
  final List<String> menuItem = ["更换背景"];
  final List<_Page> pages = [
    _Page(title: "个人信息", icon: Icons.info),
    _Page(title: "关注", icon: Icons.star)
  ];
  Color primaryColor = Colors.lightBlue;
  TabController _controller;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: pages.length);
    primaryColor = application.settings["primaryColor"] == null
        ? Colors.lightBlue
        : Color(
            int.parse(application.settings["primaryColor"]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: primaryColor,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: expandHeight,
              pinned: _appBarBehavior == AppBarBehavior.pinned,
              floating: _appBarBehavior == AppBarBehavior.floating ||
                  _appBarBehavior == AppBarBehavior.snapping,
              snap: _appBarBehavior == AppBarBehavior.snapping,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                  tooltip: "编辑",
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) => menuItem.map((item) {
                        return PopupMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/user_background.jpeg",
                      fit: BoxFit.cover,
                      height: expandHeight,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/head.png"),
                                radius: 35.0,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.userName,
                                style: TextStyle(
                                    fontSize: 20.0, color: primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                  tabs: pages.map((page) {
                    return Tab(
                      text: page.title,
                      icon: Icon(page.icon),
                    );
                  }).toList(),
                  controller: _controller),
            ),
            SliverFillViewport(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => TabBarView(
                      children: [
                        UserInfoItem(),
                        NewTrendStar(),
                      ],
                      controller: _controller,
                    ),
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _showPersonInfo() {
    return ListView(
      children: <Widget>[Text("hello")],
    );
  }

  Widget _showStarItem() {
    return ListView(
      children: <Widget>[],
    );
  }
}
