import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_app/com/navigation/utils/application.dart'
    as application;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/com/navigation/utils/utils.dart';

class WebViewStateful extends StatefulWidget {
  final String _url;

  WebViewStateful({String url}) : this._url = url;

  @override
  State<StatefulWidget> createState() => WebViewState();
}

class WebViewState extends State<WebViewStateful> {
  final FlutterWebviewPlugin manager = FlutterWebviewPlugin();
  String _title = "loading......";
  String _url;
  @override
  void initState() {
    super.initState();
    initWebView();
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
      child: WebviewScaffold(
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
          actions: <Widget>[
            Tooltip(
              message: "外部浏览器打开",
              child: IconButton(
                icon: Icon(Icons.zoom_out_map),
                onPressed: () {
                  _openOutBrowser();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void initWebView() async {
    manager.onUrlChanged.listen((url) {
      _url = url;
      manager.evalJavascript("document.title").then((title) {
        title = title.replaceAll("\"", "");
        this.setState(() {
          _title = title;
        });
      });
    });
  }

  void _openOutBrowser() async {
    String url = _url ?? widget._url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast("调起系统浏览器失败！");
    }
  }

  @override
  void dispose() {
    super.dispose();
    manager.close();
  }
}
