import 'dart:math' as math;

import 'package:flutter/material.dart';

class Responsive2 {
  double _width, _height, _diagonal;
  bool _isTablet;

  double get width => _width;

  double get height => _height;

  double get diagonal => _diagonal;

  bool get isTablet => _isTablet;

  static Responsive2 of(BuildContext context) => Responsive2(context);

  Responsive2(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;

    //c2+ a2+b2 => c = srt(a2+b2)
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
    _isTablet = size.shortestSide >= 600;
  }

  double wp(double percent) => _width * percent / 100;

  double hp(double percent) => _height * percent / 100;

  double ip(double percent) => _diagonal * percent / 100;
}
