class SalesListModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  SalesListModel({this.statusCode, this.data, this.message, this.success});

  SalesListModel.fromJson(Map<String, dynamic> json) {
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
  List<Sales>? sales;

  Data({this.sales});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(new Sales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sales != null) {
      data['sales'] = this.sales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sales {
  String? id;
  String? customerName;
  String? saleDate;
  String? status;
  String? totalAmount;
  String? createdAt;
  String? updatedAt;
  List<SaleItems>? saleItems;

  Sales(
      {this.id,
        this.customerName,
        this.saleDate,
        this.status,
        this.totalAmount,
        this.createdAt,
        this.updatedAt,
        this.saleItems});

  Sales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    saleDate = json['sale_date'];
    status = json['status'];
    totalAmount = json['total_amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['SaleItems'] != null) {
      saleItems = <SaleItems>[];
      json['SaleItems'].forEach((v) {
        saleItems!.add(new SaleItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['sale_date'] = this.saleDate;
    data['status'] = this.status;
    data['total_amount'] = this.totalAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.saleItems != null) {
      data['SaleItems'] = this.saleItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleItems {
  String? id;
  String? saleId;
  String? itemName;
  int? quantity;
  String? price;
  String? totalAmount;
  String? createdAt;
  String? updatedAt;

  SaleItems(
      {this.id,
        this.saleId,
        this.itemName,
        this.quantity,
        this.price,
        this.totalAmount,
        this.createdAt,
        this.updatedAt});

  SaleItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleId = json['sale_id'];
    itemName = json['item_name'];
    quantity = json['quantity'];
    price = json['price'];
    totalAmount = json['total_amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sale_id'] = this.saleId;
    data['item_name'] = this.itemName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total_amount'] = this.totalAmount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
