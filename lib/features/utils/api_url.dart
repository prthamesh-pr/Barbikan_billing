
class ApiUrl{

  static  String baseUrl = 'https://billing-backend-l9z5.onrender.com/api';
  static  String? login = '$baseUrl/auth/login';


  static  String? dashBoard = '$baseUrl/dashboard/overview';

  ///UserAndAccess=========
  static  String? userAccess = '$baseUrl/users';
  static  String? userUpdate({required String id}) => '$baseUrl/users/$id';
  static  String? userDelete({required String id}) => '$baseUrl/users/$id';

  ///Company=========
  static  String? addCompany = '$baseUrl/companies';
  static  String? companyDelete({required String id}) => '$baseUrl/companies/$id';
  static  String? compnayUpdate({required String id}) => '$baseUrl/companies/$id';

///PurchaseParty======
  static  String? purchaseParty = '$baseUrl/purchase-parties';
  static  String? addPurchaseParty = '$baseUrl/purchase-parties';
  static  String? purchasePartyUpdate({required String id}) => '$baseUrl/purchase-parties/$id';

///Customers ======
  static  String? customers = '$baseUrl/customers';
  static  String? customersUpdate({required String id}) => '$baseUrl/customers/$id';

  ///category ======
  static  String? category = '$baseUrl/categories';
  static  String? categoryUpdate({required String id}) => '$baseUrl/categories/$id';
  ///products ======
  static  String? products = '$baseUrl/products';
  static  String? productsUpdate({required String id}) => '$baseUrl/products/$id';

  ///purchaseBillList ======
  static  String? purchaseBill = '$baseUrl/purchase-bills';
  static  String? purchaseBillUpdate({required String id}) => '$baseUrl/purchase-bills/$id';

  ///salesBillList ======
  static  String? salesBill = '$baseUrl/sale-bills';
  static  String? salesBillUpdate({required String id}) => '$baseUrl/sale-bills/$id';

  ///stockList ======
  static  String? addStockList = '$baseUrl/stock-inventory';
  static  String? addStockListUpdate({required String id}) => '$baseUrl/stock-inventory/$id';

  ///salesList ======
  static  String? addSalesList = '$baseUrl/sales';
  static  String? addSalesListUpdate({required String id}) => '$baseUrl/sales/$id';


  ///PlayArea ======
  static  String? playGround = '$baseUrl/playground/bookings';




  static  String? playGroundDashBoard = '$baseUrl/dashboard/playarea-overview';




}
