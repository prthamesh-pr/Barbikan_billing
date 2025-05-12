
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../category/model/add_category_model.dart';
import '../../category/model/category_list_model.dart';
import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/add_products_model.dart';
import '../model/products_model.dart';

class ProductsProvider extends ChangeNotifier{

  bool  isLoading=false;
  List<Products> listOfProducts =[];
  List<AddProductsMode> listOfAddProducts =[];


  List<String> listOfCategoryNames = [];
  Map<dynamic, String> categoryNameToIdMap = {};

  List<Categories> listOfCategory = [];
  List<AddCategoryListModel> listOfAddCategory = [];

  String? selectedCategory;
  String? selectedProduct;

  String userid='';
  setUserId(String id){
    userid=id;
    notifyListeners();
  }

  void loadUserData(Products user) {
    productNameController.text = user.productName?? '';
    openingStockController.text = user.openingStock.toString()?? '';
    minStockController.text = user.minStock.toString()?? '';
    categoryNameController.text = user.category.toString()?? '';
    userid=user.id!;

    notifyListeners();
  }

  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController openingStockController = TextEditingController();
  final TextEditingController minStockController = TextEditingController();

  void initState() async{
    categoryNameController.clear();
    productNameController.clear();
    openingStockController.clear();
    minStockController.clear();

    await getProductList();
  }
  ///Post api===============
  Future<void> newProduct({
    Function? success,
    Function? failure,
  }) async {
    isLoading = true;
    notifyListeners();

    Map<String, dynamic> body = {
      "category_name": categoryNameController.text,
      "product_name": productNameController.text,
      "opening_stock": openingStockController.text,
      "min_stock": minStockController.text,
    };
    print('object========= $body');

    await ApiUtil.postApiWithBody(
      url: ApiUrl.products,
      body: jsonEncode(body),
      success: (response) async {
        try {
          var json = jsonDecode(response);
          var newUsers = AddProductsMode.fromJson(json);
          print('API response:product===== $response');
          listOfAddProducts.add(newUsers);
          await getProductList();

          if (success != null) success();
          print('API Success Response: $response');

        } catch (e) {
          print("Error parsing response: $e");
          if (failure != null) failure("Parsing error");
        } finally {
          isLoading = false;
          notifyListeners();
        }
      },
      failure: (message) {
        print("API failure: $message");
        if (failure != null) failure(message);
        isLoading = false;
        notifyListeners();
      },
    );
  }

  ///get api===============
  // Future<void> getCategoryList() async {
  //   isLoading=true;
  //   notifyListeners();
  //   await ApiUtil.getApi(
  //     url: ApiUrl.products,
  //     success: (source) {
  //       try {
  //
  //         Map<String, dynamic> json = jsonDecode(source.body);
  //         var response = ProductsModel.fromJson(json);
  //         listOfProducts.clear();
  //         if (response.data != null && response.data!.products != null) {
  //           listOfProducts.addAll(response.data!.products!);
  //           print('products  list length: ${listOfProducts.length}');
  //
  //         } else {
  //           print('No companies found in response.');
  //         }
  //         notifyListeners();
  //       } catch (e) {
  //         kPrintLog("Parsing error: $e");
  //       }
  //     },
  //     failure: (errorMessage) {
  //       kPrintLog("Failed to get user access: $errorMessage");
  //     },
  //
  //   );
  //
  // }

  Future<void> getProductList() async {
    isLoading = true;
    notifyListeners();

    await ApiUtil.getApi(
      url: ApiUrl.products,
      success: (source) {
        try {
          Map<String, dynamic> json = jsonDecode(source.body);
          print('RAW JSON: ${source.body}');

          var response = ProductsModel.fromJson(json);

          listOfProducts.clear();
          listOfCategoryNames.clear();
          categoryNameToIdMap.clear();

          if (response.data != null && response.data!.products != null) {
            listOfProducts.addAll(response.data!.products!);
            print('products list length: ${listOfProducts.length}');
            for (var product in listOfProducts) {
              if (product.category?.categoryName!= null && product.categoryId != null) {
                if (!listOfCategoryNames.contains(product.category?.categoryName!)) {
                  listOfCategoryNames.add(product.category!.categoryName!);
                  categoryNameToIdMap[product.category!.categoryName!] = product.categoryId!;
                }
              }
            }

            print('Loaded ${listOfCategoryNames.length} unique category names');
            if (listOfCategoryNames.isNotEmpty) {
              selectedCategory = listOfCategoryNames[0]; // Set default selected category
            }
          } else {
            print('No products found in response.');
          }

          notifyListeners();
        } catch (e) {
          kPrintLog("Parsing error: $e");
        }
      },
      failure: (errorMessage) {
        kPrintLog("Failed to get products: $errorMessage");
      },
    );
  }



  ///put api=======
  Future putProductsUpdate({
    Function? success,
    Function? failure})
  async{
    var body = {
      "category_name": categoryNameController.text,
      "product_name": productNameController.text,
      "opening_stock": openingStockController.text,
      "min_stock": minStockController.text,
    };

    await ApiUtil.postApiWithput(
      url:ApiUrl.productsUpdate(id: userid) ,
      body: jsonEncode(body),

      success: (source) async {
        print(" Response: ${source}");
        await getProductList();
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
  Future<void> deleteProducts(String id) async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token == null) {
      print('No token found!');
      return;
    }
    try {
      final response = await dio.delete(
        'https://billing-backend-l9z5.onrender.com/api/products/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Company deleted successfully');
        getProductList();
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


