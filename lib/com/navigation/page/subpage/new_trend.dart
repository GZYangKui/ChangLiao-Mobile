import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/page/subpage/new_trend/artificial_intelligence.dart';
import 'package:flutter_app/com/navigation/page/subpage/new_trend/block_chain.dart';
import 'package:flutter_app/com/navigation/page/subpage/new_trend/crowd_funding.dart';
import 'package:flutter_app/com/navigation/page/subpage/new_trend/game.dart';
import 'package:flutter_app/com/navigation/page/subpage/new_trend/social_hotspots.dart';

///
/// 此页是new_trend的一个精简版界面
///
///
class NewTrend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewTrendState();
}

class NewTrendState extends State<NewTrend>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;
  final List<String> _titles = ["人工智能", "区块链", "社会热点", "游戏", "众筹"];
  final List<Widget> _tabs = [
    ArtificialIntelligence(),
    BlockChain(),
    SocialHotSpot(),
    Game(),
    CrowdFunding(),
  ];
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      this.setState(() {
        this._currentIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: TabBarView(
        children: _tabs,
        controller: _tabController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
              title: Text("人工智能"), icon: Icon(Icons.threed_rotation)),
          BottomNavigationBarItem(
            title: Text("区块链"),
            icon: Icon(Icons.block),
          ),
          BottomNavigationBarItem(
              title: Text("社会热点"), icon: Icon(Icons.hot_tub)),
          BottomNavigationBarItem(title: Text("游戏"), icon: Icon(Icons.games)),
          BottomNavigationBarItem(
              title: Text("众筹"), icon: Icon(Icons.attach_money)),
        ],
        onTap: (index) {
          this.setState(() {
            _currentIndex = index;
          });
          _tabController.animateTo(index);
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
