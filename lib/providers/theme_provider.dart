// ignore_for_file: prefer_const_constructors

import 'package:batnf/constants/color_constant.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}


class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: kBackground,
    colorScheme: ColorScheme.dark(),
    primaryColor: kTitleheaderColor1,
    hintColor: kGeneralbodytextColor,
    iconTheme: IconThemeData(color: kBackground, opacity: 0.8),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: kGeneralbodytextColor,
    colorScheme: ColorScheme.light(),
    hintColor: kBackground,
    primaryColor: kTitleheaderColor,
    iconTheme: IconThemeData(color: kGeneralbodytextColor, opacity: 0.8),
  );
}
