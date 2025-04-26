import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/userAccess_model.dart';

class UserAccessProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  void loadUserData(Message user) {
    usernameController.text = user.username ?? '';
    mobileController.text = user.mobileNumber ?? '';
    passwordController.clear();
    rePasswordController.clear();
    accType = user.accountType ?? 'staff';
    notifyListeners();
  }

  String? accType = "staff";
  List<Message> userAccessList = [];
  bool isLoading = false;
  initState() {
    isLoading = false;
    getUserAccess();
  }

  Future<void> getUserAccess() async {
    isLoading = true;
    await ApiUtil.getApi(
      url: ApiUrl.userAccess,
      success: (source) {
        try {
          Map<String, dynamic> json = jsonDecode(source.body);

          var response = UserAndAccessModel.fromJson(json);
          // Assuming 'data' contains a 'users' list
          if (response.data != null && response.data['users'] != null) {
            List<Message> userList = [];
            response.data['users'].forEach((user) {
              userList.add(Message.fromJson(user));
            });

            userAccessList.clear();
            userAccessList.addAll(userList);
            isLoading = false; // Add the list of users to your list
          }

          // Notify listeners after updating the data
          notifyListeners();
        } catch (e) {
          kPrintLog("Parsing error: $e");
        }
      },
      failure: (errorMessage) {
        kPrintLog("Failed to get user access: $errorMessage");
      },
    );
  }
}
