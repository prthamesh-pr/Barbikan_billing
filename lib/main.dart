import 'package:billing_web/view/Forgot_password/viewModel/RecoveryPassword_Provider.dart';
import 'package:billing_web/view/Log_In/viewModel/login_provider.dart';
import 'package:billing_web/view/Log_In/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/landing_view.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LoginProvider()),
            ChangeNotifierProvider(create: (context) => RecoveryPasswordProvider()),
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
