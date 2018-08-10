import 'package:flutter/cupertino.dart';

class CustomerOval extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    Rect rect =Rect.fromCircle(center: Offset(50.0, 50.0),radius: 50.0);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }

}