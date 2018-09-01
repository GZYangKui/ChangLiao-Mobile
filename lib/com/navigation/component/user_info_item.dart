import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoItem> {
  final List<String> _items = ["用户名", "个性签名", "个人邮箱", "手机号", "个人网址"];
  final List<InfoItem> panels = [];
  @override
  void initState() {
    super.initState();
    for (var item in _items) panels.add(InfoItem(title: item));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        this.setState(() {
          panels[index].isExpanded = !isExpanded;
        });
      },
      children: panels.map((panel) {
        return panel.buildExpansionPanel;
      }).toList(),
    );
  }
}

class InfoItem {
  String title;
  bool isExpanded = false;

  InfoItem({@required this.title});
  ExpansionPanel get buildExpansionPanel => ExpansionPanel(
        headerBuilder: (BuildContext context, bool expanded) => ListTile(
              leading: Text(title),
              title: Text("hello"),
            ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "修改：",
                    style: TextStyle(fontSize: 18.0, color: Colors.red),
                  ),
                  Expanded(
                    child: TextField(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    onSave();
                  },
                  child: Text(
                    "确定",
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ],
        ),
        isExpanded: isExpanded,
      );
  void onSave() async {}
}
