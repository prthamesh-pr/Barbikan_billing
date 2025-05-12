class DashBoardModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  DashBoardModel({this.statusCode, this.data, this.message, this.success});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? totalSalesProductMonth;
  int? totalPurchaseProductMonth;
  int? totalSalesProductToday;
  int? totalProducts;
  List<LowStockProducts>? lowStockProducts;

  Data(
      {this.totalSalesProductMonth,
        this.totalPurchaseProductMonth,
        this.totalSalesProductToday,
        this.totalProducts,
        this.lowStockProducts});

  Data.fromJson(Map<String, dynamic> json) {
    totalSalesProductMonth = json['totalSalesProductMonth'];
    totalPurchaseProductMonth = json['totalPurchaseProductMonth'];
    totalSalesProductToday = json['totalSalesProductToday'];
    totalProducts = json['totalProducts'];
    if (json['lowStockProducts'] != null) {
      lowStockProducts = <LowStockProducts>[];
      json['lowStockProducts'].forEach((v) {
        lowStockProducts!.add(new LowStockProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSalesProductMonth'] = this.totalSalesProductMonth;
    data['totalPurchaseProductMonth'] = this.totalPurchaseProductMonth;
    data['totalSalesProductToday'] = this.totalSalesProductToday;
    data['totalProducts'] = this.totalProducts;
    if (this.lowStockProducts != null) {
      data['lowStockProducts'] =
          this.lowStockProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LowStockProducts {
  String? id;
  String? productName;
  String? categoryName;
  Null? hsnNumber;
  Null? itemCode;
  int? openingStock;
  int? minStock;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  LowStockProducts(
      {this.id,
        this.productName,
        this.categoryName,
        this.hsnNumber,
        this.itemCode,
        this.openingStock,
        this.minStock,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  LowStockProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    categoryName = json['category_name'];
    hsnNumber = json['hsn_number'];
    itemCode = json['item_code'];
    openingStock = json['opening_stock'];
    minStock = json['min_stock'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['category_name'] = this.categoryName;
    data['hsn_number'] = this.hsnNumber;
    data['item_code'] = this.itemCode;
    data['opening_stock'] = this.openingStock;
    data['min_stock'] = this.minStock;
    data['is_active'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
