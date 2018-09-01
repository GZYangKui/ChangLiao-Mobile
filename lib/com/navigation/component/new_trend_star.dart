import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTrendStar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewTrendStarState();
}

class _NewTrendStarState extends State<NewTrendStar>
    with TickerProviderStateMixin {
  final List<String> items = ["中国科技"];
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
            children: items.map((item) {
              return FadeTransition(
                opacity: _drawerContentsOpacity,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/head.png"),
                  ),
                  title: Text(item),
                  trailing:
                      IconButton(icon: Icon(Icons.star), onPressed: () {}),
                  onTap: () {},
                ),
              );
            }).toList(),
          ),
      itemCount: items.length,
    );
  }
}
