import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchState();
}

class SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "输入搜索关键字",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text("搜索"),
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
