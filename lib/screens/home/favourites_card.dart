import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:flutter/material.dart';

class FavouritesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenDimension.percent(percent: 85, isHeight: false),
      height: ScreenDimension.percent(percent: 25, isHeight: true),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(1, 1),
            color: CustomColors.lowerRightShadow),
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(-1, -1),
            color: CustomColors.upperLeftShadow),
      ], color: CustomColors.background,
      borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
