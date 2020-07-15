import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/screens/song_list/tile_provider.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongTile extends StatefulWidget {
  final AudioPlayer audioPlayerRef;
  final int count;
  final String title;
  final String artist;
  final String filePath;
  final HomeProvider homeProvider;
  SongTile(
      {@required this.count,
      @required this.title,
      @required this.artist,
      @required this.filePath,
      @required this.homeProvider,
      @required this.audioPlayerRef});
  @override
  _SongTileState createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TileProvider>(
      create: (context) => TileProvider(),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            _handlePlay();
          },
          child: Container(
            width: ScreenDimension.width,
            height: ScreenDimension.percent(percent: 8, isHeight: true),
            color: CustomColors.background,
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ///divide into three portion horizontally
                Container(
                  alignment: Alignment.center,
                  width: ScreenDimension.percent(percent: 20, isHeight: false),
                  child: _countBuilder(),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: ScreenDimension.percent(percent: 80, isHeight: false) -
                      20,
                  child: _songInfo(),
                ),
                // Container(
                //   width: ScreenDimension.percent(percent: 20, isHeight: false),
                //   alignment: Alignment.center,
                //   child: _playerButton(_tileProvider),
                // )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _countBuilder() {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CustomColors.background, width: 2),
            gradient: LinearGradient(
                colors: [CustomColors.upperLeftShadow, CustomColors.background],
                stops: [0.3, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(1, 1),
                  color: CustomColors.lowerRightShadow),
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(-1, -1),
                  color: CustomColors.upperLeftShadow),
            ]),
        child: Text(
          widget.count.toString(),
          style: TextStyle(color: CustomColors.normalText),
        ));
  }

  Widget _songInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //
        Container(
          alignment: Alignment.centerLeft,
          height: ScreenDimension.percent(percent: 5, isHeight: true) - 5,
          width: ScreenDimension.percent(percent: 60, isHeight: false) - 20,
          child: Text(
            widget.title,
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: CustomColors.highlightedText,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: ScreenDimension.percent(percent: 3, isHeight: true) - 5,
          width: ScreenDimension.percent(percent: 60, isHeight: false) - 20,
          child: Text(
            widget.artist,
            style: TextStyle(color: CustomColors.normalText, fontSize: 10),
          ),
        )
      ],
    );
  }

  Widget _playerButton(TileProvider provider) {
    AudioPlayer _audioPlayer = AudioPlayer();
    return GestureDetector(
      onTap: () async {
        if (provider.isPlaying == false) {
          _audioPlayer.play(widget.filePath, isLocal: true);
        } else {
          _audioPlayer.stop();
        }
      },
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: CustomColors.background, width: 2),
              gradient: LinearGradient(colors: [
                CustomColors.upperLeftShadow,
                CustomColors.background
              ], stops: [
                0.3,
                1
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(1, 1),
                    color: CustomColors.lowerRightShadow),
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(-1, -1),
                    color: CustomColors.upperLeftShadow),
              ]),
          child: provider.playPauseIcon),
    );
  }

  Future<void> _handlePlay() async {
    if (widget.count - 1 != widget.homeProvider.currentSongIndex) {
      widget.homeProvider.setSongName = 'Loading ...';
      widget.homeProvider.setArtist = 'Unknown';
      //if playing or paused another song stop it first
      if (widget.homeProvider.isCompleted == false &&
          widget.homeProvider.isStopped == false) {
        widget.homeProvider.updateSongStatus(playpause: false);
        widget.homeProvider.notify();
        await widget.audioPlayerRef.stop();
         widget.homeProvider.updateSongStatus(playpause: true);
        widget.homeProvider.notify();
      }
      //
      widget.homeProvider.setCurrentSongIndex = widget.count - 1;
      await widget.audioPlayerRef.play(widget.filePath, isLocal: true);
      widget.homeProvider.updateSongStatus(playpause: true);
      widget.homeProvider.setSongName = widget.title;
      widget.homeProvider.notify();
    }
  }
}
