class StockListDataModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  StockListDataModel({this.statusCode, this.data, this.message, this.success});

  StockListDataModel.fromJson(Map<String, dynamic> json) {
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
  List<InventoryItems>? inventoryItems;

  Data({this.inventoryItems});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['inventoryItems'] != null) {
      inventoryItems = <InventoryItems>[];
      json['inventoryItems'].forEach((v) {
        inventoryItems!.add(new InventoryItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inventoryItems != null) {
      data['inventoryItems'] =
          this.inventoryItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InventoryItems {
  String? id;
  String? productName;
  String? skuItemCode;
  String? price;
  int? quantity;
  String? categoryName;
  bool? onSale;
  String? description;
  String? buyingPrice;
  String? sellingPrice;
  String? createdAt;
  String? updatedAt;
  Null? productId;
  Null? categoryId;

  InventoryItems(
      {this.id,
        this.productName,
        this.skuItemCode,
        this.price,
        this.quantity,
        this.categoryName,
        this.onSale,
        this.description,
        this.buyingPrice,
        this.sellingPrice,
        this.createdAt,
        this.updatedAt,
        this.productId,
        this.categoryId});

  InventoryItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    skuItemCode = json['sku_item_code'];
    price = json['price'];
    quantity = json['quantity'];
    categoryName = json['category_name'];
    onSale = json['on_sale'];
    description = json['description'];
    buyingPrice = json['buying_price'];
    sellingPrice = json['selling_price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productId = json['product_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['sku_item_code'] = this.skuItemCode;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['category_name'] = this.categoryName;
    data['on_sale'] = this.onSale;
    data['description'] = this.description;
    data['buying_price'] = this.buyingPrice;
    data['selling_price'] = this.sellingPrice;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    return data;
  }
}
