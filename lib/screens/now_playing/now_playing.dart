import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/screens/now_playing/now_playing_provider.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/custom_shadow.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NowPlaying extends StatefulWidget {
  final AudioPlayer audioPlayerRef;
  final HomeProvider homeProvider;
  NowPlaying({this.homeProvider, this.audioPlayerRef});
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NowPlayingProvider>(
      create: (context) => NowPlayingProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: CustomColors.background,
            body: Container(
              height: ScreenDimension.height,
              width: ScreenDimension.width,
              child: Stack(children: <Widget>[
                //song list and back button
                ///reserves height: 12 percent
                Positioned(
                    top: ScreenDimension.percent(percent: 5, isHeight: true),
                    left: ScreenDimension.percent(percent: 5, isHeight: false),
                    right: ScreenDimension.percent(percent: 5, isHeight: false),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _topOptions(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            iconData: Icons.arrow_back),
                        Text(
                          'Now Playing',
                          style: TextStyle(
                              shadows: CustomShadow.textShadow,
                              color: CustomColors.background,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        _topOptions(onTap: () {}, iconData: Icons.list)
                      ],
                    )),

                ///reserves height :70 percent by width
                Positioned(
                  left: ScreenDimension.percent(percent: 15, isHeight: false),
                  top: ScreenDimension.percent(percent: 15, isHeight: true),
                  child: _songImage(),
                ),

                ///reserves height :5 percent
                Positioned(
                    top: ScreenDimension.percent(percent: 70, isHeight: false) +
                        ScreenDimension.percent(percent: 18, isHeight: true),
                    child: _songInfo())
              ]),
            ),
          );
        },
      ),
    );
  }

  Widget _songInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //
        Container(
          alignment: Alignment.center,
          height: ScreenDimension.percent(percent: 2.5, isHeight: true),
          width: ScreenDimension.percent(percent: 100, isHeight: false),
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
          alignment: Alignment.center,
          height: ScreenDimension.percent(percent: 2.5, isHeight: true),
          width: ScreenDimension.percent(percent: 100, isHeight: false),
          child: Text(
            widget.homeProvider.artist,
            style: TextStyle(color: CustomColors.normalText, fontSize: 10),
          ),
        )
      ],
    );
  }

  Widget _songImage() {
    return Container(
      width: ScreenDimension.percent(percent: 70, isHeight: false),
      height: ScreenDimension.percent(percent: 70, isHeight: false),
      decoration: BoxDecoration(
          color: CustomColors.background,
          shape: BoxShape.circle,
          boxShadow: CustomShadow.bigImageShadow),
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: Image.asset(
          CustomColors.background == DarkColors.background
              ? 'assets/couple_dark.jpg'
              : 'assets/couple_light.jpg',
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _topOptions({@required Function onTap, @required IconData iconData}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenDimension.percent(percent: 7, isHeight: true),
        width: ScreenDimension.percent(percent: 7, isHeight: true),
        decoration: BoxDecoration(
            color: CustomColors.background,
            shape: BoxShape.circle,
            boxShadow: CustomShadow.normalButtonShadow),
        alignment: Alignment.center,
        child: Icon(
          iconData,
          color: DarkColors.playPauseButton,
        ),
      ),
    );
  }
}
