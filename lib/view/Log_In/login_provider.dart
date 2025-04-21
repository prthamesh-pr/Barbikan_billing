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


  void validEmail(String value) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);

    if (value.isEmpty) {
      emailError = "Email is required";
    } else if (!regex.hasMatch(value)) {
      emailError = "Enter a valid email address";
    } else {
      emailError = null;
    }
    notifyListeners();
  }


}