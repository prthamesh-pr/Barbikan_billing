
import 'dart:convert';

import 'package:billing_web/features/purchase_list/model/add_purchaseBilling_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/purchase_billing_model.dart';

class PurchaseListProvider extends ChangeNotifier{

bool  isLoading=false;



List<PurchaseBills> listOfPurchaseBill = [];
List<AddPurchaseBillingModel> addListOfPurchaseBill = [];
String? selectedCategory;

List<String> listOfPurchaseBillNames = [];
Map<String, String> purchaseBillNameToIdMap = {};

final TextEditingController partyNameController = TextEditingController();
final TextEditingController paymentMethodController = TextEditingController();
final TextEditingController grandTotalController = TextEditingController();
final TextEditingController billDateController = TextEditingController();
final TextEditingController billNumberController = TextEditingController();
String grandTotalString = '';

List<ProductItem> productItems = [];


// double get totalSubTotal {
//   return productItems.fold<double>(
//     0,
//         (sum, item) => sum + (item.subTotal ?? 0),
//   );
// }
  double get totalAmount =>
      productItems.fold(0.0, (sum, item) => sum + (item.amount ?? 0.0));

double get totalTaxAmount {
  return productItems.fold<double>(
    0,
        (sum, item) => sum + (item.taxAmount ?? 0),
  );
}

double get grandTotal {
  return totalAmount + totalTaxAmount;
}


void addProduct() {
  final item = ProductItem(
    qtyController: TextEditingController(),
    rateController: TextEditingController(),
    taxController: TextEditingController(),

  );

  // Listen for changes and update amount automatically
  item.qtyController.addListener(() => _calculateAmount(item));
  item.rateController.addListener(() => _calculateAmount(item));
  item.taxController.addListener(() => _calculateAmount(item));

  productItems.add(item);
  notifyListeners();
}
void _calculateAmount(ProductItem item) {
  final qty = double.tryParse(item.qtyController.text) ?? 0;
  final rate = double.tryParse(item.rateController.text) ?? 0;
  final taxPercent = double.tryParse(item.taxController.text) ?? 0;

  final baseAmount = qty * rate;
  final taxAmount = baseAmount * taxPercent / 100;
  item.taxAmount = taxAmount;
  item.amount =  baseAmount;
  item.subTotal = baseAmount + taxAmount;
  grandTotalString = grandTotal.toStringAsFixed(2);
  notifyListeners();
}

void removeProduct(ProductItem item) {
  item.qtyController.dispose();
  item.rateController.dispose();
  item.taxController.dispose();
  productItems.remove(item);
  notifyListeners();
}


  String userid='';
  setUserId(String id){
    userid=id;
    notifyListeners();
  }

  void loadUserData(PurchaseBills user) {
    paymentMethodController.text = user.paymentMethod?? '';
    partyNameController.text = user.partyName?? '';
    billDateController.text = user.billDate?? '';
    billNumberController.text = user.billNumber?? '';
    userid=user.id!;

    notifyListeners();
  }

void initState() {
  partyNameController.clear();
  paymentMethodController.clear();
  grandTotalController.clear();
  billDateController.clear();
  billNumberController.clear();
  getPurchaseBillList();
}



/// get api ===============
  Future<void> getPurchaseBillList() async {
    isLoading=true;
    notifyListeners();
    await ApiUtil.getApi(
      url: ApiUrl.purchaseBill,
      success: (source) {
        try {

          Map<String, dynamic> json = jsonDecode(source.body);
          var response = PurchaseBillingModel.fromJson(json);

          listOfPurchaseBill.clear();
          listOfPurchaseBillNames.clear();
          purchaseBillNameToIdMap.clear();

          if (response.data != null && response.data!.purchaseBills != null) {
            listOfPurchaseBill.addAll(response.data!.purchaseBills!);

            print('Loaded ${listOfPurchaseBillNames.length} unique category names');
            if (listOfPurchaseBillNames.isNotEmpty) {
              selectedCategory = listOfPurchaseBillNames[0]; // Set default selected category
            }
            print('purchaseBill list length: ${listOfPurchaseBill.length}');
          } else {
            print('No purchaseBill found in response.');
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

///Post api===============
Future<void> newPurchaseBill({
  Function? success,
  Function? failure,
}) async {
  isLoading = true;
  grandTotalString = grandTotal.toStringAsFixed(2);
  notifyListeners();

  Map<String, dynamic> body = {
    "party_name": partyNameController.text,
    "payment_method": paymentMethodController.text,
    "grand_total": grandTotalString,
    "bill_date": billDateController.text,
    "bill_number": billNumberController.text,
  };
print('object====${body}');
  await ApiUtil.postApiWithBody(
    url: ApiUrl.purchaseBill,
    body: jsonEncode(body),
    success: (response) async {
      try {
        var json = jsonDecode(response);
        var newUsers = AddPurchaseBillingModel.fromJson(json);
        print('API response: $response');
        addListOfPurchaseBill.add(newUsers);
        await getPurchaseBillList();

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


  ///put api=======
  Future putPurchaseBillUpdate({
    Function? success,
    Function? failure})
  async{
    var body = {
      "party_name": partyNameController.text,
      "payment_method": paymentMethodController.text,
      "grand_total": grandTotalString,
      "bill_date": billDateController.text,
      "bill_number": billNumberController.text,
    };
    await ApiUtil.postApiWithput(
      url:ApiUrl.purchaseBillUpdate(id: userid) ,
      body: jsonEncode(body),

      success: (source) async {
        await getPurchaseBillList();
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
  Future<void> deletePurchasebill(String id) async {
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
        'https://billing-backend-l9z5.onrender.com/api/purchase-bills/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Company deleted successfully');
        getPurchaseBillList();
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

class ProductItem {
  String name;
  TextEditingController qtyController;
  TextEditingController rateController;
  TextEditingController taxController;
  double amount;
  double taxAmount;
  double subTotal;


  ProductItem({
    this.name = '',
    required this.qtyController,
    required this.rateController,
    required this.taxController,
    this.amount = 0.0,
    this.taxAmount= 0.0,
    this.subTotal= 0.0,

  });
}
