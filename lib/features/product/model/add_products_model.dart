class AddProductsMode {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  AddProductsMode({this.statusCode, this.data, this.message, this.success});

  AddProductsMode.fromJson(Map<String, dynamic> json) {
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
  Product? product;

  Data({this.product});

  Data.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  bool? isActive;
  String? categoryName;
  String? productName;
  String? hsnNumber;
  String? itemCode;
  int? openingStock;
  int? minStock;
  String? updatedAt;
  String? createdAt;

  Product(
      {this.id,
        this.isActive,
        this.categoryName,
        this.productName,
        this.hsnNumber,
        this.itemCode,
        this.openingStock,
        this.minStock,
        this.updatedAt,
        this.createdAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
    categoryName = json['category_name'];
    productName = json['product_name'];
    hsnNumber = json['hsn_number'];
    itemCode = json['item_code'];
    openingStock = json['opening_stock'];
    minStock = json['min_stock'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_active'] = this.isActive;
    data['category_name'] = this.categoryName;
    data['product_name'] = this.productName;
    data['hsn_number'] = this.hsnNumber;
    data['item_code'] = this.itemCode;
    data['opening_stock'] = this.openingStock;
    data['min_stock'] = this.minStock;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
