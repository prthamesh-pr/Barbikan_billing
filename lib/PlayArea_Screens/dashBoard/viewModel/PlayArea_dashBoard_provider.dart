
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../features/utils/api_Utils.dart';
import '../../../features/utils/api_url.dart';
import '../../../features/utils/constants.dart';
import '../model/dashBoard_model.dart';

class PlayAreaDashBoardProvider extends ChangeNotifier{


List<TodayBookings> listOfGamesData = [];
List<Stats> listOfGames = [];

Stats? stats;

  /// Get Api ================
  Future <void> getGamesDashboardData() async{

    await ApiUtil.getApi(
      url: ApiUrl.playGroundDashBoard,
      success: (source) {
        try {

          Map<String, dynamic> json = jsonDecode(source.body);
          var response = PlayAreaDashBoardModel.fromJson(json);
          if (response.data != null && response.data!.stats != null) {
           stats = response.data!.stats!;
         // listOfGames.add(stats);// Removes nulls safely
          print('DashBoard Stats loaded');
        } else {
            stats = null;
            print('No stats found in response.');
          }

          if (response.data!.todayBookings != null) {
            listOfGamesData = response.data!.todayBookings!;
            print('Today Bookings loaded: ${listOfGamesData.length}');
          } else {
            listOfGamesData = [];
          }

        //  topDashBoardList.clear();
        //   if (response.data != null) {
        //     topDashBoardList.add(response); // Add the entire DashBoardModel for the grid data
        //     print('Top DashBoard List Length: ${topDashBoardList.length}');
        //   } else {
        //     print('No Dashboard data found.');
        //   }
          notifyListeners();
        }


        catch (e) {
          kPrintLog("Parsing error: $e");
        }
      },

      failure: (errorMessage) {
        kPrintLog("Failed to get user access: $errorMessage");
      },

    );
  }

  void initState() {
    getGamesDashboardData();
  }
}