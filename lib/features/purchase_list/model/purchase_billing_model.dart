
class PurchaseBillingModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  PurchaseBillingModel(
      {this.statusCode, this.data, this.message, this.success});

  PurchaseBillingModel.fromJson(Map<String, dynamic> json) {
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
  List<PurchaseBills>? purchaseBills;

  Data({this.purchaseBills});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['purchaseBills'] != null) {
      purchaseBills = <PurchaseBills>[];
      json['purchaseBills'].forEach((v) {
        purchaseBills!.add(new PurchaseBills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchaseBills != null) {
      data['purchaseBills'] =
          this.purchaseBills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseBills {
  String? id;
  String? billNumber;
  String? billDate;
  String? partyName;
  String? paymentMethod;
  Null? notes;
  String? grandTotal;
  String? createdAt;
  String? updatedAt;
  PurchaseParty? purchaseParty;

  PurchaseBills(
      {this.id,
        this.billNumber,
        this.billDate,
        this.partyName,
        this.paymentMethod,
        this.notes,
        this.grandTotal,
        this.createdAt,
        this.updatedAt,
        this.purchaseParty});

  PurchaseBills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billNumber = json['bill_number'];
    billDate = json['bill_date'];
    partyName = json['party_name'];
    paymentMethod = json['payment_method'];
    notes = json['notes'];
    grandTotal = json['grand_total'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    purchaseParty = json['PurchaseParty'] != null
        ? new PurchaseParty.fromJson(json['PurchaseParty'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_number'] = this.billNumber;
    data['bill_date'] = this.billDate;
    data['party_name'] = this.partyName;
    data['payment_method'] = this.paymentMethod;
    data['notes'] = this.notes;
    data['grand_total'] = this.grandTotal;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.purchaseParty != null) {
      data['PurchaseParty'] = this.purchaseParty!.toJson();
    }
    return data;
  }
}

class PurchaseParty {
  String? id;
  String? partyName;
  String? companyName;

  PurchaseParty({this.id, this.partyName, this.companyName});

  PurchaseParty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partyName = json['party_name'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['party_name'] = this.partyName;
    data['company_name'] = this.companyName;
    return data;
  }
}
