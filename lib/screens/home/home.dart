import 'package:Geets/screens/home/favourites_card.dart';
import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/screens/song_list/song_list.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  top: ScreenDimension.percent(percent: 70, isHeight: true),
                  left: ScreenDimension.percent(percent: 7.5, isHeight: false),
                  child: FavouritesCard(),
                ),
                Positioned(
                  top: ScreenDimension.percent(percent: 3.5, isHeight: true),
                  child: SongList(),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget _themeSelector() {
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         border: Border.all(color: CustomColors.background, width: 2),
  //         gradient: LinearGradient(
  //             colors: [CustomColors.upperLeftShadow, CustomColors.background],
  //             stops: [0.3, 1],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight),
  //         boxShadow: [
  //           BoxShadow(
  //               blurRadius: 2,
  //               spreadRadius: 2,
  //               offset: Offset(1, 1),
  //               color: CustomColors.lowerRightShadow),
  //           BoxShadow(
  //               blurRadius: 2,
  //               spreadRadius: 2,
  //               offset: Offset(-1, -1),
  //               color: CustomColors.upperLeftShadow),
  //         ]),
  //     child: GestureDetector(
  //       onTap: () async {
  //         bool darkTheme = await SavedPreferences.fetch(isDarkTheme: true);
  //         darkTheme
  //             ? SavedPreferences.update(isDarkTheme: false)
  //             : SavedPreferences.update(isDarkTheme: true);
  //       },
  //       child: Icon(
  //         Icons.brightness_6,
  //         color: CustomColors.background == DarkColors.background
  //             ? LightColors.background
  //             : DarkColors.background,
  //       ),
  //     ),
  //   );
  // }
}
