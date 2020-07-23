import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/screens/song_list/song_tile.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

class CurrentSongList extends StatefulWidget {
  final HomeProvider homeProvider;
  final AudioPlayer audioPlayer;
  CurrentSongList({@required this.homeProvider, @required this.audioPlayer});
  @override
  _CurrentSongListState createState() => _CurrentSongListState();
}

class _CurrentSongListState extends State<CurrentSongList> {
  List<Widget> _songList = [
    Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
          child: Text(
        'Loading...',
        style: TextStyle(color: CustomColors.highlightedText),
      )),
    )
  ];
  bool _init = false;

  _setSongList() {
    //display all song list
    List<Widget> tempList = List();
    for (int i = 0; i < widget.homeProvider.musicFileName.length; i++) {
      tempList.add(SongTile(
        backAfterClick: true,
        homeProvider: widget.homeProvider,
        audioPlayerRef: widget.audioPlayer,
        artist: "unknown",
        count: i + 1,
        filePath: widget.homeProvider.musicFilePath[i],
        title: widget.homeProvider.musicFileName[i],
      ));
    }
    if (tempList.length == 0) {
      _songList = [
        Center(
            child: Text(
          'There are no songs in your device',
          style: TextStyle(color: CustomColors.highlightedText),
        ))
      ];
    } else {
      tempList.add(Container(
        width: 5,
        height: ScreenDimension.percent(percent: 10, isHeight: true),
      ));
      _songList = tempList;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_init == false) {
      _init = true;
      _setSongList();
    }
    return Container(
      width: ScreenDimension.width,
      height: ScreenDimension.height,
      color: CustomColors.background,
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: _songList,
      ),
    );
  }
}
