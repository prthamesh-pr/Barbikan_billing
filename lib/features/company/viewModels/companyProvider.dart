
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/add_new_compny_model.dart';
import '../model/listOf_Company_modal.dart';

class CompanyProvider extends ChangeNotifier{

   List<Company> companyList = [];
   List<Companies> listOfCompany = [];

   bool isLoading=false;

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
    // getCompanyList();
     newCompany();
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

   ///Delete api============

   // Future<void> deleteCompany()async{
   //
   //   await ApiUtil().delete(
   //       url: ApiUrl.,
   //       data: data,
   //       success: success,
   //       failure: failure)
   // }
}