import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/screens/song_list/tile_provider.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongTile extends StatefulWidget {
  final bool backAfterClick;
  final AudioPlayer audioPlayerRef;
  final int count;
  final String title;
  final String artist;
  final String filePath;
  final Widget artWork;
  final HomeProvider homeProvider;
  SongTile(
      {@required this.count,
      @required this.title,
      @required this.artist,
      @required this.filePath,
      @required this.homeProvider,
      this.backAfterClick,
      this.artWork,
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
            if (widget.backAfterClick == true) Navigator.pop(context);
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
                  width: ScreenDimension.percent(percent: 60, isHeight: false) -
                      20,
                  child: _songInfo(),
                ),
                _artWork(),
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
            widget.title != null ? widget.title : 'Guess the title',
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
             widget.artist != null ? widget.artist : 'Unknown',
            style: TextStyle(color: CustomColors.normalText, fontSize: 10),
          ),
        )
      ],
    );
  }

  Widget _artWork() {
    return Container(
        width: ScreenDimension.percent(percent: 8, isHeight: true),
        height: ScreenDimension.percent(percent: 8, isHeight: true),
        decoration: BoxDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: widget.artWork,
        ));
  }

  Future<void> _handlePlay() async {
    if (widget.count - 1 != widget.homeProvider.currentSongIndex) {
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

      widget.homeProvider.notify();
    }
  }
}
