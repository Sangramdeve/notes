import 'package:flutter/widgets.dart';

class ThemeProvider with ChangeNotifier{
   bool _isDark = true;

  bool get isDark => _isDark;

  void toggleTheme(){
    _isDark = !isDark;
    notifyListeners();
  }
}