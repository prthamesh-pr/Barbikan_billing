// lib/providers/company_provider.dart

import 'package:billing_web/model/company_model.dart';
import 'package:flutter/material.dart';
import '../services/company_service.dart';

class CompanyProvider with ChangeNotifier {
  List<CompanyModel> _companies = [];
  String? errorMessage;
  bool isLoading = false;

  List<CompanyModel> get companies => _companies;

  final CompanyService _service = CompanyService();

  Future<void> fetchCompanies(String token) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getCompanies(token);

    if (response.success == true) {
      _companies = response.data ?? [];
      errorMessage = null;
    } else {
      _companies = [];
      errorMessage = response.message;
    }

    isLoading = false;
    notifyListeners();
  }
}
