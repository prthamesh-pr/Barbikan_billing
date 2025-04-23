class UserAndAccessModel {
  int? statusCode;
  dynamic data; // This will hold the users data
  String? message; // Now a simple string
  bool? success;

  UserAndAccessModel({this.statusCode, this.data, this.message, this.success});

  UserAndAccessModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data']; // This will contain the users array
    message = json['message']; // This is now a string
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['data'] = this.data;
    data['message'] = message;
    data['success'] = success;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['mobile_number'] = mobileNumber;
    data['password'] = password;
    data['account_type'] = accountType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
