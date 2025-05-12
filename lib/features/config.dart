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

  static const Map<String, int> gameRates = {
    'badminton': 600,
    'cricket': 800,
    'football': 1000,
    "tennis": 400,
  };


  // static const Map<String,dynamic> turfInfo = {
  //   'football': {
  //     'price':1000,
  //     'name': ["Football Turf 1","Football Turf 2"]
  //   },
  //   'cricket': {
  //     'price':800,
  //     'name': ["Football Turf 1","Football Turf 2"]
  //   },
  // };

  static int getRate(String gameName) {
    return gameRates[gameName.toLowerCase()] ?? 0;
  }

}
