class UserAndAccessModel {
  int? statusCode;
  dynamic data;  // This will hold the users data
  String? message; // Now a simple string
  bool? success;

  UserAndAccessModel({this.statusCode, this.data, this.message, this.success});

  UserAndAccessModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'];  // This will contain the users array
    message = json['message'];  // This is now a string
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['data'] = this.data;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Message {
  String? id;
  String? username;
  String? mobileNumber;
  String? password;
  String? accountType;
  String? createdAt;
  String? updatedAt;

  Message({
    this.id,
    this.username,
    this.mobileNumber,
    this.password,
    this.accountType,
    this.createdAt,
    this.updatedAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    mobileNumber = json['mobile_number'];
    password = json['password'];
    accountType = json['account_type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['mobile_number'] = this.mobileNumber;
    data['password'] = this.password;
    data['account_type'] = this.accountType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
