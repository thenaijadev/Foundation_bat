// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Screens extends ChangeNotifier {
  int currentTab = 0;
  

  void updateScreen(int tab) {
    this.currentTab = tab;
    notifyListeners();
  }

  
}
