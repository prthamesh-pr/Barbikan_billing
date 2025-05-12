
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/add_category_model.dart';
import '../model/category_list_model.dart';

class CategoryProvider extends ChangeNotifier{

  List<Categories> listOfCategory = [];
  List<AddCategoryListModel> listOfAddCategory = [];


  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController noOfProductController = TextEditingController();


  bool  isLoading=true;

  String userid='';
  setUserId(String id){
    userid=id;
    notifyListeners();
  }

  void loadUserData(Categories user) {
    categoryNameController.text = user.categoryName?? '';
    noOfProductController.text = user.noOfProducts.toString()?? '';
    userid=user.id!;
    notifyListeners();
  }


  void initState() {
    categoryNameController.clear();
    noOfProductController.clear();

    getCategoryList();

  }

  ///Post api===============
  Future<void> newCategory({
    Function? success,
    Function? failure,
    //  required BuildContext context,
  }) async{
    Map<String, dynamic> body = {
      "category_name" : categoryNameController.text,
      "no_of_products":noOfProductController.text,
    };
    await ApiUtil.postApiWithBody(
        url: ApiUrl.category,
        body: jsonEncode(body),

        success: (response)async {
          var json = jsonDecode(response);
          var newUsers = AddCategoryListModel.fromJson(json);
          print('object${response}');
          listOfAddCategory.add(newUsers);
          await getCategoryList();
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
  Future<void> getCategoryList() async {
    isLoading=true;
    notifyListeners();
    await ApiUtil.getApi(
      url: ApiUrl.category,
      success: (source) {
        try {

          Map<String, dynamic> json = jsonDecode(source.body);
          var response = CategoryListModel.fromJson(json);
          listOfCategory.clear();
          if (response.data != null && response.data!.categories != null) {
            listOfCategory.addAll(response.data!.categories!);
            print('Company list length: ${listOfCategory.length}');
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


  ///put api=======
  Future putPurchasePartyUpdate({
    Function? success,
    Function? failure})

  async{

    var  body = {
      "category_name" : categoryNameController.text,
      "no_of_products":noOfProductController.text,
    };
    if (kDebugMode) {
    }
    await ApiUtil.postApiWithput(
      url:ApiUrl.categoryUpdate(id: userid) ,
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



///Delete api===============
  Future<void> deleteCategory(String id) async {
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
        'https://billing-backend-l9z5.onrender.com/api/categories/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Company deleted successfully');
        getCategoryList();
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