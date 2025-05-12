class AddCategoryListModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  AddCategoryListModel(
      {this.statusCode, this.data, this.message, this.success});

  AddCategoryListModel.fromJson(Map<String, dynamic> json) {
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
  Category? category;

  Data({this.category});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  String? id;
  bool? isActive;
  String? categoryName;
  int? noOfProducts;
  String? updatedAt;
  String? createdAt;

  Category(
      {this.id,
        this.isActive,
        this.categoryName,
        this.noOfProducts,
        this.updatedAt,
        this.createdAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['is_active'];
    categoryName = json['category_name'];
    noOfProducts = json['no_of_products'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_active'] = this.isActive;
    data['category_name'] = this.categoryName;
    data['no_of_products'] = this.noOfProducts;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
