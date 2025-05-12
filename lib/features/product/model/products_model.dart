class ProductsModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  ProductsModel({this.statusCode, this.data, this.message, this.success});

  ProductsModel.fromJson(Map<String, dynamic> json) {
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
  List<Products>? products;

  Data({this.products});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? id;
  String? productName;
  String? categoryId;
  String? hsnNumber;
  String? itemCode;
  int? openingStock;
  String? categoryName;
  int? minStock;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  Category? category;

  Products(
      {this.id,
        this.productName,
        this.categoryId,
        this.hsnNumber,
        this.itemCode,
        this.openingStock,
        this.categoryName,
        this.minStock,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.category});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    hsnNumber = json['hsn_number'];
    itemCode = json['item_code'];
    openingStock = json['opening_stock'];
    minStock = json['min_stock'];
    isActive = json['is_active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['category_id'] = this.categoryId;
    data['category_name'] = categoryName;
    data['hsn_number'] = this.hsnNumber;
    data['item_code'] = this.itemCode;
    data['opening_stock'] = this.openingStock;
    data['min_stock'] = this.minStock;
    data['is_active'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  String? id;
  String? categoryName;

  Category({this.id, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    return data;
  }
}
