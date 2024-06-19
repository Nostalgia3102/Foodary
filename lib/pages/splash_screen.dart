import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodary/constants/colors.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/home_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height:70,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animations/loginAnimTwo.json",
                width: 320,
                height: 320,
              ),
            ],
          ),
          const SizedBox(height: 70,),
          const Image(image: AssetImage("assets/images/canvaFoodary.png"))
        ]));
  }
}
