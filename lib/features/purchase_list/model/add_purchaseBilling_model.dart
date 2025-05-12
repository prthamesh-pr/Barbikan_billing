class AddPurchaseBillingModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  AddPurchaseBillingModel(
      {this.statusCode, this.data, this.message, this.success});

  AddPurchaseBillingModel.fromJson(Map<String, dynamic> json) {
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
  PurchaseBill? purchaseBill;

  Data({this.purchaseBill});

  Data.fromJson(Map<String, dynamic> json) {
    purchaseBill = json['purchaseBill'] != null
        ? new PurchaseBill.fromJson(json['purchaseBill'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchaseBill != null) {
      data['purchaseBill'] = this.purchaseBill!.toJson();
    }
    return data;
  }
}

class PurchaseBill {
  String? id;
  String? partyName;
  String? grandTotal;
  String? paymentMethod;
  String? billDate;
  String? billNumber;
  String? updatedAt;
  String? createdAt;
  Null? notes;

  PurchaseBill(
      {this.id,
        this.partyName,
        this.grandTotal,
        this.paymentMethod,
        this.billDate,
        this.billNumber,
        this.updatedAt,
        this.createdAt,
        this.notes});

  PurchaseBill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partyName = json['party_name'];
    grandTotal = json['grand_total'];
    paymentMethod = json['payment_method'];
    billDate = json['bill_date'];
    billNumber = json['bill_number'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['party_name'] = this.partyName;
    data['grand_total'] = this.grandTotal;
    data['payment_method'] = this.paymentMethod;
    data['bill_date'] = this.billDate;
    data['bill_number'] = this.billNumber;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['notes'] = this.notes;
    return data;
  }
}
