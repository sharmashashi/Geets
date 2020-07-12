import 'package:Geets/screens/Entry/ThemeProvider.dart';

class Globalvariables {
  Globalvariables.privateConstructor();
  static final Globalvariables instance = Globalvariables.privateConstructor();

  static ThemeProvider _themeProvider;
  static setThemeProvider(ThemeProvider provider) {
    _themeProvider = provider;
  }

  static ThemeProvider get themeProvider => _themeProvider;

  
}
