import 'dart:async';
import 'dart:io';

import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/screens/song_list/song_list_provider.dart';
import 'package:Geets/screens/song_list/song_tile.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongList extends StatefulWidget {
  final HomeProvider homeProvider;
  final AudioPlayer audioPlayer;
  SongList({@required this.homeProvider, @required this.audioPlayer});
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  List<String> musicPathList = List();
  List<String> musicFileNameList = List();
  bool fetchSong = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SongListProvider>(
        create: (context) => SongListProvider(),
        child: Builder(
          builder: (context) {
            SongListProvider _songListProvider =
                Provider.of<SongListProvider>(context);
            if (fetchSong == false) {
              fetchSong = true;
              _getSongList(_songListProvider);

              //listen for audio status
              widget.audioPlayer.onPlayerStateChanged.listen((event) async {
                if (event == AudioPlayerState.PLAYING) {
                  widget.homeProvider.updateSongStatus(playpause: true);
                } else if (event == AudioPlayerState.PAUSED) {
                  widget.homeProvider.updateSongStatus(playpause: false);
                } else if (event == AudioPlayerState.COMPLETED) {
                  widget.homeProvider.updateSongStatus(completed: true);
                  widget.homeProvider.setPlayPauseIcon =
                      Icon(Icons.play_arrow, color: DarkColors.playPauseButton);
                  widget.homeProvider.notify();
                  //play next song if previous is not last one
                  if (widget.homeProvider.currentSongIndex !=
                      widget.homeProvider.musicFilePath.length - 1) {
                    await widget.audioPlayer.play(
                        widget.homeProvider.musicFilePath[
                            widget.homeProvider.currentSongIndex + 1],
                        isLocal: true);
                    widget.homeProvider.setSongName =
                        widget.homeProvider.musicFileName[
                            widget.homeProvider.currentSongIndex + 1];
                    widget.homeProvider.setCurrentSongIndex =
                        widget.homeProvider.currentSongIndex + 1;
                    widget.homeProvider.notify();
                  } else {
                    widget.homeProvider.setCurrentSongIndex = 0;
                  }
                } else {
                  widget.homeProvider.updateSongStatus(stopped: true);
                  widget.homeProvider.setPlayPauseIcon =
                      Icon(Icons.play_arrow, color: DarkColors.playPauseButton);
                }
              });
            }
            return Container(
              height: ScreenDimension.percent(percent: 96.5, isHeight: true),
              width: ScreenDimension.width,
              color: CustomColors.background,
              child: ListView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  children: _songListProvider.songList),
            );
          },
        ));
  }

  //get song list
  _getSongList(SongListProvider provider) async {
    String _fileName;
    Directory _dir = Directory(Directory.current.path + 'storage');
    Stream<FileSystemEntity> entityStream = _dir.list(recursive: true);
    // ignore: cancel_subscriptions
    StreamSubscription<FileSystemEntity> subscription =
        entityStream.listen((_) {});
    subscription.onData((event) async {
      if (event.path.contains('.mp3') ||
          event.path.contains('.m4a') ||
          event.path.contains('.Mp3')) {
        musicPathList.add(event.path);
        _fileName =
            event.path.replaceRange(0, event.parent.path.length + 1, '');
        musicFileNameList.add(_fileName);
      }
    });
    subscription.onDone(() {
      widget.homeProvider.setMusicFileName = musicFileNameList;
      widget.homeProvider.setMusicFilePath = musicPathList;
      widget.homeProvider.setHasFetchedAllSongs = true;
      widget.homeProvider.notify();

      //display all song list
      List<Widget> tempList = List();
      for (int i = 0; i < musicFileNameList.length; i++) {
        tempList.add(SongTile(
          homeProvider: widget.homeProvider,
          audioPlayerRef: widget.audioPlayer,
          artist: "unknown",
          count: i + 1,
          filePath: musicPathList[i],
          title: musicFileNameList[i],
        ));
      }
      if (tempList.length == 0) {
        provider.setSongList = [Text('There are no songs in your device')];
      } else {
        tempList.add(Container(
          width: 5,
          height: ScreenDimension.percent(percent: 10, isHeight: true),
        ));
        provider.setSongList = tempList;
      }
    });
  }
}
