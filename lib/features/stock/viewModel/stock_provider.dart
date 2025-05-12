
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/stockList_model.dart';

class StockProvider extends ChangeNotifier{

  bool isLoading = false;

   List<InventoryItems> listOfStockItems = [];

  final TextEditingController skuItemCodeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController buyingPriceController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();

  void inItState() {
    skuItemCodeController.clear();
  //  priceController.clear();
    quantityController.clear();
    productNameController.clear();
    categoryNameController.clear();
    buyingPriceController.clear();
    sellingPriceController.clear();
    getStockList();
  }

   ///get api===============
  Future<void> getStockList() async {
    isLoading=true;
    notifyListeners();
    await ApiUtil.getApi(
      url: ApiUrl.addStockList,
      success: (source) {
        try {

          Map<String, dynamic> json = jsonDecode(source.body);
          var response = StockListDataModel.fromJson(json);
          listOfStockItems.clear();
          if (response.data != null && response.data!.inventoryItems != null) {
            listOfStockItems.addAll(response.data!.inventoryItems!);
            print('Stock list length: ${listOfStockItems.length}');
          } else {
            print('No stock found in response.');
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


  ///post api================
  Future<void> newStock({
    required double price,
    Function? success,
    Function? failure,
  }) async{

    Map<String, dynamic> body = {
      "sku_item_code" : skuItemCodeController.text,
      "price": price.toString(),
      "quantity":quantityController.text,
      "product_name":productNameController.text,
      "category_name":categoryNameController.text,
      "buying_price":buyingPriceController.text,
      "selling_price":sellingPriceController.text,

    };
    await ApiUtil.postApiWithBody(
        url: ApiUrl.addStockList,
        body: jsonEncode(body),

        success: (response)async {
          var json = jsonDecode(response);
          var newUsers = StockListDataModel.fromJson(json);
          print('object${response}');
          final company = newUsers.data?.inventoryItems;
          if (company != null) {
            listOfStockItems.addAll(company);
          }
          await getStockList();
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


  ///Delete api============
  Future<void> deleteStock(String id) async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token == null) {
      print('No token found!');
      return;
    }
    print('https://billing-backend-l9z5.onrender.com/api/stock-inventory/$id');
    try {
      final response = await dio.delete(
        'https://billing-backend-l9z5.onrender.com/api/stock-inventory/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Company deleted successfully');
        getStockList();
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