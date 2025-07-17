import 'package:flutter/material.dart';

import 'view/landing_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      home: SafeArea(child: const LandingView()),
    );
  }
}
