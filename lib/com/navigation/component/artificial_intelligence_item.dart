import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArtificialIntelligenceItem extends StatefulWidget {
  final String title;
  final String brief;
  final String url;

  ArtificialIntelligenceItem({String title, String brief, String url})
      : this.title = title,
        this.brief = brief ?? "暂无简介",
        this.url = url;

  @override
  State<StatefulWidget> createState() => ArtificialIntelligenceItemState();
}

class ArtificialIntelligenceItemState
    extends State<ArtificialIntelligenceItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
              icon: Image.asset(
                "assets/images/new_trend/ai.png",
                width: 50.0,
                height: 50.0,
              ),
              onPressed: () {},
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(widget.title),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.brief,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 3.0,
        ),
      ],
    );
  }
}
