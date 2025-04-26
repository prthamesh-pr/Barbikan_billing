class NewUsersModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  NewUsersModel({this.statusCode, this.data, this.message, this.success});

  NewUsersModel.fromJson(Map<String, dynamic> json) {
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

  static List<NewUsersModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => NewUsersModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? mobileNumber;
  String? password;
  String? accountType;
  String? updatedAt;
  String? createdAt;

  User({
    this.id,
    this.username,
    this.mobileNumber,
    this.password,
    this.accountType,
    this.updatedAt,
    this.createdAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    mobileNumber = json['mobile_number'];
    password = json['password'];
    accountType = json['account_type'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['mobile_number'] = mobileNumber;
    data['password'] = password;
    data['account_type'] = accountType;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
