
import 'package:billing_web/features/company/viewModels/companyProvider.dart';
import 'package:billing_web/features/user_access/viewModel/userAccess_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/Forgot_password/viewModel/RecoveryPassword_Provider.dart';
import 'features/Log_In/view/login_screen.dart';
import 'features/Log_In/viewModel/login_provider.dart';
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
          //  ChangeNotifierProvider(create: (context) => FirstScreenProvider()),
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
