
import 'package:flutter/cupertino.dart';

class CompanyProvider extends ChangeNotifier{

  final List<Map<String, dynamic>> companyList = [
    {
      'sno': 1,
      'companyName': 'ABC Pvt Ltd',
      'gst': '29ABCDE1234F1Z5',
      'mobile': '9876543210',
    },
    {
      'sno': 2,
      'companyName': 'XYZ Corp',
      'gst': '27XYZDE5678G1Z3',
      'mobile': '9876543211',
    },
    {
      'sno': 3,
      'companyName': 'LMN Ltd',
      'gst': '30LMNDE9101H1Z7',
      'mobile': '9876543212',
    },
  ];
}