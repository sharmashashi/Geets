import 'package:flutter/material.dart';

class LightColors {
  static Color get upperLeftShadow => Colors.white;
  static Color get lowerRightShadow => Color(0xffcfd0d0);
  static Color get background => Color(0xfff1f2f2);
  static Color get purple1 => Color(0xff9a97b4);
  static Color get playPauseButton => Color(0xff94589b);
  static Color get purpleDark => Color(0xff785aa0);
  static Color get dark => Color(0xff352351);
  static Color get purple2 => Color(0xffad77a3);
}

class DarkColors {
  static Color get dark => Color(0xff050606);
  static Color get upperLeftShadow => Color(0xff434343);
  static Color get lowerRightShadow => Color(0xff232323);
  static Color get background => Color(0xff333333);
  static Color get red1 => Color(0xffd11302);
  static Color get red2 => Color(0xffa30d02);
  static Color get redDark => Color(0xff5d0f04);
  static Color get playPauseButton => Colors.deepOrange;
  static Color get lightPink => Color(0xfff5a691);
}

class CustomColors {
  CustomColors.privateConstructor();
  static final CustomColors instance = CustomColors.privateConstructor();

  static Color background = LightColors.background;
  static Color lowerRightShadow = LightColors.lowerRightShadow;
  static Color upperLeftShadow = LightColors.upperLeftShadow;
  static Color normalText = Colors.grey;
  static Color highlightedText = Colors.grey[900];
  static Color other = Colors.grey[700];
  static Color playPauseButton = LightColors.playPauseButton;
  static Color selectedSong = LightColors.dark;
  static Color dark = Colors.black;

  static void applyDarkTheme() {
    background = DarkColors.background;
    lowerRightShadow = DarkColors.lowerRightShadow;
    upperLeftShadow = DarkColors.upperLeftShadow;
    normalText = Colors.white54;
    highlightedText = Colors.white70;
    other = Colors.white70;
    playPauseButton = DarkColors.playPauseButton;
    selectedSong = DarkColors.dark;
    dark = Colors.black;
  }

  static void applyLightTheme() {
    background = LightColors.background;
    lowerRightShadow = LightColors.lowerRightShadow;
    upperLeftShadow = LightColors.upperLeftShadow;
    normalText = Colors.grey;
    highlightedText = Colors.grey[700];
    other = Colors.grey[700];
    playPauseButton = LightColors.playPauseButton;
    selectedSong = LightColors.dark;
    dark = LightColors.background;
  }
}
