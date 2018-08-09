import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'com/flutter/page/login.dart';

void main() =>runApp(Application());

class Application extends StatelessWidget{
  @override
  Widget build(BuildContext context)=>MaterialApp(home:ApplicationHome() ,title: "flutter_IM",);

}
class ApplicationHome extends StatefulWidget{
  @override
  HomeState createState()=>HomeState();

}

class HomeState extends State<ApplicationHome>{


  @override
  Widget build(BuildContext context) {
    return FlutterLogo(duration: Duration(seconds: 2),);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
  ///
  /// 应用加载数据
  ///
  void _loadData() async{
   Timer timer;
   timer=Timer.periodic(Duration(seconds: 3),(e){

     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Login()));
     timer.cancel();
   });
  }

  HomeState(){
    _loadData();
  }

}