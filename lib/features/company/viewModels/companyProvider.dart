
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/add_new_compny_model.dart';
import '../model/listOf_Company_modal.dart';

class CompanyProvider extends ChangeNotifier{

   List<Company> companyList = [];
   List<Companies> listOfCompany = [];

   bool isLoading=false;

   String userid='';
   setUserId(String id){
     userid=id;
     notifyListeners();
   }

   void loadUserData(Companies user) {
     companyNameController.text = user.companyName ?? '';
     mobileController.text = user.mobileNumber ?? '';
     userid=user.id!;
     gstNumberController.clear();
     fssaiNumberController.clear();
     emailController.clear();
     billPrefixController.clear();
     billingAddressController.clear();
     cityNameController.clear();
     stateNameController.clear();
     bankNameController.clear();
     accountNumberController.clear();
     ifscCodeController.clear();
     upiNumberController.clear();
     // accType = user.accountType ?? 'staff';
     notifyListeners();
   }

   final TextEditingController companyNameController = TextEditingController();
   final TextEditingController mobileController = TextEditingController();
   final TextEditingController gstNumberController = TextEditingController();
   final TextEditingController fssaiNumberController = TextEditingController();
   final TextEditingController emailController = TextEditingController();
   final TextEditingController billPrefixController = TextEditingController();
   final TextEditingController billingAddressController = TextEditingController();
   final TextEditingController cityNameController = TextEditingController();
   final TextEditingController stateNameController = TextEditingController();
   final TextEditingController bankNameController = TextEditingController();
   final TextEditingController accountNumberController = TextEditingController();
   final TextEditingController ifscCodeController = TextEditingController();
   final TextEditingController upiNumberController = TextEditingController();

   initState(){
     companyNameController.clear();
     mobileController.clear();
     gstNumberController.clear();
     fssaiNumberController.clear();
     emailController.clear();
     billPrefixController.clear();
     billingAddressController.clear();
     cityNameController.clear();
     stateNameController.clear();
     bankNameController.clear();
     accountNumberController.clear();
     ifscCodeController.clear();
     upiNumberController.clear();
     getCompanyList();

   }

///post api================
  Future<void> newCompany({
    Function? success,
    Function? failure,
    //  required BuildContext context,
  }) async{
    Map<String, dynamic> body = {
      "company_name" : companyNameController.text,
      "mobile_number":mobileController.text,
      "gst_number":gstNumberController.text,
      "fssai_number":fssaiNumberController.text,
      "email":emailController.text,
      "bill_prefix":billPrefixController.text,
      "billing_address":billingAddressController.text,
      "city":cityNameController.text,
      "state":stateNameController.text,
      "bank_name":bankNameController.text,
      "account_number":accountNumberController.text,
      "ifsc_code":ifscCodeController.text,
      "upi_number":upiNumberController.text,
    };
    await ApiUtil.postApiWithBody(
        url: ApiUrl.addCompany,
        body: jsonEncode(body),

        success: (response)async {
          var json = jsonDecode(response);
          var newUsers = AddNewCompanyModel.fromJson(json);
          print('object${response}');
          final company = newUsers.data?.company;
          if (company != null) {
            companyList.add(company);
          }
          await getCompanyList();
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

  ///get api===============
   Future<void> getCompanyList() async {
     isLoading=true;
     notifyListeners();
     await ApiUtil.getApi(
       url: ApiUrl.addCompany,
       success: (source) {
         try {

           Map<String, dynamic> json = jsonDecode(source.body);
           var response = listOfCompanyModel.fromJson(json);
           listOfCompany.clear();
           if (response.data != null && response.data!.companies != null) {
             listOfCompany.addAll(response.data!.companies!);
             print('Company list length: ${listOfCompany.length}');
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




   Future putCompanyUpdate({
     Function? success,
     Function? failure})

   async{

     var body={
       //"id": controller., // make sure you have this stored or passed
       "company_name" : companyNameController.text.trim(),
       "mobile_number":mobileController.text.trim(),
       "gst_number":gstNumberController.text.trim(),
       "fssai_number":fssaiNumberController.text.trim(),
       "email":emailController.text.trim(),
       "bill_prefix":billPrefixController.text.trim(),
       "billing_address":billingAddressController.text.trim(),
       "city":cityNameController.text.trim(),
       "state":stateNameController.text.trim(),
       "bank_name":bankNameController.text.trim(),
       "account_number":accountNumberController.text.trim(),
       "ifsc_code":ifscCodeController.text.trim(),
       "upi_number":upiNumberController.text.trim(),
     };

     await ApiUtil.postApiWithput(
       url:ApiUrl.compnayUpdate(id: userid) ,
       body: jsonEncode(body),

       success: (source) async {
         print(" Response: $source");
         return success!();
       },
       failure: (errorMessage){
         print('failuresss $errorMessage');
         notifyListeners();
         return failure!(errorMessage);
       },

     );
   }


   ///Delete api============
   Future<void> deleteCompany(String id) async {
     final Dio dio = Dio();
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? token = prefs.getString('jwt_token');

     if (token == null) {
       print('No token found!');
       return;
     }
print("${  'https://billing-backend-l9z5.onrender.com/api/companies/$id'}");
     try {
       final response = await dio.delete(
         'https://billing-backend-l9z5.onrender.com/api/companies/$id',
         options: Options(
           headers: {
             'Authorization': 'Bearer $token',
             'Content-Type': 'application/json',
           },
         ),
       );

       if (response.statusCode == 200) {
         print('Company deleted successfully');
         getCompanyList();
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