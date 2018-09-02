import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/models/new_trend_model.dart';
import 'package:flutter_app/com/navigation/page/subpage/webview.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;
import 'package:http/http.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter_app/com/navigation/utils/utils.dart';
import 'package:flutter_app/com/navigation/utils/file_handler.dart'
    as fileHandler;

///
/// 此页是new_trend的一个精简版界面
/// 之人区块链
///
///
List<NewTrendModel> _model = [];

class BlockChain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BlockChainState();
}

class BlockChainState extends State<BlockChain> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  @override
  void initState() {
    super.initState();
    _loadData(application.blockDate);
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
            children: _model.map((block) {
              return FadeTransition(
                opacity: _drawerContentsOpacity,
                child: Column(
                  children: <Widget>[
                    BlockChainItem(block),
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
        initialDate: DateTime.tryParse(application.blockDate),
        lastDate: DateTime.now());
    if (date != null) {
      application.blockDate = date.toString().split(" ")[0];
      _loadData(date.toString().split(" ")[0]);
    }
  }

  Future<Null> _loadData(String date) async {
    this.setState(() {
      _model.clear();
    });
    print(_model.length);
    get("http://www.dashixiuxiu.cn/query_cointelegraph?crawltime=$date")
        .then((response) {
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        if (result[constants.status] == "success") {
          var data = result[constants.data];
          if (data.length > 0)
            for (var item in data) {
              _model.add(NewTrendModel(item["cn_title"], item["url"],
                  item["cn_brief"], item["en_brief"]));
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
    await _loadData(application.blockDate).then((value) {
      showToast("刷新成功!");
    }).catchError((error) {
      showToast("未知错误!");
    }).whenComplete(() {});
    return TickerFuture.complete();
  }

  @override
  void dispose() {
    super.dispose();
    _model.clear();
  }
}

class BlockChainItem extends StatefulWidget {
  final NewTrendModel model;

  BlockChainItem(this.model);

  @override
  State<StatefulWidget> createState() => BlockChainItemState();
}

class BlockChainItemState extends State<BlockChainItem> {
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
        backgroundImage: AssetImage("assets/images/new_trend/block_chain.jpeg"),
      ),
      title: Text(widget.model.title),
      trailing: IconButton(
        icon: Icon(!isStar ? Icons.star_border : Icons.star),
        onPressed: () {
          this.setState(() {
            isStar = !isStar;
            if (isStar)
              fileHandler.insertCollect(widget.model, "BC");
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
