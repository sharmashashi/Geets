import 'package:Geets/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {

  Icon _playPauseIcon = Icon(
    Icons.play_arrow,
    color: DarkColors.playPauseButton,
  );

  Icon get playPauseIcon => _playPauseIcon;
  set setPlayPauseIcon(Icon icon) {
    _playPauseIcon = icon;
  }

  List<String> _artistList = List();
  List<String> get artistList => _artistList;
  set setArtistList(List<String> list) {
    this._artistList = list;
  }

  List<Widget> _artWork = List();
  List<Widget> get artWork => _artWork;
  set setArtWork(List<Widget> wrk) {
    this._artWork = wrk;
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  bool _isCompleted = false;
  bool _isStopped = true;
  bool get isCompleted => _isCompleted;
  bool get isStopped => _isStopped;

  ///pass value for only one attribute at a time
  updateSongStatus({bool playpause, bool completed, bool stopped}) {
    if (playpause != null) {
      if (playpause) {
        _playPauseIcon = Icon(Icons.pause, color: DarkColors.playPauseButton);
      } else {
        _playPauseIcon =
            Icon(Icons.play_arrow, color: DarkColors.playPauseButton);
      }
      _isPlaying = playpause;
      _isCompleted = false;
      _isStopped = false;
    } else if (completed != null) {
      _isCompleted = completed;
      _isStopped = false;
    } else if (stopped != null) {
      _isCompleted = false;
      _isStopped = isStopped;
    }
  }

  int _currentSong = 0;
  int get currentSongIndex => _currentSong;
  set setCurrentSongIndex(int index) {
    this._currentSong = index;
  }

  bool _hasFetchedAllSongs = false;
  bool get hasFetchedAllSongs => _hasFetchedAllSongs;
  set setHasFetchedAllSongs(bool val) {
    this._hasFetchedAllSongs = val;
  }

  List<String> _musicFilePath = [''];
  List<String> get musicFilePath => _musicFilePath;
  set setMusicFilePath(List<String> list) {
    this._musicFilePath = list;
  }

  List<String> _musicFileName = [''];
  List<String> get musicFileName => _musicFileName;
  set setMusicFileName(List<String> list) {
    this._musicFileName = list;
  }

  notify() {
    notifyListeners();
  }
}
