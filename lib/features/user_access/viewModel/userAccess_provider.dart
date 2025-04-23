
import 'dart:convert';

import 'package:billing_web/features/utils/api_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/constants.dart';
import '../../utils/api_Utils.dart';
import '../model/userAccess_model.dart';

class UserAccessProvider extends ChangeNotifier{

  List<Message> userAccessList = [];
bool isLoading=false;
   initState() {
     isLoading=false;
      getUserAccess();

  }

  Future<void> getUserAccess() async {
    isLoading=true;
    await ApiUtil.getApi(
      url: ApiUrl.userAccess,
      success: (source) {
        try {
          print('Raw API Response: ${source.body}');

          Map<String, dynamic> json = jsonDecode(source.body);
          print('API Response: $source');
          var response = UserAndAccessModel.fromJson(json);
          print('Calling API: ${ApiUrl.userAccess}');
          print('response=====>>> ${source.body}');
          print('Fetched Users Count: ${response.success}');

          // Assuming 'data' contains a 'users' list
          if (response.data != null && response.data['users'] != null) {
            List<Message> userList = [];
            response.data['users'].forEach((user) {
              userList.add(Message.fromJson(user));
            });

            userAccessList.clear();
            userAccessList.addAll(userList);
            isLoading=false;// Add the list of users to your list
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