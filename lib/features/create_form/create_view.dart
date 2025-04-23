import 'package:flutter/material.dart';

import '../config.dart';



class CreationView extends StatefulWidget {
  const CreationView({super.key});

  @override
  State<CreationView> createState() => _CreationViewState();
}

class _CreationViewState extends State<CreationView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: OutlineInputBorder(borderSide: BorderSide.none),
      width: MediaQuery.of(context).size.width * 0.4,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: creationPageConfig.currenPage,
    );
  }
}
