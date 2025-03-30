import 'package:flutter/material.dart';

class SideBarConfig with ChangeNotifier {
  int _currentIndex = 0;
  String _tcurrentitle = "Dashboard";

  get currentIndex => _currentIndex;
  get currentTitle => _tcurrentitle;

  changeIndex(int index, String title) {
    _currentIndex = index;
    _tcurrentitle = title;
    notifyListeners();
  }
}
