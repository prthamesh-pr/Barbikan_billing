class PurchasePartyAddListModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  PurchasePartyAddListModel(
      {this.statusCode, this.data, this.message, this.success});

  PurchasePartyAddListModel.fromJson(Map<String, dynamic> json) {
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
  PurchaseParty? purchaseParty;

  Data({this.purchaseParty});

  Data.fromJson(Map<String, dynamic> json) {
    purchaseParty = json['purchaseParty'] != null
        ? new PurchaseParty.fromJson(json['purchaseParty'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchaseParty != null) {
      data['purchaseParty'] = this.purchaseParty!.toJson();
    }
    return data;
  }
}

class PurchaseParty {
  String? id;
  String? companyName;
  String? partyName;
  String? gstNumber;
  String? mobileNumber;
  String? alternateMobileNumber;
  String? email;
  String? billingAddress;
  String? billingCity;
  String? billingState;
  String? category;
  String? openingBalance;
  String? updatedAt;
  String? createdAt;
  Null? companyId;

  PurchaseParty(
      {this.id,
        this.companyName,
        this.partyName,
        this.gstNumber,
        this.mobileNumber,
        this.alternateMobileNumber,
        this.email,
        this.billingAddress,
        this.billingCity,
        this.billingState,
        this.category,
        this.openingBalance,
        this.updatedAt,
        this.createdAt,
        this.companyId});

  PurchaseParty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    partyName = json['party_name'];
    gstNumber = json['gst_number'];
    mobileNumber = json['mobile_number'];
    alternateMobileNumber = json['alternate_mobile_number'];
    email = json['email'];
    billingAddress = json['billing_address'];
    billingCity = json['billing_city'];
    billingState = json['billing_state'];
    category = json['category'];
    openingBalance = json['opening_balance'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    companyId = json['company_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['party_name'] = this.partyName;
    data['gst_number'] = this.gstNumber;
    data['mobile_number'] = this.mobileNumber;
    data['alternate_mobile_number'] = this.alternateMobileNumber;
    data['email'] = this.email;
    data['billing_address'] = this.billingAddress;
    data['billing_city'] = this.billingCity;
    data['billing_state'] = this.billingState;
    data['category'] = this.category;
    data['opening_balance'] = this.openingBalance;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['company_id'] = this.companyId;
    return data;
  }
}
