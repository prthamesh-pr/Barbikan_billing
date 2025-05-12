class PlayAreaModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  PlayAreaModel({this.statusCode, this.data, this.message, this.success});

  PlayAreaModel.fromJson(Map<String, dynamic> json) {
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
  Booking? booking;

  Data({this.booking});

  Data.fromJson(Map<String, dynamic> json) {
    booking =
    json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class Booking {
  String? id;
  String? date;
  String? startTime;
  String? endTime;
  String? totalPrice;
  String? userName;
  String? userEmail;
  String? userPhone;
  Null? staffId;
  String? turfId;
  String? updatedAt;
  String? createdAt;

  Booking(
      {this.id,
        this.date,
        this.startTime,
        this.endTime,
        this.totalPrice,
        this.userName,
        this.userEmail,
        this.userPhone,
        this.staffId,
        this.turfId,
        this.updatedAt,
        this.createdAt});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    totalPrice = json['total_price'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    staffId = json['staff_id'];
    turfId = json['turf_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['total_price'] = this.totalPrice;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    data['staff_id'] = this.staffId;
    data['turf_id'] = this.turfId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

