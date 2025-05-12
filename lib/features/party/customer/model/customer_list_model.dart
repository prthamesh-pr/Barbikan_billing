class CustomerListModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  CustomerListModel({this.statusCode, this.data, this.message, this.success});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
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
  List<Customers>? customers;

  Data({this.customers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(new Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  String? id;
  String? companyName;
  String? partyName;
  String? phone;
  String? altPhone;
  String? gstNumber;
  String? email;
  String? billingAddress;
  String? billingCity;
  String? billingState;
  String? shippingAddress;
  String? shippingCity;
  String? shippingState;
  String? creditCategory;
  String? openingBalance;
  String? openingDate;
  String? createdAt;
  String? updatedAt;

  Customers(
      {this.id,
        this.companyName,
        this.partyName,
        this.phone,
        this.altPhone,
        this.gstNumber,
        this.email,
        this.billingAddress,
        this.billingCity,
        this.billingState,
        this.shippingAddress,
        this.shippingCity,
        this.shippingState,
        this.creditCategory,
        this.openingBalance,
        this.openingDate,
        this.createdAt,
        this.updatedAt});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    partyName = json['party_name'];
    phone = json['phone'];
    altPhone = json['alt_phone'];
    gstNumber = json['gst_number'];
    email = json['email'];
    billingAddress = json['billing_address'];
    billingCity = json['billing_city'];
    billingState = json['billing_state'];
    shippingAddress = json['shipping_address'];
    shippingCity = json['shipping_city'];
    shippingState = json['shipping_state'];
    creditCategory = json['credit_category'];
    openingBalance = json['opening_balance'];
    openingDate = json['opening_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['party_name'] = this.partyName;
    data['phone'] = this.phone;
    data['alt_phone'] = this.altPhone;
    data['gst_number'] = this.gstNumber;
    data['email'] = this.email;
    data['billing_address'] = this.billingAddress;
    data['billing_city'] = this.billingCity;
    data['billing_state'] = this.billingState;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_city'] = this.shippingCity;
    data['shipping_state'] = this.shippingState;
    data['credit_category'] = this.creditCategory;
    data['opening_balance'] = this.openingBalance;
    data['opening_date'] = this.openingDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
