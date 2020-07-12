import 'package:Geets/screens/Entry/ThemeProvider.dart';
import 'package:Geets/screens/home/home.dart';
import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/global_variables.dart';
import 'package:Geets/utils/saved_preference.dart';
import 'package:Geets/utils/screen_dimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryPoint extends StatefulWidget {
  @override
  _EntryPointState createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: Builder(
        builder: (context) {
          //
          ThemeProvider _themeProvider = Provider.of<ThemeProvider>(context);
          SavedPreferences.update(
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? true
                  : false);
          return Scaffold(
            backgroundColor: CustomColors.background,
              appBar: PreferredSize(
                preferredSize: Size.zero,
                child: Container(
                  color: CustomColors.background,
                ),
              ),
              body: Builder(
                builder: (context) {
                  //set screen size
                  ScreenDimension.init(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width);
                  Globalvariables.setThemeProvider(_themeProvider);
                  return Home();
                },
              ),
            
          );
        },
      ),
    );
  }
}
