import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';

//final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//final BuildContext globalContext = navigatorKey.currentState!.context;

kPrintLog(message) => log(message ?? "");

Future<bool> kInternetCheck() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } on Exception catch (_) {
    return false;
  }
}

EdgeInsets kPadding = EdgeInsets.symmetric(horizontal: 15, vertical:10);

const floatingLabelTextFlag = false;
const floatingLabelDropDownFlag = false;
