import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/models/new_trend_model.dart';
import 'package:flutter_app/com/navigation/page/subpage/webview.dart';
import 'package:flutter_app/com/navigation/utils/file_handler.dart'
    as fileHandler;

class NewTrendStar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewTrendStarState();
}

class _NewTrendStarState extends State<NewTrendStar>
    with TickerProviderStateMixin {
  final List<String> menuItems = ["详情", "移除"];
  List<NewTrendModel> items = [];
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
    _loadData();
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
                    backgroundImage: AssetImage("assets/images/favorites.png"),
                  ),
                  title: Text(item.title),
                  trailing: PopupMenuButton(
                      onSelected: (value) {
                        print(value);
                      },
                      itemBuilder: (BuildContext context) =>
                          menuItems.map((value) {
                            return PopupMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                  onTap: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => WebViewStateful(
                                  url: item.url,
                                ),
                          ),
                        );
                  },
                ),
              );
            }).toList(),
          ),
      itemCount: items.length,
    );
  }

  void _loadData() async {
    items = await fileHandler.loadCollects();
    this.setState(() {});
  }
}
