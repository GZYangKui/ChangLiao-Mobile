import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/models/contacts_list_model.dart';
import 'package:flutter_app/com/navigation/page/subpage/chart_dialog.dart';

class ContactItem extends StatelessWidget {
  ContactItem(this.entry);

  BuildContext context;
  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.list.isEmpty)
      return GestureDetector(
        child: ListTile(
          title: getPerson(root.title),
        ),
        onTap: () {
          Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ChartDialog(
                        name: root.title,
                        messages: ["hello", "吃饭了吗???"],
                      ),
                ),
              );
        },
      );
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: getGroup(root.title),
      children: root.list.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return _buildTiles(entry);
  }

  getGroup(String title) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.asset(
              "assets/images/group.png",
              width: 30.0,
              height: 30.0,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(title),
          ],
        ),
      ],
    );
  }

  getPerson(String name) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.asset(
              "assets/images/person.png",
              width: 20.0,
              height: 20.0,
            )
          ],
        ),
        Column(
          children: <Widget>[Text(name)],
        )
      ],
    );
  }
}
