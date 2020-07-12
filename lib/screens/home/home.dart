import 'package:Geets/screens/home/home_provider.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/saved_preference.dart';
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
                ///
                Positioned(
                  top: 10 +
                      ScreenDimension.percent(percent: 3.4, isHeight: true),
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.background,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 2,
                              offset: Offset(1, 1),
                              color: CustomColors.lowerRightShadow),
                          BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 2,
                              offset: Offset(-1, -1),
                              color: CustomColors.upperLeftShadow),
                        ]),
                    child: GestureDetector(
                      onTap: () async {
                        bool darkTheme =
                            await SavedPreferences.fetch(isDarkTheme: true);
                        darkTheme
                            ? SavedPreferences.update(isDarkTheme: false)
                            : SavedPreferences.update(isDarkTheme: true);
                      },
                      child: Icon(
                        Icons.brightness_6,
                        color: CustomColors.background == DarkColors.background
                            ? LightColors.background
                            : DarkColors.background,
                      ),
                    ),
                  ),
                )

                ///
              ],
            ),
          );
        },
      ),
    );
  }
}
