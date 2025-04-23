// lib/services/company_service.dart

import 'dart:convert';
import 'package:billing_web/model/company_model.dart';
import 'package:billing_web/model/api_response.dart';
import 'package:http/http.dart' as http;

class CompanyService {
  final String _url = 'https://your-api-url.com/api/companies';

  Future<ApiResponse<List<CompanyModel>>> getCompanies(String token) async {
    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final int statusCode = response.statusCode;

      if (statusCode == 200) {
        final Map<String, dynamic> decoded = json.decode(response.body);

        final companiesJson = decoded['data']['companies'] as List;

        final companies =
            companiesJson.map((json) => CompanyModel.fromJson(json)).toList();

        return ApiResponse<List<CompanyModel>>(
          statusCode: statusCode,
          success: decoded['success'],
          message: decoded['message'],
          data: companies,
        );
      } else {
        return ApiResponse<List<CompanyModel>>(
          statusCode: statusCode,
          success: false,
          message: 'Failed to load companies',
          data: [],
        );
      }
    } catch (e) {
      return ApiResponse<List<CompanyModel>>(
        statusCode: 500,
        success: false,
        message: 'Error: $e',
        data: [],
      );
    }
  }
}
