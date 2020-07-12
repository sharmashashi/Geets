import 'package:Geets/screens/Entry/ThemeProvider.dart';
import 'package:Geets/utils/colors.dart';

class Globalvariables {
  Globalvariables.privateConstructor();
  static final Globalvariables instance = Globalvariables.privateConstructor();

  static ThemeProvider _themeProvider;
  static setThemeProvider(ThemeProvider provider) {
    _themeProvider = provider;
  }

  static ThemeProvider get themeProvider => _themeProvider;

  
}
