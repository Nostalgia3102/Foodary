import 'package:flutter/material.dart';
import 'package:foodary/pages/home_page.dart';
import 'package:foodary/pages/splash_screen.dart';
import 'package:foodary/pages/welcome_screens.dart';

class NavigationService{
  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    // "/login" : (context) => const LoginPage(),
    // "/register" : (context) => const RegisterPage(),
    "/home_page" : (context) => const MyHomePage(),
    "/welcome_page": (context) => const WelcomeScreenPage(),
    "/": (context) => const SplashScreen()
  };

  GlobalKey<NavigatorState>? get navigatorKey{
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  NavigationService(){
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void push(MaterialPageRoute route){
    _navigatorKey.currentState?.push(route);
  }

  void pushNamed(String routeName){
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName){
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack(){
    _navigatorKey.currentState?.pop();
  }

}