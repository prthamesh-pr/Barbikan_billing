class AddNewCompanyModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  AddNewCompanyModel({this.statusCode, this.data, this.message, this.success});

  AddNewCompanyModel.fromJson(Map<String, dynamic> json) {
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
  Company? company;

  Data({this.company});

  Data.fromJson(Map<String, dynamic> json) {
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.company != null) {
      data['company'] = this.company!.toJson();
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

  Company(
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
        this.updatedAt,
        this.createdAt});

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
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
