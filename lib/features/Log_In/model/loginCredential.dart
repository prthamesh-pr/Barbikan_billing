class LoginCredentialModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  LoginCredentialModel({
    this.statusCode,
    this.data,
    this.message,
    this.success,
  });

  factory LoginCredentialModel.fromJson(Map<String, dynamic> json) {
    return LoginCredentialModel(
      statusCode: json['statusCode'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
  String? token;
  User? user;

  Data({this.token, this.user});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? accountType;

  User({this.id, this.username, this.accountType});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      accountType: json['account_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['username'] = username;
    data['account_type'] = accountType;
    return data;
  }
}
