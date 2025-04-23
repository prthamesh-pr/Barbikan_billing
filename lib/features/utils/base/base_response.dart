class BaseResponse<T> {
  T? data;
  String? message;
  int? statusCode;
  bool? success;
  BaseResponse({this.data, this.message, this.success, this.statusCode});
  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) build,
  ) {
    return BaseResponse(
      data: build(json.containsKey('result') ? json['result'] : {}),
      message: json['message'],
      statusCode: json['statusCode'],
      success: json['success'],
    );
  }
}
