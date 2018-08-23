import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/com/navigation/component/search_contacts_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/com/navigation/netwok/socket_handler.dart'
    as handler;

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
  List<InputChip> _chipItem = [];

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
                    if (value != "") {
                      _search(value);
                      _addChip(value);
                    } else {
                      _showMessage("搜索关键字不能为空!");
                    }
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
    return new Wrap(
      spacing: 10.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: _chipItem,
    );
  }

  Widget _showContactList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          SearchContactsItem(_list[index]),
      itemCount: _list.length,
    );
  }

  void _search(String value) async {
    if (_list.length > 0) _list.clear();
    bool isExist = false;
    handler.contactsList.forEach((entry) {
      if (entry.list != null && entry.list.length > 0) {
        entry.list.forEach((e) {
          if (e.title == value) {
            print(e.title);
            _list.add(e.title);
            isExist = true;
            return;
          }
        });
      }
      if (isExist) return;
    });
    if (!isExist) _showMessage("找不到相关信息!");
    this.setState(() {});
  }

  void _showMessage(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }

  void _addChip(String message) {
    InputChip clip = InputChip(
      label: Text(message),
      avatar: CircleAvatar(
        backgroundColor: Colors.blue.shade900,
        child: const Text("CL"),
      ),
      onPressed: () {
        _search(message);
      },
    );
    _chipItem.add(clip);
  }

  @override
  void dispose() {
    super.dispose();
    if (_list.length > 0) _list.clear();
    if (_chipItem.length > 0) _chipItem.clear();
  }
}
