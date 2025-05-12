
class PlayAreaDashBoardModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  PlayAreaDashBoardModel(
      {this.statusCode, this.data, this.message, this.success});

  PlayAreaDashBoardModel.fromJson(Map<String, dynamic> json) {
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
  Stats? stats;
  List<TodayBookings>? todayBookings;

  Data({this.stats, this.todayBookings});

  Data.fromJson(Map<String, dynamic> json) {
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    if (json['todayBookings'] != null) {
      todayBookings = <TodayBookings>[];
      json['todayBookings'].forEach((v) {
        todayBookings!.add(new TodayBookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    if (this.todayBookings != null) {
      data['todayBookings'] =
          this.todayBookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {
  int? football;
  int? cricket;
  int? badminton;
  int? tableTennis;

  Stats({this.football, this.cricket, this.badminton, this.tableTennis});

  Stats.fromJson(Map<String, dynamic> json) {
    football = json['Football'];
    cricket = json['Cricket'];
    badminton = json['Badminton'];
    tableTennis = json['Table Tennis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Football'] = this.football;
    data['Cricket'] = this.cricket;
    data['Badminton'] = this.badminton;
    data['Table Tennis'] = this.tableTennis;
    return data;
  }
}

class TodayBookings {
  String? id;
  String? date;
  String? startTime;
  String? endTime;
  String? totalPrice;
  Null? staffId;
  String? turfId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? createdAt;
  String? updatedAt;
  Turf? turf;

  TodayBookings(
      {this.id,
        this.date,
        this.startTime,
        this.endTime,
        this.totalPrice,
        this.staffId,
        this.turfId,
        this.userName,
        this.userEmail,
        this.userPhone,
        this.createdAt,
        this.updatedAt,
        this.turf});

  TodayBookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    totalPrice = json['total_price'];
    staffId = json['staff_id'];
    turfId = json['turf_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    turf = json['Turf'] != null ? new Turf.fromJson(json['Turf']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['total_price'] = this.totalPrice;
    data['staff_id'] = this.staffId;
    data['turf_id'] = this.turfId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.turf != null) {
      data['Turf'] = this.turf!.toJson();
    }
    return data;
  }
}

class Turf {
  String? name;
  String? sport;

  Turf({this.name, this.sport});

  Turf.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sport = json['sport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['sport'] = this.sport;
    return data;
  }
}


