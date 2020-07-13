import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/saved_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TileProvider with ChangeNotifier {
  Icon _playPauseIcon = Icon(
    Icons.play_arrow,
    color: CustomColors.playPauseButton,
  );

  Icon get playPauseIcon => _playPauseIcon;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  updateSongStatus({@required bool play}) {
    SavedPreferences.fetch(isDarkTheme: true).then((value) {
      
      if (play) {
        _isPlaying = true;
        _playPauseIcon = Icon(
          Icons.pause,
          color: value == true
              ? DarkColors.playPauseButton
              : LightColors.playPauseButton,
        );
      } else {
        _isPlaying = false;
        _playPauseIcon = Icon(
          Icons.play_arrow,
          color: value == true
              ? DarkColors.playPauseButton
              : LightColors.playPauseButton,
        );
      }
    notifyListeners();
    });

  }
}
