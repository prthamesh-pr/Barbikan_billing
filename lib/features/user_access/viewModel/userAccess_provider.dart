
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/new_user_model.dart';
import '../model/userAccess_model.dart';

class UserAccessProvider extends ChangeNotifier{

  List<NewUsersModel> listOfNewUsers =[];
  List<Message> userAccessList = [];

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController accTypeController = TextEditingController();



  void loadUserData(Message user) {
    usernameController.text = user.username ?? '';
    mobileController.text = user.mobileNumber ?? '';
    userid=user.id!;
    passwordController.clear();
    rePasswordController.clear();
    accType = user.accountType ?? 'staff';
    notifyListeners();
  }

  String? accType = "admin";

  List<dynamic> users = [];

bool isLoading=false;
   initState() {
     isLoading=false;
      getUserAccess();
     usernameController.clear();
     mobileController.clear();
     passwordController.clear();
     rePasswordController.clear();

  }


/// Get api===========
  Future<void> getUserAccess() async {

    isLoading=true;
    notifyListeners();
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
            isLoading=false;
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

String userid='';
   setUserId(String id){
     userid=id;
     notifyListeners();
   }

///put api=======
  Future PutUsersUpdate({
  Function? success,
  Function? failure})

  async{
    if (userid.isEmpty) {
      return failure?.call("User ID is missing");
    }
     if(passwordController.text.isEmpty){
       return "Please Enter Password";
     }

var body={
  //"id": controller., // make sure you have this stored or passed
  "username": usernameController.text.trim(),
  "phone": mobileController.text.trim(),
  "password": passwordController.text.trim(),
  "account_type": accType ?? "admin",
};
if (kDebugMode) {
  print('apiUrl${ApiUrl.userUpdate(id: userid)}');
}
    await ApiUtil.postApiWithput(
      url:ApiUrl.userUpdate(id: userid) ,
      body: jsonEncode(body),

         success: (source) async {
           print(" Response: ${source}");
           return success!();
         },
         failure: (errorMessage){
           print('failuresss $errorMessage');
           notifyListeners();
           return failure!(errorMessage);
},

     );
  }

  /// Post api==========
  Future<void> newUsers({
    Function? success,
    Function? failure,
  //  required BuildContext context,
  }) async{
    Map<String, dynamic> body = {
      "username" : usernameController.text,
      "mobile_number":mobileController.text,
      "password":passwordController.text,
    "account_type":accType ?? "staff",
    };
    await ApiUtil.postApiWithBody(
        url: ApiUrl.userAccess,
      body: jsonEncode(body),

    success: (response)async {
      var json = jsonDecode(response);
    var newUsers = NewUsersModel.fromJson(json);
      print("Selected role: $accType");
    listOfNewUsers.add(newUsers);
      await getUserAccess();
    notifyListeners();
    isLoading = false;
    if(success != null){
    return success();
    }

    },
    failure: (message){
          if( failure != null){
            isLoading = false;
            return failure(message);
        }
        });
  }

  /// Delete api==========
  Future<void> deleteUsers(String id) async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token == null) {
      print('No token found!');
      return;
    }
    print('https://billing-backend-l9z5.onrender.com/api/users/$id');
    try {
      final response = await dio.delete(
        'https://billing-backend-l9z5.onrender.com/api/users/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Company deleted successfully');
        getUserAccess();
      } else {
        print('Failed to delete company: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} ${e.response?.data}');
    } catch (e) {
      print('Error: $e');
    }
  }
}


