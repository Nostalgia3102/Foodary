import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodary/data/viewmodels/login_screen_view_model.dart';
import 'package:foodary/data/viewmodels/signup_screen_view_model.dart';
import 'package:foodary/data/viewmodels/welcome_screen_view_model.dart';
import 'package:foodary/firebase_options.dart';
import 'package:foodary/services/database_service.dart';
import 'package:foodary/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/viewmodels/home_page_view_model.dart';
import '../services/auth_service.dart';


///Instance Registrations
final GetIt getIt = GetIt.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


///Services instances
NavigationService navigationService = getIt.get<NavigationService>();
AuthService authService = getIt.get<AuthService>();
DatabaseServices databaseServices = getIt.get<DatabaseServices>();


///ChangeNotifierProvider Registrations
final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => HomePageViewModel()),
  ChangeNotifierProvider(create: (context) => WelcomeScreenViewModel()),
  ChangeNotifierProvider(create: (context) => LoginScreenViewModel()),
  ChangeNotifierProvider(create: (context) => SignUpScreenViewModel()),
];


///Firebase Setup
Future<void> setUpFireBase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}


///Service Registrations
Future<void> registerServices() async {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<DatabaseServices>(DatabaseServices());

  debugPrint("Services Registered");
}