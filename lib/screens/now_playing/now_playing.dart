import 'package:Geets/screens/now_playing/now_playing_provider.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NowPlaying extends StatefulWidget {
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
                Positioned(
                    top: ScreenDimension.percent(percent: 5, isHeight: true),
                    left: ScreenDimension.percent(percent: 5, isHeight: false),
                    right: ScreenDimension.percent(percent: 5, isHeight: false),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _topOptions(onTap: () {}, iconData: Icons.arrow_back),
                        _topOptions(onTap: () {}, iconData: Icons.list)
                      ],
                    ))
              ]),
            ),
          );
        },
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
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(
                    1,
                    1,
                  ),
                  color: CustomColors.lowerRightShadow),
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(
                    -1,
                    -1,
                  ),
                  color: CustomColors.upperLeftShadow),
            ]),
        alignment: Alignment.center,
        child: Icon(
          iconData,
          color: DarkColors.playPauseButton,
        ),
      ),
    );
  }
}
