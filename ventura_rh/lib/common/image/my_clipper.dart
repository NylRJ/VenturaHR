import 'package:flutter/cupertino.dart';

class MyClipper extends CustomClipper<Rect>{


  @override
  getClip(Size size) {
    return Rect.fromCircle(radius:60,center: Offset(100,100) );
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }


}