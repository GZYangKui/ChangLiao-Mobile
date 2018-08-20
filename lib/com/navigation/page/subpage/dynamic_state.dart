import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DynamicState extends StatefulWidget {
  @override
  DynamicOfState createState() => DynamicOfState();
}

class DynamicOfState extends State<DynamicState> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:GestureDetector(
              child:  Row(
                children: <Widget>[
                  Icon(Icons.free_breakfast),
                  Expanded(
                    child: Text(
                      "我的空间",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
              onTapDown: (e){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("该功能将在下一个版本开放!")));
              },
            ),
          ),
        ],
      ),
    );
  }
}
