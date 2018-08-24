import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/splash_screne.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: ApplicationHome(),
        title: "畅聊",
      );
}

class ApplicationHome extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<ApplicationHome> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 1,
      image: Image.asset("assets/images/icon.png"),
      photoSize: 70.0,
      title: Text(
        "畅聊",
        style: TextStyle(fontSize: 25.0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
