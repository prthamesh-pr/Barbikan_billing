class listOfCompanyModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  listOfCompanyModel({this.statusCode, this.data, this.message, this.success});

  listOfCompanyModel.fromJson(Map<String, dynamic> json) {
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
  List<Companies>? companies;

  Data({this.companies});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['companies'] != null) {
      companies = <Companies>[];
      json['companies'].forEach((v) {
        companies!.add(new Companies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.companies != null) {
      data['companies'] = this.companies!.map((v) => v.toJson()).toList();
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

  Companies(
      {this.id,
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
        this.updatedAt});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['mobile_number'] = this.mobileNumber;
    data['gst_number'] = this.gstNumber;
    data['fssai_number'] = this.fssaiNumber;
    data['email'] = this.email;
    data['bill_prefix'] = this.billPrefix;
    data['billing_address'] = this.billingAddress;
    data['city'] = this.city;
    data['state'] = this.state;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['ifsc_code'] = this.ifscCode;
    data['upi_number'] = this.upiNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
