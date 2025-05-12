
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../features/utils/api_Utils.dart';
import '../../../features/utils/api_url.dart';
import '../../model/playAreaModel.dart';

class BadmintonProvider extends ChangeNotifier{

  List<Booking> listOfGames = [];

  bool  isLoading = false;

  String? _selectedCourt;
  String selectedSport = "Badminton";


  String? get selectedCourt => _selectedCourt;

  void setSelectedCourt(String? value) {
    _selectedCourt = value;
    notifyListeners();
  }


  String totalDuration = "0 hr";
  String totalPrice = "0";

  void calculateDurationAndPrice() {
    try {
      final format = DateFormat("HH:mm");
      final start = format.parse(startTimeController.text);
      final end = format.parse(endTimeController.text);
      final diff = end.difference(start);

      if (diff.inMinutes <= 0) {
        totalDuration = "0 hr";
        totalPrice = "0";
      } else {
        final hours = diff.inHours;
        final minutes = diff.inMinutes.remainder(60);

        final durationStr = minutes > 0 ? "$hours hr $minutes min" : "$hours hr";
        totalDuration = durationStr;

        final ratePerHour = 600;
        final totalHours = diff.inMinutes / 60;
        final price = (ratePerHour * totalHours).ceil();
        totalPrice = price.toString();
      }
    } catch (e) {
      totalDuration = "Invalid";
      totalPrice = "0";
    }

    notifyListeners();
  }

//TextEditingController sportNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
 // TextEditingController turfNameController = TextEditingController();

  /// Post Api ================
  Future<void> badminton({
    Function? success,
    Function? failure,

  }) async{
    Map<String, dynamic> body = {
      "sport" : selectedSport,
      "user_name":userNameController.text,
      "date":dateController.text,
      "start_time":startTimeController.text,
      "end_time":endTimeController.text,
      "user_email":emailController.text,
      "user_phone":mobileController.text,
      "turf_name": selectedCourt ?? "",


    };
    print('body=======${body}');
    await ApiUtil.postApiWithBody(
        url: ApiUrl.playGround,
        body: jsonEncode(body),

        success: (response)async {
          var json = jsonDecode(response);
          var newUsers = PlayAreaModel.fromJson(json);

          if (newUsers.data?.booking != null) {
            listOfGames.add(newUsers.data!.booking!);
          }
          // await getPurchaseParty();
        //  listOfGames.add(response);
          notifyListeners();
          isLoading ;
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

  void initState() {
    // sportNameController.clear();
    mobileController.clear();
    dateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    userNameController.clear();
    emailController.clear();
  }

}