
class ApiUrl{

  static  String baseUrl = 'https://billing-backend-l9z5.onrender.com/api';
  static  String? login = '$baseUrl/auth/login';
  static  String? userAccess = '$baseUrl/users';
  static  String? addCompany = '$baseUrl/companies';

  //static  String? userAccess = '$baseUrl/users';
  static  String? userUpdate({required String id}) => '$baseUrl/users/$id';

}