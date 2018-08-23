import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 此页是new_trend的一个精简版界面
/// 之人众筹
///
///
class CrowdFunding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CrowdFundingState();
}

class CrowdFundingState extends State<CrowdFunding> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      text: "众筹",
    );
  }
}
