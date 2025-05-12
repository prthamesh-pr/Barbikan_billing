
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/api_Utils.dart';
import '../../../utils/api_url.dart';
import '../../../utils/constants.dart';
import '../model/addCustomerList_model.dart';
import '../model/customer_list_model.dart';

class CustomerProvider extends ChangeNotifier{


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

 bool  isLoading=true;

 List<Customers> listOfCustomer=[];
 List<AddCustomerListModel> addCustomerList = [];

  String userid='';
  setUserId(String id){
    userid=id;
    notifyListeners();
  }

  void loadUserData(Customers user) {
    companyNameController.text = user.companyName?? '';
    partyNameController.text = user.partyName?? '';
    phoneController.text = user.phone?? '';
    gstNumberController.text = user.gstNumber?? '';
    emailController.text = user.email?? '';
    billingAddressController.text =user.billingAddress?? '';
    billingCityNameController.text=user.billingCity?? '';
    alterNativeMobileController.text= user.altPhone?? '';
    billingStateNameController.text= user.billingState?? '';
    categoryController.text= user.creditCategory?? '';
    openingBalanceController.text = user.openingBalance?? '';
    userid=user.id!;

    notifyListeners();
  }

 final TextEditingController companyNameController = TextEditingController();
 final TextEditingController phoneController = TextEditingController();
 final TextEditingController alterNativeMobileController = TextEditingController();
 final TextEditingController gstNumberController = TextEditingController();
 final TextEditingController partyNameController = TextEditingController();
 final TextEditingController emailController = TextEditingController();
 final TextEditingController billingAddressController = TextEditingController();
 final TextEditingController billingCityNameController = TextEditingController();
 final TextEditingController billingStateNameController = TextEditingController();
 final TextEditingController categoryController = TextEditingController();
 final TextEditingController openingBalanceController = TextEditingController();
 final TextEditingController shippingAddressController = TextEditingController();
 final TextEditingController shippingCityNameController = TextEditingController();
 final TextEditingController shippingStateNameController = TextEditingController();
 final TextEditingController openingDateController = TextEditingController();

 void initState() {
   companyNameController.clear();
   phoneController.clear();
   alterNativeMobileController.clear();
   gstNumberController.clear();
   partyNameController.clear();
   emailController.clear();
   billingAddressController.clear();
   billingCityNameController.clear();
   billingStateNameController.clear();
   categoryController.clear();
   openingBalanceController.clear();
   shippingAddressController.clear();
   shippingCityNameController.clear();
   shippingStateNameController.clear();
   openingDateController.clear();
   getCustomerList();
 }

  ///post api================
 Future<void> newCustomer({
   Function? success,
   Function? failure,

 }) async{
   Map<String, dynamic> body = {
     "company_name" : companyNameController.text,
     "mobile_number":phoneController.text,
     "party_name":partyNameController.text,
     "gst_number":gstNumberController.text,
     "email":emailController.text,
     "billing_address":billingAddressController.text,
     "billing_city":billingCityNameController.text,
     "alternate_mobile_number":alterNativeMobileController.text,
     "billing_state":billingStateNameController.text,
     "category":categoryController.text,
     "opening_balance":openingBalanceController.text,
     "shipping_address":shippingAddressController.text,
     "shipping_city":shippingCityNameController.text,
     "shipping_state":shippingStateNameController.text,
     "opening_date":openingDateController.text,
   };
   print('body=======${body}');
   await ApiUtil.postApiWithBody(
       url: ApiUrl.customers,
       body: jsonEncode(body),

       success: (response)async {
         var json = jsonDecode(response);
         var newUsers = AddCustomerListModel.fromJson(json);

         addCustomerList.add(newUsers);
         await getCustomerList();
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
  Future putCustomerUpdate({
    Function? success,
    Function? failure})
  async{

    var body = {
      "company_name" : companyNameController.text,
      "mobile_number":phoneController.text,
      "party_name":partyNameController.text,
      "gst_number":gstNumberController.text,
      "email":emailController.text,
      "billing_address":billingAddressController.text,
      "billing_city":billingCityNameController.text,
      "alternate_mobile_number":alterNativeMobileController.text,
      "billing_state":billingStateNameController.text,
      "category":categoryController.text,
      "opening_balance":openingBalanceController.text,
      "shipping_address":shippingAddressController.text,
      "shipping_city":shippingCityNameController.text,
      "shipping_state":shippingStateNameController.text,
      "opening_date":openingDateController.text,
    };

    if (kDebugMode) {
      print('apiUrl${ApiUrl.userUpdate(id: userid)}');
    }
    await ApiUtil.postApiWithput(
      url:ApiUrl.customersUpdate(id: userid) ,
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


  ///Get api================
  Future<void> getCustomerList() async {
    isLoading=true;
    notifyListeners();
    await ApiUtil.getApi(
      url: ApiUrl.customers,
      success: (source) {
        try {

          Map<String, dynamic> json = jsonDecode(source.body);
          var response = CustomerListModel.fromJson(json);
          listOfCustomer.clear();
          if (response.data != null && response.data!.customers != null) {
            listOfCustomer.addAll(response.data!.customers!);
            print('Company list length: ${listOfCustomer.length}');
          } else {
            print('No companies found in response.');
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



  ///Delete api================
 Future<void> deleteCustomer(String id) async {
   final Dio dio = Dio();
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? token = prefs.getString('jwt_token');

   if (token == null) {
     print('No token found!');
     return;
   }
   try {
     final response = await dio.delete(
       'https://billing-backend-l9z5.onrender.com/api/customers/$id',
       options: Options(
         headers: {
           'Authorization': 'Bearer $token',
           'Content-Type': 'application/json',
         },
       ),
     );

     if (response.statusCode == 200) {
       print('Company deleted successfully');
       getCustomerList();
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