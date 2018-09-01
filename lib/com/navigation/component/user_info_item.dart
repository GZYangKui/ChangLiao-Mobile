import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoItem> with TickerProviderStateMixin {
  final List<String> _userInfo = ["用户名"];
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
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => Column(
            children: _userInfo.map((item) {
              return FadeTransition(
                opacity: _drawerContentsOpacity,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                  title: Text(item),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
              );
            }).toList(),
          ),
      itemCount: _userInfo.length,
    );
  }
}
