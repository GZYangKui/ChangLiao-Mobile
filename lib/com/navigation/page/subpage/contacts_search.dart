import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
/// 联系人及聊天信息搜索
///
///
class ContactsSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactsSearchState();
}

class ContactsSearchState extends State<ContactsSearch> {
  List<String> _list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      hintText: "搜索"),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    _search(value);
                  },
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 3.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "取消",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                onTapDown: (e) {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _list.length == 0 ? _showCard() : _showContactList(),
          ),
        ],
      ),
    );
  }

  Widget _showCard() {
    return Container();
  }

  Widget _showContactList() {
    return ListView(
      children: <Widget>[],
    );
  }

  void _search(String value) {
    if (value != "") {
    } else {
      _showMessage("搜索关键字不能为空!");
    }
  }

  void _showMessage(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }
}
