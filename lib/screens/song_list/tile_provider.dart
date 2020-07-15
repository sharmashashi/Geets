import 'package:Geets/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TileProvider with ChangeNotifier {
  Icon _playPauseIcon = Icon(
    Icons.play_arrow,
    color: DarkColors.playPauseButton,
  );

  Icon get playPauseIcon => _playPauseIcon;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  updateSongStatus({@required bool play}) {
    if (play) {
      _playPauseIcon = Icon(Icons.pause, color: DarkColors.playPauseButton);
    } else {
      _playPauseIcon =
          Icon(Icons.play_arrow, color: DarkColors.playPauseButton);
    }
    _isPlaying = play;
    notifyListeners();
  }
}
