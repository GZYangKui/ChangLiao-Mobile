import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 此页是new_trend的一个精简版界面
/// 之游戏
///
///
class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GameState();
}

class GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      text: "游戏",
    );
  }
}
