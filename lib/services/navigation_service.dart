import 'package:flutter/material.dart';
import 'package:foodary/ui/sign_up_page.dart';

import '../ui/home_page.dart';
import '../ui/login_screen.dart';
import '../ui/splash_screen.dart';
import '../ui/welcome_screen.dart';

class NavigationService{
  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login_page" : (context) => const LoginScreen(),
    "/sign_up" : (context) => const SignUpScreen(),
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