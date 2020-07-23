import 'package:flutter/material.dart';

class NowPlayingProvider with ChangeNotifier {
  double _value = 0;
  double get sliderValue => _value;
  set setSliderValue(double val) {
    this._value = val;
  }

  String _presentTime = '00:00';
  String _remainingTime = '00:00';
  String get presentTime => _presentTime;
  String get remainingTime => _remainingTime;
  set setPresentTime(String t) {
    this._presentTime = t;
  }

  set setRemainingTime(String t) {
    this._remainingTime = t;
  }

  IconData _playPauseIconData = Icons.play_arrow;
  IconData get playPauseIconData => _playPauseIconData;
  set setPlayPauseIconData(IconData d) {
    this._playPauseIconData = d;
  }

  notify() {
    notifyListeners();
  }
}
