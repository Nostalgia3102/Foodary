import 'package:flutter/material.dart';
import 'package:foodary/constants/colors.dart';
import 'package:foodary/constants/strings.dart';
import 'package:foodary/pages/home_page.dart';
import 'package:foodary/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringsAsset.projectName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.treeGreenLight),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const SplashScreen(),
        '/home_page' : (context) => const MyHomePage(title: StringsAsset.projectName,),
      },
    );
  }
}

