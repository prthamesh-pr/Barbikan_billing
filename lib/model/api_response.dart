class ApiResponse<T> {
  int statusCode;
  String message;
  bool success;
  T? data;

  ApiResponse({
    required this.statusCode,
    required this.message,
    required this.success,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse<T>(
      statusCode: json['statusCode'],
      message: json['message'],
      success: json['success'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(dynamic Function(T? value)? toJsonT) {
    return {
      'statusCode': statusCode,
      'message': message,
      'success': success,
      'data': data != null && toJsonT != null ? toJsonT(data) : null,
    };
  }
}
