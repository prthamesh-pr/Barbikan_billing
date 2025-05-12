
import 'dart:convert';

import 'package:billing_web/features/party/purchase_party/model/purchase_party_addList_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/api_Utils.dart';
import '../../../utils/api_url.dart';
import '../../../utils/constants.dart';
import '../model/purchase_partList_model.dart';

class PurchasePartyListProvider extends ChangeNotifier{



  int? selectedPartyIndex;

  void setSelectedPartyIndex(int index) {
    selectedPartyIndex = index;
    notifyListeners();
  }

  bool showDetailView = false;
  int currentTab = 0;

  void setShowDetailView(bool value) {
    showDetailView = value;
    notifyListeners();
  }

  void setCurrentTab(int index) {
    currentTab = index;
    notifyListeners();
  }

  List<PurchaseParties> purchasePartyList = [];
  List<PurchasePartyAddListModel> listOfNewParty =[];

  bool isLoading = false;

  String userid='';
  setUserId(String id){
    userid=id;
    notifyListeners();
  }

  void loadUserData(PurchaseParties user) {
    companyNameController.text = user.companyName?? '';
    mobileController.text = user.mobileNumber?? '';
   partyNameController.text = user.partyName?? '';
   gstNumberController.text = user.gstNumber?? '';
   emailController.text = user.email?? '';
   billingAddressController.text =user.billingAddress?? '';
    billingCityNameController.text=user.billingCity?? '';
    alterNativeMobileController.text= user.alternateMobileNumber?? '';
    billingStateNameController.text= user.billingState?? '';
   categoryController.text= user.category?? '';
   openingBalanceController.text = user.openingBalance?? '';
    userid=user.id!;

    notifyListeners();
  }


  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController alterNativeMobileController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController partyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController billingAddressController = TextEditingController();
  final TextEditingController billingCityNameController = TextEditingController();
  final TextEditingController billingStateNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController openingBalanceController = TextEditingController();


  initState(){
    companyNameController.clear();
    mobileController.clear();
    alterNativeMobileController.clear();
    gstNumberController.clear();
    partyNameController.clear();
    emailController.clear();
    billingAddressController.clear();
    billingCityNameController.clear();
    billingStateNameController.clear();
    categoryController.clear();
    openingBalanceController.clear();
    getPurchaseParty();
  }



  /// Get Api ================
  Future <void> getPurchaseParty() async{
    print('sdfghjk${ApiUrl.purchaseParty}');
    await ApiUtil.getApi(
      url: ApiUrl.purchaseParty,
      success: (source) {
        try {

          Map<String, dynamic> json = jsonDecode(source.body);
          var response = PurchasePartyListModel.fromJson(json);
          purchasePartyList.clear();
          if (response.data != null && response.data!.purchaseParties != null) {
            purchasePartyList.addAll(response.data!.purchaseParties!);
            print('Purchase Party list length: ${purchasePartyList.length}');
          } else {
            print('No Purchase Party found in response.');
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


/// Post Api ================
  Future<void> newPurchaseParty({
    Function? success,
    Function? failure,

  }) async{
    Map<String, dynamic> body = {
      "company_name" : companyNameController.text,
      "mobile_number":mobileController.text,
      "party_name":partyNameController.text,
      "gst_number":gstNumberController.text,
      "email":emailController.text,
      "billing_address":billingAddressController.text,
      "billing_city":billingCityNameController.text,
      "alternate_mobile_number":alterNativeMobileController.text,
      "billing_state":billingStateNameController.text,
      "category":categoryController.text,
      "opening_balance":openingBalanceController.text.toString(),
    };
    print('body=======${body}');
    await ApiUtil.postApiWithBody(
        url: ApiUrl.addPurchaseParty,
        body: jsonEncode(body),

        success: (response)async {
          var json = jsonDecode(response);
          var newUsers = PurchasePartyAddListModel.fromJson(json);

          listOfNewParty.add(newUsers);
          await getPurchaseParty();
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

  ///put api=======
  Future putPurchasePartyUpdate({
    Function? success,
    Function? failure})

  async{
    var body={
      "company_name" : companyNameController.text,
      "mobile_number":mobileController.text,
      "party_name":partyNameController.text,
      "gst_number":gstNumberController.text,
      "email":emailController.text,
      "billing_address":billingAddressController.text,
      "billing_city":billingCityNameController.text,
      "alternate_mobile_number":alterNativeMobileController.text,
      "billing_state":billingStateNameController.text,
      "category":categoryController.text,
      "opening_balance":openingBalanceController.text.toString(),
    };
    if (kDebugMode) {
      print('apiUrl${ApiUrl.userUpdate(id: userid)}');
    }
    print('hereee=======${ApiUrl.purchasePartyUpdate(id: userid)}');
    await ApiUtil.postApiWithput(

      url:ApiUrl.purchasePartyUpdate(id: userid) ,

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


/// Delete Api ================
  Future<void> deletePurchaseParty(String id) async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token == null) {
      print('No token found!');
      return;
    }
    //print("${  'https://billing-backend-l9z5.onrender.com/api/companies/$id'}");
    try {
      final response = await dio.delete(
        'https://billing-backend-l9z5.onrender.com/api/purchase-parties/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Company deleted successfully');
        getPurchaseParty();
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