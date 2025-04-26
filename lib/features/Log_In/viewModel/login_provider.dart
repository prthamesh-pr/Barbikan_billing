import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../landing_view.dart';
import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/network_util.dart';
import '../model/loginCredential.dart';
import '../view/login_screen.dart';

class LoginProvider extends ChangeNotifier{

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();


  String img = 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg';
  String google= 'https://img.freepik.com/premium-vector/google-logo-icon-set-google-icon-searching-icons-vector_981536-454.jpg?w=1060';


  bool isPasswordVisible = false;

  LoginCredentialModel? loginCredential;
  String? errorMessage;


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

  void clearErrorMessage() {
    errorMessage = null;
    notifyListeners();
  }



  initState(context)  async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('isLogin');
    if(isLogin==true){
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => LandingView()),
      );
    }
  }


  Future<void> loggedIn({
    Function? success,
    Function? failure,
    required BuildContext context,
  }) async {
    bool isConnected = await checkInternet();
    if (!isConnected) {
      errorMessage = "No internet connection.";
      notifyListeners();
      if (failure != null) failure(errorMessage);
      return;
    }
    Map<String, dynamic> body = {
      "mobile_number": emailController.text,
      "password": passController.text,
    };

    await ApiUtil.postApiWithBody(
      url: ApiUrl.login,
      body: jsonEncode(body),
      success: (response)async {
        var json = jsonDecode(response);
        var loginData = LoginCredentialModel.fromJson(json);

        if (loginData.success!) {
          var token = loginData.data?.token;
          var user = loginData.data?.user;

          if (token != null && token.isNotEmpty) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('jwt_token', token);
            await prefs.setBool('isLogin', true);

          }
          loginCredential = loginData;
          errorMessage = null; // clear old errors
          notifyListeners();
          if (success != null) success();
        } else {
          errorMessage = loginData.message ?? 'Login failed';
          notifyListeners();
          if (failure != null) {
            failure(loginData.message);
          }
        }
      },
      failure: (message) {
        errorMessage = message ?? 'Something went wrong';
        notifyListeners();
          print("API failure triggered with message: $message");

        if (failure != null) failure(message);
      },


    );
  }

}
