import 'dart:convert';
import 'dart:io';

import 'package:billing_web/features/utils/network_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Strings.dart';
import 'api_url.dart';
import 'base/base_response.dart';
import 'base/error_response.dart';
import 'constants.dart';

class ApiUtil {
  static final ApiUtil singleton = ApiUtil._internal();
  static Dio? dio;

  BaseOptions? options;

  CancelToken baseCancelToken = CancelToken();

  factory ApiUtil() {
    return singleton;
  }

  ApiUtil._internal() {
    options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      // connectTimeout: 10000,
      // receiveTimeout: 100000,
      // headers: {"Authorization": Pref.getString(TOKEN)},
      contentType: Headers.jsonContentType,
    );

    dio = Dio(options);

    //dio!.interceptors.add(CookieManager(CookieJar()));

    dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          switch (error.response!.statusCode) {
            case 400:
              return handler.next(error);
            case 401:
              return handler.next(error);
            default:
              return handler.next(error);
          }
        },
      ),
    );
    dio!.interceptors.add(
      LogInterceptor(
        responseBody: true,
        responseHeader: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        error: true,
      ),
    );
  }

  Future cancelRequest({required CancelToken token}) async {
    token.cancel();
    return null;
  }

  String? formatError(DioException e) {
    try {
      // if (e.type == DioErrorType.connectTimeout) {
      //   return Strings.errorConnectionOpenTimeout;
      // } else
      if (e.type == DioExceptionType.sendTimeout) {
        return Strings.errorConnectionOpenTimeout;
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return Strings.errorConnectionReceiveTimeout;
      } else if (e.type == DioExceptionType.cancel) {
        return Strings.errorRequestCancelled;
      }
      // else if (e.type == DioErrorType.badResponse) {
      //   return BaseResponse.fromJson(e.response!.data, (data) => null).message;
      // }
      else {
        return e.message;
      }
    } catch (e) {
      return '$e';
    }
  }

  Future delete({
    required url,
    required data,
    queryParameters,
    options,
    cancelToken,
    required Function success,
    required Function failure,
    Function(int, int)? downloadProgress,
  }) async {
    var connected = await hasInternetConnection();
    if (!connected) {
      return failure(Strings.internetError);
    }
    try {
      Response response = await dio!.delete(
        url,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken ?? baseCancelToken,
      );
      return success(jsonDecode(response.toString()));
    } on DioException catch (error) {
      return failure(formatError(error));
    }
  }

  Future downloadFile({
    required url,
    required savePath,
    cancelToken,
    required Function success,
    required Function failure,
    Function(int, int)? downloadProgress,
  }) async {
    var connected = await hasInternetConnection();
    if (!connected) {
      return failure(Strings.internetError);
    }
    try {
      Response response = await dio!.download(
        url,
        savePath,
        deleteOnError: true,
        cancelToken: cancelToken ?? baseCancelToken,
        onReceiveProgress: downloadProgress,
      );
      return success(response.data);
    } on DioException catch (error) {
      return failure(formatError(error));
    }
  }

  Future get({
    required url,
    queryParameters,
    options,
    cancelToken,
    required Function success,
    required Function failure,
    Function(int, int)? downloadProgress,
  }) async {
    var connected = await hasInternetConnection();
    if (!connected) {
      return failure(Strings.internetError);
    }
    try {
      Response response = await dio!.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? baseCancelToken,
        onReceiveProgress: downloadProgress,
      );
      return success(jsonDecode(response.toString()));
    } on DioException catch (error) {
      return failure(formatError(error));
    }
  }

  Future post({
    required url,
    queryParameters,
    required data,
    options,
    cancelToken,
    required Function success,
    required Function failure,
    Function(int, int)? sendProgress,
    Function(int, int)? downloadProgress,
  }) async {
    var connected = await hasInternetConnection();
    if (!connected) {
      return failure(Strings.internetError);
    }
    try {
      Response response = await dio!.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? baseCancelToken,
        onSendProgress: sendProgress,
        onReceiveProgress: downloadProgress,
      );
      return success(jsonDecode(response.toString()));
    } on DioException catch (error) {
      return failure(formatError(error));
    }
  }

  Future put({
    required url,
    queryParameters,
    required data,
    options,
    cancelToken,
    required Function success,
    required Function failure,
    Function(int, int)? sendProgress,
    Function(int, int)? downloadProgress,
  }) async {
    var connected = await hasInternetConnection();
    if (!connected) {
      return failure(Strings.internetError);
    }
    try {
      Response response = await dio!.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken ?? baseCancelToken,
        onSendProgress: sendProgress,
        onReceiveProgress: downloadProgress,
      );
      return success(jsonDecode(response.toString()));
    } on DioException catch (error) {
      return failure(formatError(error));
    }
  }

  static Future postApiWithBody({
    required String? url,
    required String body,
    required Function success,
    required failure,
    required BuildContext context,
  }) async {
    kPrintLog(url);
    kPrintLog(body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');
    bool connected = await hasInternetConnection();
    if (!connected) {
      return failure(Strings.internetError);
    }
    try {
      var response = await http.post(
        Uri.parse(url!),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );
      Future.delayed(const Duration(seconds: 5), () {});
      kPrintLog("StatusCode:${response.statusCode}");
      kPrintLog('Response:${response.body}');

      statusCode = response.statusCode;

      String responseBody = response.body;

      responseBody = responseBody.replaceAll(RegExp(r'\{"d":null\}$'), '');
      if (response.statusCode == 200 || response.statusCode == 201) {
        // if (response.body.contains('SessionTimeOut')) {
        //   CustomToast().showCustomToast(
        //     type: SnackBarType.error,
        //     message: "SessionTimeOut",
        //   );
        //   AppFunctions().resetAllProviders(context);
        //   NavigateToPage.pushNamedReplacement(context, LoginScreen.routeName);
        // }
        return success(responseBody);
      } else if (response.statusCode == 302) {
        return failure("Session Expired");
      } else {
        var decoded = jsonDecode(response.body);
        BaseResponse res = BaseResponse.fromJson(decoded, (data) => null);
        if (res.statusCode! == 401) {
          return failure("Invalid credentials");
        }
        //   else{
        //   return failure(res.message ?? ""); /*}*/
        // }
      }
    } on Exception catch (e) {
      kPrintLog("Exception:${e.toString()}");
      return failure(Strings.defaultExceptionMessage);
    }
  }

  static int statusCode = 200;

  static Future getApi({
    required url,
    required Function success,
    required failure,
  }) async {
    kPrintLog(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');
    bool connected = await hasInternetConnection();
    if (!connected) {
      return failure(Strings.internetError);
    }
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      Future.delayed(Duration(seconds: 3), () {});
      kPrintLog("StatusCode:${response.statusCode}");
      statusCode = response.statusCode;
      kPrintLog("StatusCode---${response.body}");
      if (response.statusCode == 200) {
        return success(response);
      } else {
        var decoded = jsonDecode(response.body);
        BaseResponse res = BaseResponse.fromJson(decoded, (data) => null);
        if (res.statusCode! == 401) {
          return failure("Invalid data");
        }
      }
    } on Exception catch (e) {
      kPrintLog("Exception:${e.toString()}");
      return failure(Strings.defaultExceptionMessage);
    }
  }

  static Future postApiWithMultipart({
    required String? url,
    required Function success,
    required failure,
    required File file,
  }) async {
    kPrintLog(url);

    bool connected = await hasInternetConnection();
    if (!connected) {
      return failure(Strings.internetError);
    }
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url!));

      request.headers.addAll({"Content-Type": "application/json"});

      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          File(file.path).readAsBytesSync(),
          filename: file.path.split("/").last,
        ),
      );

      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);
      Future.delayed(Duration(seconds: 5), () {});
      kPrintLog("StatusCode:${response.statusCode}");

      kPrintLog('Response:${response.body}');
      statusCode = response.statusCode;
      if (response.statusCode == 200 || response.statusCode == 201) {
        return success(response);
      } else if (response.statusCode == 302) {
        return failure("Session Expired");
      } else {
        var decoded = jsonDecode(response.body);
        // BaseResponse res = BaseResponse.fromJson(decoded, (data) => null);
        /* if(res.statusCode! == 401){
          return failure(Strings.errorMessage401?? "");
        }
        else{*/
        // return failure(res.message ?? ""); /*}*/
      }
    } on Exception catch (e) {
      kPrintLog("Exception:${e.toString()}");
      return failure(Strings.defaultExceptionMessage);
    }
  }

  static Future postApiWithMultipartFile({
    required String? url,
    required Function success,
    required failure,
    required List<File> fileList,
  }) async {
    kPrintLog("$url");

    bool connected = await hasInternetConnection();

    if (!connected) {
      return failure(Strings.internetError);
    }
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url!));

      request.fields['photo[]'] = 'fileList';

      request.headers.addAll({"Content-Type": "image/jpg"});

      for (int i = 0; i < fileList.length; i++) {
        kPrintLog("file path 2------:${fileList[i].path}");
        request.files.add(
          http.MultipartFile.fromBytes(
            "photo[]",
            File(fileList[i].path).readAsBytesSync(),
            filename: fileList[i].path.split("/").last,
            contentType: MediaType('jpg', 'png'),
          ),
        );
      }
      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);
      Future.delayed(const Duration(seconds: 5), () {});
      kPrintLog("StatusCode:${response.statusCode}");

      kPrintLog('Response:${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return success(response);
      } else if (response.statusCode == 302) {
        return failure("Session Expired");
      } else {
        var decoded = jsonDecode(response.body);
        ErrorResponse res = ErrorResponse.fromJson(decoded);
        return failure(res.message ?? "");
      }
    } on Exception catch (e) {
      kPrintLog("Exception:${e.toString()}");
      return failure(e);
    }
  }
}
