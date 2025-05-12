
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_Utils.dart';
import '../../utils/api_url.dart';
import '../../utils/constants.dart';
import '../model/invoice_billing_model.dart';

class InvoiceProvider extends ChangeNotifier {

  final List<Bills> _invoiceList = [];

  List<Bills> get invoiceList => _invoiceList;

  bool isLoading = false;

  String userid='';
  setUserId(String id){
    userid=id;
    notifyListeners();
  }

  void loadUserData(Bills user) {
    invoiceNumberController.text = user.invoiceNumber?? '';
    invoiceDateController.text = user.invoiceDate?? '';
    dueDateController.text = user.dueDate?? '';
    totalAmountController.text = user.totalAmount?? '';
    partyIdController.text = user.partyId?? '';
    userid=user.id!;

    notifyListeners();
  }

  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController invoiceDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController partyIdController = TextEditingController();
 // TextEditingController productNameController = TextEditingController();



  List<ItemController> itemControllers = [];

  double get subtotal {
    return itemControllers.fold(
      0.0,
          (sum, item) => sum + (double.tryParse(item.price.text) ?? 0.0) * (int.tryParse(item.quantity.text) ?? 0),
    );
  }

  double get taxAmount {
    return subtotal * 0.18; // Example: 18% tax
  }

  double get total {
    return subtotal + taxAmount;
  }




  void addProduct() {
    final item = ItemController();

    item.quantity.addListener(() => _calculateAmount(item));
    item.amountController.addListener(() => _calculateAmount(item));
    item.taxController.addListener(() => _calculateAmount(item));

    itemControllers.add(item);
    notifyListeners();
  }

  void _calculateAmount(ItemController item) {
    final quantity = double.tryParse(item.quantity.text) ?? 0;
    final price = double.tryParse(item.price.text) ?? 0;
    final taxPercent = double.tryParse(item.taxController.text) ?? 0;
    var subTotal = double.tryParse(item.subTotalController.text) ?? 0;
    final amount = quantity * price;
   // final taxAmount = baseAmount * taxPercent / 100;
   // item.taxAmount = taxAmount;
    subTotal = amount + amount;
      //total_amount = totalAmountController;
    notifyListeners();
  }

  void removeProduct(ItemController item) {
    // item.qtyController.dispose();
     item.price.dispose();
    item.quantity.dispose();
    item.productName.dispose();
    item.taxController.dispose();
    item.amountController.dispose();
   // ItemController.remove(item);
    notifyListeners();
  }




  void initState() {
    invoiceNumberController.clear();
    dueDateController.clear();
    invoiceDateController.clear();
    totalAmountController.clear();
    partyIdController.clear();
    getInvoiceList();
  }

  /// get api ===============
  Future<void> getInvoiceList() async {
    isLoading = true;
    notifyListeners();
    await ApiUtil.getApi(
      url: ApiUrl.salesBill,
      success: (source) {
        try {
          Map<String, dynamic> json = jsonDecode(source.body);
          var response = InvoiceBillingModel.fromJson(json);


          if (response.data != null && response.data!.bills != null) {
            _invoiceList.clear();
            _invoiceList.addAll(response.data!.bills!);

            print('invoiceBill list length: ${invoiceList.length}');
          } else {
            _invoiceList.clear();
            print('No invoiceBill found in response.');
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
  Future<void> newInvoiceBilling({
  //  required double price,
    Function? success,
    Function? failure,
  }) async {
    Map<String, dynamic> body = {
      "invoice_number": invoiceNumberController.text,
      "invoice_date": invoiceDateController.text,
      "due_date": dueDateController.text,
      "total_amount":  (total * 1.18).toStringAsFixed(2),
      "party_id": partyIdController.text,
      "items": itemControllers.map((item) => item.toMap()).toList(),


    };

    await ApiUtil.postApiWithBody(
        url: ApiUrl.salesBill,
        body: jsonEncode(body),

        success: (response) async {
          var json = jsonDecode(response);
          var newUsers = InvoiceBillingModel.fromJson(json);
          print('object${response}');
          final company = newUsers.data?.bills;
          if (company != null) {
            invoiceList.addAll(company);
          }
          await getInvoiceList();
          notifyListeners();
          isLoading = false;
          if (success != null) {
            return success();
          }
        },
        failure: (message) {
          if (failure != null) {
            isLoading = false;
            return failure(message);
          }
        });
  }



  ///put api=======
  Future putInvoiceUpdate({
    Function? success,
    Function? failure})
  async{

    var  body = {
      "invoice_number": invoiceNumberController.text,
      "invoice_date": invoiceDateController.text,
      "due_date": dueDateController.text,
      "total_amount":  (total * 1.18).toStringAsFixed(2),
      "party_id": partyIdController.text,
      "items": itemControllers.map((item) => item.toMap()).toList(),


    };


    await ApiUtil.postApiWithput(
      url:ApiUrl.salesBillUpdate(id: userid) ,
      body: jsonEncode(body),

      success: (source) async {

        await getInvoiceList();
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

  /// Delete Api ================
  Future<void> deleteInvoice(String id) async {
    final Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token == null) {
      print('No token found!');
      return;
    }
    print("Delete_api_url=====${  'https://billing-backend-l9z5.onrender.com/api/sale-bills/$id'}");
    try {
      final response = await dio.delete(
        'https://billing-backend-l9z5.onrender.com/api/sale-bills/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Company deleted successfully');

       getInvoiceList();

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

class ItemController {
  final TextEditingController productName;
  final TextEditingController price;
  final TextEditingController quantity;
  final TextEditingController subTotalController;

  // Add these controllers
  // final TextEditingController qtyController;
   final TextEditingController amountController;
  final TextEditingController taxController;

  ItemController({
    String? productName,
    String? price,
    String? quantity,
     double? amount,
     double? subTotal,
    String? tax,
  })  : productName = TextEditingController(text: productName),
        price = TextEditingController(text: price),
        quantity = TextEditingController(text: quantity),

        amountController = TextEditingController( text: amount != null ? amount.toStringAsFixed(2) : ''),
        subTotalController = TextEditingController( text: subTotal != null ? subTotal.toStringAsFixed(2) : ''),
        taxController = TextEditingController(text: tax);

  double get amount {
    final double qty = double.tryParse(quantity.text) ?? 0;
    final double rate = double.tryParse(price.text) ?? 0;
    return qty * rate;
  }

  void dispose() {
    productName.dispose();
    price.dispose();
    quantity.dispose();
    subTotalController.dispose();
    amountController.dispose();
    taxController.dispose();
  }

  Map<String, dynamic> toMap() {
    return {
      'product_name': productName.text,
      'price': price.text,
      'quantity': int.tryParse(quantity.text) ?? 0,
      'amount': amountController.text,
      'subTotal': subTotalController.text,
      'tax': taxController.text,
    };
  }
}


