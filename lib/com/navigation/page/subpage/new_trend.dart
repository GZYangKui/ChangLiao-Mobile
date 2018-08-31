import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/navigation/page/subpage/new_trend/artificial_intelligence.dart';
import 'package:flutter_app/com/navigation/page/subpage/new_trend/block_chain.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;

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
  final List<Widget> _tabs = [
    ArtificialIntelligence(),
    BlockChain(),
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
    return Theme(
      data: ThemeData(
        primaryColor: application.settings["primaryColor"] == null
            ? Colors.lightBlue
            : Color(
                int.parse(application.settings["primaryColor"]),
              ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("新趋势"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: TabBarView(
          children: _tabs,
          controller: _tabController,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.threed_rotation),
              title: Text("人工智能"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.block),
              title: Text("区块链"),
            ),
          ],
          onTap: (index) {
            this.setState(() {
              _currentIndex = index;
              _tabController.index = _currentIndex;
            });
          },
          currentIndex: _currentIndex,
        ),
      ),
    );
  }
}
