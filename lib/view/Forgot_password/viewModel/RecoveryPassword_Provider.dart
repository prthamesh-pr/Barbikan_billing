import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../forgotPassword_screen.dart';

class RecoveryPasswordProvider extends ChangeNotifier{
  TextEditingController recoveryEmailController = TextEditingController();
  String? recoveryEmailError;

  bool validateRecoveryEmail() {
    String value = recoveryEmailController.text.trim();
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);

    if (value.isEmpty) {
      recoveryEmailError = "Email is required";
    } else if (!regex.hasMatch(value)) {
      recoveryEmailError = "Enter a valid email address";
    } else {
      recoveryEmailError = null;
    }

    notifyListeners();
    return recoveryEmailError == null;
  }

}