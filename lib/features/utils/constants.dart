import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

//final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//final BuildContext globalContext = navigatorKey.currentState!.context;

kPrintLog(message) => log(message ?? "");

Future<bool> kInternetCheck() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
  return true;
// } on Exception catch (_) {
//     return false;
//   }
}

EdgeInsets kPadding = EdgeInsets.symmetric(horizontal: 15, vertical:10);

const floatingLabelTextFlag = false;
const floatingLabelDropDownFlag = false;
