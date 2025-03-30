import 'package:flutter/material.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

CreationPageConfig creationPageConfig = CreationPageConfig();

class CreationPageConfig with ChangeNotifier {
  Widget? _tcurrenPage;

  get currenPage => _tcurrenPage;

  changePage(Widget page) {
    _tcurrenPage = page;
    notifyListeners();
  }
}
