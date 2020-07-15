import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/screens/home/player_bottom_bar.dart';
import 'package:Geets/screens/song_list/song_list.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: Builder(
        builder: (context) {
          HomeProvider _homeProvider = Provider.of<HomeProvider>(context);
          return Container(
            color: CustomColors.background,
            width: ScreenDimension.width,
            height: ScreenDimension.percent(percent: 100, isHeight: true),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: ScreenDimension.percent(percent: 3.5, isHeight: true),
                  child: SongList(
                    homeProvider: _homeProvider,
                    audioPlayer: audioPlayer,
                  ),
                ),
                Positioned(
                  top: ScreenDimension.percent(percent: 91, isHeight: true),
                  left: ScreenDimension.percent(percent: 5, isHeight: false),
                  child: PlayerBottomBar(homeProvider:_homeProvider,audioPlayerRef: audioPlayer,),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  
}
