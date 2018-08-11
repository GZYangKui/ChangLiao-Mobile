import 'package:flutter/cupertino.dart';

class CustomerOval extends CustomClipper<Rect>{
  double _xOffset;
  double _yOffset;
  double _radius;


  CustomerOval(this._xOffset, this._yOffset, this._radius);

  @override
  Rect getClip(Size size) {
    Rect rect =Rect.fromCircle(center: Offset(_xOffset,_yOffset),radius:_radius );
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }

}