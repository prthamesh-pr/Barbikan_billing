
import 'package:billing_web/PlayArea_Screens/Badminton/viewModel/PlayAreaProvider.dart';
import 'package:billing_web/PlayArea_Screens/Badminton/viewModel/badminton_provider.dart';
import 'package:billing_web/PlayArea_Screens/Football/viewModel/football_provider.dart';
import 'package:billing_web/PlayArea_Screens/TableTenis/viewModel/table_tennis_provider.dart';
import 'package:billing_web/PlayArea_Screens/dashBoard/viewModel/PlayArea_dashBoard_provider.dart';
import 'package:billing_web/features/company/viewModels/companyProvider.dart';
import 'package:billing_web/features/dashboard/viewModel/dashboard_provider.dart';
import 'package:billing_web/features/invoice/viewModel/invoice_provider.dart';
import 'package:billing_web/features/party/customer/viewModel/customer_provider.dart';
import 'package:billing_web/features/product/viewModel/products_provider.dart';
import 'package:billing_web/features/party/purchase_party/viewModel/purchaseParty_list_provider.dart';
import 'package:billing_web/features/purchase_list/viewModel/purchaseBill_list_provider.dart';
import 'package:billing_web/features/sales/viewModel/salesProvider.dart';
import 'package:billing_web/features/user_access/viewModel/userAccess_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/Forgot_password/viewModel/RecoveryPassword_Provider.dart';
import 'features/Log_In/view/login_screen.dart';
import 'features/Log_In/viewModel/login_provider.dart';
import 'features/category/viewModel/cetegory_provider.dart';
import 'features/stock/viewModel/stock_provider.dart';
import 'features/utils/preference/preference.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Pref.sharedPref = await SharedPreferences.getInstance();

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LoginProvider()),
            ChangeNotifierProvider(create: (context) => RecoveryPasswordProvider()),
            ChangeNotifierProvider(create: (context) => UserAccessProvider()),
            ChangeNotifierProvider(create: (context) => CompanyProvider()),
            ChangeNotifierProvider(create: (context) => PurchasePartyListProvider()),
            ChangeNotifierProvider(create: (context) => CustomerProvider()),
            ChangeNotifierProvider(create: (context) => ProductsProvider()),
            ChangeNotifierProvider(create: (context) => CategoryProvider()),
            ChangeNotifierProvider(create: (context) => PurchaseListProvider()),
            ChangeNotifierProvider(create: (context) => StockProvider()),
            ChangeNotifierProvider(create: (context) => SalesProvider()),
            ChangeNotifierProvider(create: (context) => InvoiceProvider()),
            ChangeNotifierProvider(create: (context) => DashBoardProvider()),
            ChangeNotifierProvider(create: (context) => CricketProvider()),
            ChangeNotifierProvider(create: (context) => BadmintonProvider()),
            ChangeNotifierProvider(create: (context) => FootballProvider()),
            ChangeNotifierProvider(create: (context) => TableTennisProvider()),
            ChangeNotifierProvider(create: (context) => PlayAreaDashBoardProvider()),
          ],
          child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Barbikan Billing',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xff1D1616),
          seedColor: Color(0xffb23b3b),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
