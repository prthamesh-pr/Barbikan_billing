class listOfCompanyModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  listOfCompanyModel({this.statusCode, this.data, this.message, this.success});

  listOfCompanyModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class Data {
  List<Companies>? companies;

  Data({this.companies});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['companies'] != null) {
      companies = <Companies>[];
      json['companies'].forEach((v) {
        companies!.add(Companies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (companies != null) {
      data['companies'] = companies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Companies {
  String? id;
  String? companyName;
  String? mobileNumber;
  String? gstNumber;
  String? fssaiNumber;
  String? email;
  String? billPrefix;
  String? billingAddress;
  String? city;
  String? state;
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? upiNumber;
  String? createdAt;
  String? updatedAt;

  Companies({
    this.id,
    this.companyName,
    this.mobileNumber,
    this.gstNumber,
    this.fssaiNumber,
    this.email,
    this.billPrefix,
    this.billingAddress,
    this.city,
    this.state,
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.upiNumber,
    this.createdAt,
    this.updatedAt,
  });

  Companies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    mobileNumber = json['mobile_number'];
    gstNumber = json['gst_number'];
    fssaiNumber = json['fssai_number'];
    email = json['email'];
    billPrefix = json['bill_prefix'];
    billingAddress = json['billing_address'];
    city = json['city'];
    state = json['state'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    upiNumber = json['upi_number'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['mobile_number'] = mobileNumber;
    data['gst_number'] = gstNumber;
    data['fssai_number'] = fssaiNumber;
    data['email'] = email;
    data['bill_prefix'] = billPrefix;
    data['billing_address'] = billingAddress;
    data['city'] = city;
    data['state'] = state;
    data['bank_name'] = bankName;
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;
    data['upi_number'] = upiNumber;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
