import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/models/new_trend_model.dart';
import 'package:flutter_app/com/navigation/page/subpage/webview.dart';
import 'package:flutter_app/com/navigation/utils/utils.dart';
import 'package:http/http.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;
import 'package:flutter_app/com/navigation/utils/file_handler.dart'
    as fileHandler;

///
/// 此页是new_trend的一个精简版界面
/// 之人工智能
///

List<NewTrendModel> _model = [];

class ArtificialIntelligence extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArtificialIntelligenceState();
}

class _ArtificialIntelligenceState extends State<ArtificialIntelligence>
    with TickerProviderStateMixin {
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
    return Scaffold(
      body: RefreshIndicator(
          child: ListView(
            children: _model.map((ai) {
              return FadeTransition(
                opacity: _drawerContentsOpacity,
                child: Column(
                  children: <Widget>[
                    ArtificialIntelligenceItem(ai),
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
    );
  }

  void _showSelectDate() async {
    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime.parse("2018-07-01"),
        initialDate: DateTime.tryParse(application.aiDate),
        lastDate: DateTime.now());
    if (date != null) {
      application.aiDate = date.toString().split(" ")[0];
      _loadData(date.toString().split(" ")[0]);
    }
  }

  Future<Null> _loadData(String date) async {
    _model.clear();
    get("http://www.dashixiuxiu.cn/query_aitopics?crawltime=$date")
        .then((response) {
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[constants.status] == "success") {
          var data = result[constants.data];
          if (data.length > 0)
            for (var item in data) {
              NewTrendModel news = NewTrendModel(item["cn_title"], item["url"],
                  item["cn_brief"], item["en_brief"]);
              _model.add(news);
            }
          else {
            showToast("暂无信息!");
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

  @override
  void dispose() {
    super.dispose();
    _model?.clear();
  }
}

class ArtificialIntelligenceItem extends StatefulWidget {
  final NewTrendModel model;

  ArtificialIntelligenceItem(this.model);

  @override
  State<StatefulWidget> createState() => ArtificialIntelligenceItemState();
}

class ArtificialIntelligenceItemState
    extends State<ArtificialIntelligenceItem> {
  bool isStar = false;
  @override
  void initState() {
    super.initState();
    _checkDate();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage("assets/images/new_trend/ai.jpeg"),
      ),
      title: Text(widget.model.title),
      trailing: IconButton(
        icon: Icon(!isStar ? Icons.star_border : Icons.star),
        onPressed: () {
          this.setState(() {
            isStar = !isStar;
            if (isStar)
              fileHandler.insertCollect(widget.model, "AI");
            else
              fileHandler.deleteCollects(widget.model.title);
          });
        },
      ),
      onTap: () {
        Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => WebViewStateful(
                      url: widget.model.url,
                    ),
              ),
            );
      },
    );
  }

  void _checkDate() async {
    bool isExist = await fileHandler.selectCollects(widget.model.title);
    if (isExist) {
      this.setState(() {
        isStar = isExist;
      });
    }
  }
}
