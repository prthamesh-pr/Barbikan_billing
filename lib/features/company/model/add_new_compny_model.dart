class AddNewCompanyModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  AddNewCompanyModel({this.statusCode, this.data, this.message, this.success});

  AddNewCompanyModel.fromJson(Map<String, dynamic> json) {
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
  Company? company;

  Data({this.company});

  Data.fromJson(Map<String, dynamic> json) {
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Company {
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
  String? updatedAt;
  String? createdAt;

  Company({
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
    this.updatedAt,
    this.createdAt,
  });

  Company.fromJson(Map<String, dynamic> json) {
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
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
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
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
