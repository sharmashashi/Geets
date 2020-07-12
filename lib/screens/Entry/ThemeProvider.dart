import 'package:flutter/foundation.dart';

class ThemeProvider with ChangeNotifier {
  notify() {
    notifyListeners();
  }
}
