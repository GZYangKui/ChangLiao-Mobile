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
            margin: EdgeInsets.all(3.0),
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
                  ),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 5.00),
                    decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1.0),),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("搜索"),
                    ),
                  ),
                  onTapDown: (e)=>_search(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _search(){

  }
}
