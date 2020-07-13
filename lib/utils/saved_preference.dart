import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedPreferences {
  static Future update({bool isDarkTheme, bool initSongTile}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (isDarkTheme != null) {
      _pref.setBool('isDarkTheme', isDarkTheme);
      isDarkTheme
          ? CustomColors.applyDarkTheme()
          : CustomColors.applyLightTheme();
      Globalvariables.themeProvider.notify();
    }
    if(initSongTile!=null){
      _pref.setBool('initSongTile', initSongTile);
    }
    return true;
  }

  static Future fetch({bool isDarkTheme,bool initSongTile}) async {
    var returnValue;
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (isDarkTheme != null) {
      returnValue = _pref.getBool('isDarkTheme');
    }
    else if(initSongTile!=null){
      returnValue=_pref.getBool('initSongTile');
    }
    return returnValue;
  }
}
