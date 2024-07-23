import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodary/data/viewmodels/login_screen_view_model.dart';
import 'package:foodary/data/viewmodels/restaurant_page_view_model.dart';
import 'package:foodary/data/viewmodels/restaurant_personal_page_view_model.dart';
import 'package:foodary/data/viewmodels/signup_screen_view_model.dart';
import 'package:foodary/data/viewmodels/welcome_screen_view_model.dart';
import 'package:foodary/firebase_options.dart';
import 'package:foodary/services/database_service.dart';
import 'package:foodary/services/navigation_service.dart';
import 'package:foodary/utils/constants/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/viewmodels/home_page_view_model.dart';
import '../data/viewmodels/profile_page_view_model.dart';
import '../services/auth_service.dart';

///Instance Registrations
final GetIt getIt = GetIt.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
final appCheck = FirebaseAppCheck.instance;

///Services instances
NavigationService navigationService = getIt.get<NavigationService>();
AuthService authService = getIt.get<AuthService>();
DatabaseServices databaseServices = getIt.get<DatabaseServices>();

///ChangeNotifierProvider Registrations
final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => ProfilePageViewModel()),
  ChangeNotifierProvider(
      create: (context) => RestaurantPersonalPageViewModel()),
  ChangeNotifierProvider(create: (context) => RestaurantPageViewModel()),
  ChangeNotifierProvider(create: (context) => HomePageViewModel()),
  ChangeNotifierProvider(create: (context) => WelcomeScreenViewModel()),
  ChangeNotifierProvider(create: (context) => LoginScreenViewModel()),
  ChangeNotifierProvider(create: (context) => SignUpScreenViewModel()),
];

///Firebase Setup
Future<void> setUpFireBase() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    print("Initializing Firebase...");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized");

    // await FirebaseAppCheck.instance.activate(
    //   androidProvider: AndroidProvider.playIntegrity,
    // );
    // print("App Check activated");
    // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),

    // Fetch and print the App Check token
  //   var appCheckToken = await FirebaseAppCheck.instance.getToken(true);
  //   if (appCheckToken != null && appCheckToken.isNotEmpty) {
  //     print("App Check token: $appCheckToken");
  //   } else {
  //     print("Failed to retrieve App Check token");
  //   }
  } catch (e) {
    print("Error during Firebase setup: $e");
  }
  // appleProvider: AppleProvider.debug,T

  //secret -> DE7565A0-4905-4265-8EE8-BD6EE566ABF8
}

///Service Registrations
Future<void> registerServices() async {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<DatabaseServices>(DatabaseServices());

  debugPrint("Services Registered");
}
