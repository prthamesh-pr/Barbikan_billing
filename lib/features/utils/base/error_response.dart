class ErrorResponse {
  ErrorResponse({
    int? statusCode,
    String? timestamp,
    String? path,
    String? errorName,
    String? message,
  }) {
    _statusCode = statusCode;
    _timestamp = timestamp;
    _path = path;
    _errorName = errorName;
    _message = message;
  }

  ErrorResponse.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _timestamp = json['timestamp'];
    _path = json['path'];
    _errorName = json['errorName'];
    _message = json['message'];
  }

  int? _statusCode;
  String? _timestamp;
  String? _path;
  String? _errorName;
  String? _message;

  int? get statusCode => _statusCode;

  String? get timestamp => _timestamp;

  String? get path => _path;

  String? get errorName => _errorName;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['timestamp'] = _timestamp;
    map['path'] = _path;
    map['errorName'] = _errorName;
    map['message'] = _message;
    return map;
  }
}
