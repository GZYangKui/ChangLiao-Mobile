import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/page/subpage/webview.dart';
import 'package:flutter_app/com/navigation/utils/utils.dart';
import 'package:http/http.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;

///
/// 此页是new_trend的一个精简版界面
/// 之人工智能
///
///
class ArtificialIntelligence extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ArtificialIntelligenceState();
}

class ArtificialIntelligenceState extends State<ArtificialIntelligence>
    with TickerProviderStateMixin {
  List<String> _title = [];
  List<String> _briefs = [];
  List<String> _urls = [];
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  @override
  void initState() {
    super.initState();
    _loadData(application.aiDate);
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
      child: Scaffold(
        body: RefreshIndicator(
            child: ListView(
              children: _title.map((title) {
                return FadeTransition(
                  opacity: _drawerContentsOpacity,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text("AI"),
                        ),
                        title: Text(title),
                        onTap: () {
                          _openLink(title);
                        },
                      ),
                      Divider(
                        height: 3.0,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            onRefresh: () async {
              return await _refreshLoadData();
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showSelectDate();
          },
          child: Icon(Icons.date_range),
        ),
      ),
    );
  }

  void _showSelectDate() async {
    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime.parse("2018-07-20"),
        initialDate: DateTime.tryParse(application.aiDate),
        lastDate: DateTime.tryParse("2018-07-29"));
    application.aiDate = date.toString().split(" ")[0];
    _loadData(date.toString().split(" ")[0]);
  }

  Future<Null> _loadData(String date) async {
    get("http://www.dashixiuxiu.cn/query_aitopics?crawltime=$date")
        .then((response) {
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[constants.status] == "success") {
          if (_title.length > 0) _title.clear();
          if (_briefs.length > 0) _briefs.clear();
          if (_urls.length > 0) _urls.clear();
          var data = result[constants.data];
          if (data.length > 0)
            for (var item in data) {
              _title.add(item["cn_title"]);
              _urls.add(item["url"]);
              _briefs.add(item["cn_brief"]);
            }
          else {
            showToast("没有找到该日期对应的ai信息,换个日期试试!");
          }
          this.setState(() {});
        } else
          showToast("获取信息出错!");
      } else {
        showToast("连接服务器失败!");
      }
    });
  }

  _refreshLoadData() async {
    await _loadData(application.aiDate).then((value) {
      showToast("刷新成功!");
    }).catchError((error) {
      showToast("未知错误!");
    }).whenComplete(() {});
    return TickerFuture.complete();
  }

  void _openLink(String title) async {
    int index = 0;
    for (var item in _title) {
      if (title == item) break;
      index++;
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => WebViewStateful(
              url: _urls[index],
            )));
  }

  @override
  void dispose() {
    super.dispose();
    _urls?.clear();
    _briefs?.clear();
    _title?.clear();
  }
}
