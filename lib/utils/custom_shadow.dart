import 'package:Geets/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomShadow {
  static List<BoxShadow> normalButtonShadow = [
    BoxShadow(
        blurRadius: 3,
        spreadRadius: 1,
        offset: Offset(
          1,
          1,
        ),
        color: CustomColors.lowerRightShadow),
    BoxShadow(
        blurRadius: 3,
        spreadRadius: 1,
        offset: Offset(
          -1,
          -1,
        ),
        color: CustomColors.upperLeftShadow),
  ];
  static List<BoxShadow> bigImageShadow = [
    BoxShadow(
        blurRadius: 10,
        spreadRadius: 5,
        offset: Offset(
          5,
          5,
        ),
        color: CustomColors.lowerRightShadow),
    BoxShadow(
        blurRadius: 10,
        spreadRadius: 5,
        offset: Offset(
          -5,
          -5,
        ),
        color: CustomColors.upperLeftShadow),
  ];
  static List<BoxShadow> textShadow = [
    BoxShadow(
        blurRadius: 0.5,
        spreadRadius: 0.1,
        offset: Offset(
          0.5,
          0.5,
        ),
        color: CustomColors.lowerRightShadow),
    BoxShadow(
        blurRadius: 0.5,
        spreadRadius: 0.1,
        offset: Offset(
          -0.5,
          -0.5,
        ),
        color: CustomColors.upperLeftShadow),
  ];
}
