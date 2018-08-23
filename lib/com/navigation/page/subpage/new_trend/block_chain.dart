import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 此页是new_trend的一个精简版界面
/// 之人区块链
///
///
class BlockChain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BlockChainState();
}

class BlockChainState extends State<BlockChain> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      text: "区块链",
    );
  }
}
