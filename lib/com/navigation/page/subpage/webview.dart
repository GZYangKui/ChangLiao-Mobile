import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewStateful extends StatefulWidget {
  final String _url;

  WebViewStateful({String url}) : this._url = url;

  @override
  State<StatefulWidget> createState() => WebViewState();
}

class WebViewState extends State<WebViewStateful> {
  final FlutterWebviewPlugin manager = FlutterWebviewPlugin();
  String _title = "loading......";
  @override
  void initState() {
    super.initState();
    initWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget._url,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          width: (window.physicalSize.width / window.devicePixelRatio) * 0.6,
          child: Text(
            _title,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
    );
  }

  void initWebView() async {
    manager.onUrlChanged.listen((url) {
      print(url);
      manager.evalJavascript("document.title").then((title) {
        title = title.replaceAll("\"", "");
        this.setState(() {
          _title = title;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    manager.close();
  }
}
