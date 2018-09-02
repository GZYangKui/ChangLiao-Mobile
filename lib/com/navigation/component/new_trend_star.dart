import 'dart:async';

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
  final List<String> menuItems = ["移除"];
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
    return RefreshIndicator(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => FadeTransition(
              opacity: _drawerContentsOpacity,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/favorites.png"),
                    ),
                    title: Text(items[index].title),
                    trailing: PopupMenuButton(
                        onSelected: (value) {
                          _removeItem(value);
                        },
                        itemBuilder: (BuildContext context) =>
                            menuItems.map((value) {
                              return PopupMenuItem<String>(
                                value: items[index].title,
                                child: Text(value),
                              );
                            }).toList()),
                    onTap: () {
                      Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  WebViewStateful(
                                    url: items[index].url,
                                  ),
                            ),
                          );
                    },
                  ),
                  Divider(
                    height: 3.0,
                  ),
                ],
              ),
            ),
        itemCount: items.length,
      ),
      onRefresh: () async {
        return await _loadData();
      },
    );
  }

  Future<Null> _loadData() async {
    if (items.length > 0) items.clear();
    items = await fileHandler.loadCollects();
    this.setState(() {});
    return TickerFuture.complete();
  }

  void _removeItem(String title) async {
    var result = await fileHandler.deleteCollects(title);
    if (result > 0) {
      int index = 0;
      items.forEach((model) {
        if (model.title == title) {
          return;
        }
        index++;
      });
      this.setState(() {
        items.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    items.clear();
  }
}
