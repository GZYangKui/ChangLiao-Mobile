import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/search_item.dart';
import 'package:flutter_app/com/navigation/utils/constant.dart' as constants;
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart' as handler;

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<Search> {
  List<String> list =[];
  String _keyword ="";
  GlobalKey<ScaffoldState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("添加"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0,left: 3.0,right: 3.0,bottom: 10.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(211, 211, 211, 0.8),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "输入搜索关键字",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value){
                      _keyword = value;
                    },
                  ),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 5.00),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("搜索"),
                    ),
                  ),
                  onTapDown: (e) => _search(),
                ),
              ],
            ),
          ),
          Expanded(
            child:list.length==0?_showMenu():_showResult(),
          ),
        ],
      ),
    );
  }

  void _search() {
    if (_keyword != null && _keyword.trim() != "") {
      var message = {
        constants.type: constants.search,
        constants.subtype: constants.info,
        constants.id: handler.userName,
        constants.password: handler.password,
        constants.keyword: _keyword,
        constants.version: constants.currentVersion
      };
      var httpClient = HttpClient();
      httpClient
          .put(constants.server, constants.httpPort,
          "/${constants.search}/${constants.info}")
          .then((request) {
        request.write(json.encode(message) + constants.end);
        return request.close();
      }).then((response) {
        response.transform(utf8.decoder).listen((data) {
            var _result = json.decode(data);
            if(_result!=null) {
              list.clear();
              list.add(_result["user"]["id"]);
              setState(() {

              });
            }
            else key.currentState.showSnackBar(SnackBar(content: Text("找不到该用户信息!")));
        });
      });
      _keyword = "";
    } else {
     key.currentState.showSnackBar(SnackBar(content: Text("搜索关键字不能为空!")));
    }
  }

  Widget _showMenu(){
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: Row(
              children: <Widget>[
                Icon(Icons.phone_iphone),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("手机联系人",style: TextStyle(fontSize: 22.0),),
                      Text("添加或邀请通讯录中的好友"),
                    ],
                  ),
                ),
              ],
            ),
            onTapDown: (e) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: Row(
              children: <Widget>[
                Icon(Icons.swap_calls),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("扫码",style: TextStyle(fontSize: 22.0),),
                      Text("扫描二维码名片"),
                    ],
                  ),
                ),
              ],
            ),
            onTapDown: (e) {},
          ),
        ),
      ],
    );
  }
  Widget _showResult(){
    return ListView.builder(itemBuilder: (BuildContext context,int index)=>UserItem(list[index]),
      itemCount:list.length,);
  }

  @override
  void dispose() {
    super.dispose();
    list.clear();
  }

}
