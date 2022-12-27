import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

Timer(Duration(seconds: 3),()=>Get.offNamed('/home'),);

    return SafeArea(child: Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 150,
        ),
      ),
    ),);
  }
}
