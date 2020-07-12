import 'package:Geets/utils/colors.dart';
import 'package:Geets/utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedPreferences {
  static update(bool isDarkTheme) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (isDarkTheme != null) {
      _pref.setBool('isDarkTheme', isDarkTheme);
      isDarkTheme
          ? CustomColors.applyDarkTheme()
          : CustomColors.applyLightTheme();
      Globalvariables.themeProvider.notify();
    }
  }

  static Future fetch(bool isDarkTheme) async {
    var returnValue;
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (isDarkTheme != null) {
      returnValue = _pref.getBool('isDarkTheme');
    }
    return returnValue;
  }
}
