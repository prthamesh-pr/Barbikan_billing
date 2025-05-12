
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/salesList_model.dart';



class SalesProvider extends ChangeNotifier{

  final searchController = TextEditingController();
  final scrollController = ScrollController();

  bool isLoading=false;

  String selectedFilter = "All";
  String _sortBy = "Date";
  bool _sortAscending = false;
  String? selectedStatus ;

  void addItem(SaleItemModel item) {
  //  final index = listOfItems.length;
    listOfItems.add(item);
    itemNameControllers.add(TextEditingController(text: item.productName ?? ''));
    quantityControllers.add(TextEditingController(text: item.quantity?.toString() ?? ''));
    priceControllers.add(TextEditingController(text: item.price ?? ''));

    notifyListeners();
  }

  void removeItem(int index) {
    itemNameControllers[index].dispose();
    quantityControllers[index].dispose();
    priceControllers[index].dispose();

    itemNameControllers.removeAt(index);
    quantityControllers.removeAt(index);
    priceControllers.removeAt(index);

    listOfItems.removeAt(index);
    notifyListeners();
  }



  void syncControllersToModel() {
    for (int i = 0; i < listOfItems.length; i++) {
      listOfItems[i].productName = itemNameControllers[i]?.text;
      listOfItems[i].quantity = int.tryParse(quantityControllers[i]?.text ?? '');
      listOfItems[i].price = priceControllers[i]?.text;
    }
  }

  @override
  void dispose() {
    // searchController.dispose();
    // scrollController.dispose();
    customerNameController.dispose();
    saleDateController.dispose();
    statusController.dispose();
    totalAmountController.dispose();

    for (var controller in itemNameControllers) {
      controller.dispose();
    }
    for (var controller in quantityControllers) {
      controller.dispose();
    }
    for (var controller in priceControllers) {
      controller.dispose();
    }

    super.dispose();
  }




  List<Sales>  listOfSales =[];

  List<Sales> get filteredSales {
    List<Sales> result = List.from(listOfSales);

    //Apply filter
    if (selectedFilter != "All") {
      result = result.where((sale) => sale.status== selectedFilter).toList();
    }

   // Apply search
   //  if (searchController.text.isNotEmpty) {
   //    final query = searchController.text.toLowerCase();
   //    result =
   //        result
   //            .where(
   //              (sale) =>
   //          sale.id.toLowerCase().contains(query) ||
   //              sale.customerName.toLowerCase().contains(query),
   //        )
   //            .toList();
   //  }

    //Apply sorting
    // result.sort((a, b) {
    //   int comparison;
    //   switch (_sortBy) {
    //     case "ID":
    //       comparison = a.id.compareTo(b.id);
    //       break;
    //     case "Customer":
    //       comparison = a.customerName.compareTo(b.customerName);
    //       break;
    //     case "Amount":
    //       comparison = a.amount.compareTo(b.amount);
    //       break;
    //     case "Date":
    //     default:
    //       comparison = a.date.compareTo(b.date);
    //   }
    //   return _sortAscending ? comparison : -comparison;
    // });

    return result;
  }

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }


  final List<String> statusOptions = ['Pending', 'Paid', 'Completed'];

  void setSelectedStatus(String value) {
    selectedStatus = value;
    statusController.text = value;
    notifyListeners();
  }


  final List<SaleItemModel> listOfItems = [];

  List<TextEditingController> itemNameControllers = [];
  List<TextEditingController> quantityControllers = [];
  List<TextEditingController> priceControllers = [];

  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController saleDateController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  // final TextEditingController itemNameController = TextEditingController();
  // final TextEditingController quantityController = TextEditingController();
  // final TextEditingController priceController = TextEditingController();


  String userid='';
  setUserId(String id){
    userid=id;
    notifyListeners();
  }

  void loadUserData(Sales user) {
    customerNameController.text = user.customerName?? '';
    saleDateController.text = user.saleDate?? '';
    statusController.text = user.status?? '';
    totalAmountController.text = user.totalAmount?? '';
    userid=user.id!;
    notifyListeners();
  }

  void inItState() {
    customerNameController.clear();
    saleDateController.clear();
    statusController.clear();
    totalAmountController.clear();

    getSalesList();
  }

  ///get api===============
  Future<void> getSalesList() async {
    isLoading=true;
    notifyListeners();
    await ApiUtil.getApi(
      url: ApiUrl.addSalesList,
      success: (source) {
        try {

          Map<String, dynamic> json = jsonDecode(source.body);
          var response = SalesListModel.fromJson(json);
          listOfSales.clear();
          if (response.data != null && response.data!.sales != null) {
            listOfSales.addAll(response.data!.sales!);
            print('Sales list length: ${listOfSales.length}');
          } else {
            print('No Sales found in response.');
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
  Future<void> addNewSales({
   // required double price,
    Function? success,
    Function? failure,
  }) async{

    Map<String, dynamic> body = {
      "customer_name": customerNameController.text,
      "sale_date": DateFormat('yyyy-MM-dd').format(selectedDate),
      "status": statusController.text,
      "total_amount": totalAmountController.text,
      "items": listOfItems.map((item) {
        return {
          "item_name": item.productName,
          "quantity": item.quantity ?? 0,
          "price": double.tryParse(item.price ?? '0') ?? 0.0,
        };
      }).toList(),
    };

    await ApiUtil.postApiWithBody(
        url: ApiUrl.addSalesList,
        body: jsonEncode(body),

        success: (response)async {
          var json = jsonDecode(response);
          var newUsers = SalesListModel.fromJson(json);
          print('object${response}');
          final company = newUsers.data?.sales;
          if (company != null) {
            listOfSales.addAll(company);
          }
          await getSalesList();
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
  Future putSalesUpdate({
    Function? success,
    Function? failure})
  async{

    var  body = {
      "customer_name": customerNameController.text,
      "sale_date": DateFormat('yyyy-MM-dd').format(selectedDate),
      "status": statusController.text,
      "total_amount": totalAmountController.text,
      "items": listOfItems.map((item) {
        return {
          "item_name": item.productName,
          "quantity": item.quantity ?? 0,
          "price": double.tryParse(item.price ?? '0') ?? 0.0,
        };
      }).toList(),
    };
    await ApiUtil.postApiWithput(
      url:ApiUrl.addSalesListUpdate(id: userid) ,
      body: jsonEncode(body),

      success: (source) async {
        print(" Response: ${source}");
        await  getSalesList();
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
  Future<void> deleteSales(String id) async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token == null) {
      print('No token found!');
      return;
    }
    print('https://billing-backend-l9z5.onrender.com/api/sales/$id');
    try {
      final response = await dio.delete(
        'https://billing-backend-l9z5.onrender.com/api/sales/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Company deleted successfully');
        getSalesList();
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

class SaleItemModel {

  String? id;
  String? productName;
  int? quantity;
  String? price;

  SaleItemModel({
    this.id,
    this.productName,
    this.quantity,
    this.price,
  });

  factory SaleItemModel.fromJson(Map<String, dynamic> json) {
    return SaleItemModel(
      id: json['id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}