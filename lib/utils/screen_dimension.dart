import 'package:flutter/material.dart';

class ScreenDimension {
  ScreenDimension.privateConstructor();
  static final ScreenDimension instance = ScreenDimension.privateConstructor();
  static double _height, _width;

  static void init({@required double height, @required double width}) {
    _height = height;
    _width = width;
  }

  static double get height => _height;
  static double get width => _width;
  static double percent({@required double percent, @required bool isHeight}) {
    return isHeight == true ? _height * percent / 100 : _width * percent / 100;
  }
}
