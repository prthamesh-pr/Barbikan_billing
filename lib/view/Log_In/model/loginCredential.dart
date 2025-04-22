class LoginCredentialModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  LoginCredentialModel({this.statusCode, this.data, this.message, this.success});

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
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
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
    data['id'] = this.id;
    data['username'] = this.username;
    data['account_type'] = this.accountType;
    return data;
  }
}




