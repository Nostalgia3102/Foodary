import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/constants/colors.dart';
import '../utils/utilities.dart';

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
    return Timer(duration, () {
      navigationService.pushReplacementNamed(
          authService.user != null ? "/home_page" : "/welcome_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 60,
          ),
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
          const SizedBox(
            height: 70,
          ),
          const Image(image: AssetImage("assets/images/canvaFoodary.png"))
        ]));
  }
}
