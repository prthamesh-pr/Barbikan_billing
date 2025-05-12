
import 'dart:convert';

import 'package:billing_web/features/dashboard/model/dash_board_model.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';

class DashBoardProvider extends ChangeNotifier{

   List<LowStockProducts> dashBoardList = [

  ];

   List<DashBoardModel> topDashBoardList=[];

  void initState() {

    getDashboardData();
  }


  /// Get Api ================
  Future <void> getDashboardData() async{

    await ApiUtil.getApi(
      url: ApiUrl.dashBoard,
      success: (source) {
        try {

          Map<String, dynamic> json = jsonDecode(source.body);
          var response = DashBoardModel.fromJson(json);
          dashBoardList.clear();
          if (response.data != null && response.data!.lowStockProducts != null) {
            dashBoardList.addAll(response.data!.lowStockProducts!);
            print('DashBoard list length: ${dashBoardList.length}');
          } else {
            print('No DashBoard found in response.');
          }
          topDashBoardList.clear();
          if (response.data != null) {
            topDashBoardList.add(response); // Add the entire DashBoardModel for the grid data
            print('Top DashBoard List Length: ${topDashBoardList.length}');
          } else {
            print('No Dashboard data found.');
          }
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