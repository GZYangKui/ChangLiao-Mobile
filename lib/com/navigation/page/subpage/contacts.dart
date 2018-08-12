import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/component/contacts_list_item.dart';
import 'package:flutter_app/com/navigation/models/contacts_list_model.dart';

///
/// 联系人界面
///
///
class Contacts extends StatefulWidget {
  @override
  ContactsState createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  List<Entry> _list = [
    Entry("我的好友", [Entry("jack"), Entry("Tom")])
  ];

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: RefreshIndicator(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(3.0),
            decoration: BoxDecoration(color: Colors.grey),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: "搜索"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  ContactItem(_list[index]),
              itemCount: _list.length,
            ),
          ),
        ],
      ),
      onRefresh: () => TickerFuture.complete(),
    ));
  }
}
