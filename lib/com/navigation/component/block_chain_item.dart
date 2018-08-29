import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/page/subpage/webview.dart';

class BlockChainItem extends StatefulWidget {
  final String title;
  final String brief;
  final String url;

  BlockChainItem({String title, String brief, String url})
      : this.title = title,
        this.brief = brief ?? "暂无简介",
        this.url = url;

  @override
  State<StatefulWidget> createState() => BlockChainItemState();
}

class BlockChainItemState extends State<BlockChainItem> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Image.asset(
                        "assets/images/new_trend/block_chain.png",
                        width: 50.0,
                        height: 50.0,
                      ),
                      onPressed: () {}),
                  Expanded(
                    child: Text(
                      widget.title,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 3.0,
              ),
            ],
          ),
          onTapDown: (e) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => WebViewStateful(
                      url: widget.url,
                    )));
          },
        ),
        onRefresh: () {});
  }
}
