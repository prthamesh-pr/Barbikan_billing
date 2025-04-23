// lib/model/company_model.dart

class CompanyModel {
  final String id;
  final String companyName;
  final String mobileNumber;
  final String gstNumber;
  final String fssaiNumber;
  final String email;
  final String billPrefix;
  final String billingAddress;
  final String city;
  final String state;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String upiNumber;
  final String createdAt;
  final String updatedAt;

  CompanyModel({
    required this.id,
    required this.companyName,
    required this.mobileNumber,
    required this.gstNumber,
    required this.fssaiNumber,
    required this.email,
    required this.billPrefix,
    required this.billingAddress,
    required this.city,
    required this.state,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.upiNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      companyName: json['company_name'],
      mobileNumber: json['mobile_number'],
      gstNumber: json['gst_number'],
      fssaiNumber: json['fssai_number'],
      email: json['email'],
      billPrefix: json['bill_prefix'],
      billingAddress: json['billing_address'],
      city: json['city'],
      state: json['state'],
      bankName: json['bank_name'],
      accountNumber: json['account_number'],
      ifscCode: json['ifsc_code'],
      upiNumber: json['upi_number'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
