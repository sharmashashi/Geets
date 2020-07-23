import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/screens/now_playing/now_playing.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

class PlayerBottomBar extends StatefulWidget {
  final HomeProvider homeProvider;
  final AudioPlayer audioPlayerRef;
  PlayerBottomBar({@required this.homeProvider, @required this.audioPlayerRef});
  @override
  _PlayerBottomBarState createState() => _PlayerBottomBarState();
}

class _PlayerBottomBarState extends State<PlayerBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.96,
      child: Container(
          width: ScreenDimension.percent(percent: 90, isHeight: false),
          height: ScreenDimension.percent(percent: 8, isHeight: true),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: CustomColors.background,
              boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(1, 1),
                    color: CustomColors.lowerRightShadow),
                BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(-1, -1),
                    color: CustomColors.upperLeftShadow)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[_songInfo(), _songController()],
          )),
    );
  }

  Widget _songInfo() {
    return GestureDetector(
      onTap: (){
        if(widget.homeProvider.songName!='Title')Navigator.push(context, MaterialPageRoute(builder: (context)=>NowPlaying()));
      },
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            height: ScreenDimension.percent(percent: 5, isHeight: true) - 5,
            width: ScreenDimension.percent(percent: 55, isHeight: false) - 20,
            child: Text(
              widget.homeProvider.songName,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: CustomColors.highlightedText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: ScreenDimension.percent(percent: 3, isHeight: true) - 5,
            width: ScreenDimension.percent(percent: 55, isHeight: false) - 20,
            child: Text(
              widget.homeProvider.artist,
              style: TextStyle(color: CustomColors.normalText, fontSize: 10),
            ),
          )
        ],
      ),
    );
  }

  Widget _songController() {
    return Container(
      width: ScreenDimension.percent(percent: 35, isHeight: false) + 20,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.skip_previous,
              color: DarkColors.playPauseButton,
            ),
            onPressed: () async {
              //if not first song
              if (widget.homeProvider.currentSongIndex != 0)
              //execute only if playing
              if (widget.homeProvider.isPlaying == true &&
                  widget.homeProvider.isCompleted == false &&
                  widget.homeProvider.isStopped == false) {
                await widget.audioPlayerRef.stop();

                widget.audioPlayerRef.play(
                    widget.homeProvider.musicFilePath[
                        widget.homeProvider.currentSongIndex - 1],
                    isLocal: true);
                widget.homeProvider.setCurrentSongIndex =
                    widget.homeProvider.currentSongIndex - 1;
                widget.homeProvider.setSongName = widget.homeProvider
                    .musicFileName[widget.homeProvider.currentSongIndex];
                widget.homeProvider.notify();
              }
            },
          ),
          IconButton(
            icon: widget.homeProvider.playPauseIcon,
            onPressed: () {
              if (widget.homeProvider.isPlaying == true) {
                widget.audioPlayerRef.pause();
              } else if (widget.homeProvider.isPlaying == false) {
                widget.audioPlayerRef.play(
                    widget.homeProvider
                        .musicFilePath[widget.homeProvider.currentSongIndex],
                    isLocal: true);
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.skip_next,
              color: DarkColors.playPauseButton,
            ),
            onPressed: () async {
              //if not last song
              if (widget.homeProvider.currentSongIndex !=
                  widget.homeProvider.musicFilePath.length - 1)
              //execute only if playing
              if (widget.homeProvider.isPlaying == true &&
                  widget.homeProvider.isCompleted == false &&
                  widget.homeProvider.isStopped == false) {
                await widget.audioPlayerRef.stop();

                widget.audioPlayerRef.play(
                    widget.homeProvider.musicFilePath[
                        widget.homeProvider.currentSongIndex + 1],
                    isLocal: true);
                widget.homeProvider.setCurrentSongIndex =
                    widget.homeProvider.currentSongIndex + 1;
                widget.homeProvider.setSongName = widget.homeProvider
                    .musicFileName[widget.homeProvider.currentSongIndex];

                widget.homeProvider.notify();
              }
            },
          ),
        ],
      ),
    );
  }
}
