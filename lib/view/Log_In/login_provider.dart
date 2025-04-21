import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();


  String img = 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg';
  String google= 'https://img.freepik.com/premium-vector/google-logo-icon-set-google-icon-searching-icons-vector_981536-454.jpg?w=1060';


  bool isPasswordVisible = false;

  void PasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  String? emailError;
  String? passwordError;

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError = "Password is required";
    } else if (value.length < 8) {
      passwordError = "Password must be at least 8 characters";
    } else {
      passwordError = null;
    }
    notifyListeners();
  }


  void validateEmailOrPhone(String value) {
    if (value.isEmpty) {
      emailError = "Email or Mobile Number is required";
    } else if (_looksLikeEmail(value)) {
      if (!_isValidEmail(value)) {
        emailError = "Please enter a valid email address";
      } else {
        emailError = null;
      }
    } else if (_looksLikePhone(value)) {
      if (!_isValidPhone(value)) {
        emailError = "Please enter a valid mobile number";
      } else {
        emailError = null;
      }
    } else {
      emailError = "Enter a valid email or mobile number";
    }

    notifyListeners();
  }

  bool _isValidEmail(value) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value);
  }
  bool _isValidPhone(value) {
    return value.length == 10 && RegExp(r'^\d{10}$').hasMatch(value);
  }

  bool _looksLikeEmail(String value) {
    return value.contains('@');
  }

  bool _looksLikePhone(String value) {
    return RegExp(r'^\d+$').hasMatch(value); // just digits
  }
}