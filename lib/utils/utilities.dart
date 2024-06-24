import 'package:firebase_core/firebase_core.dart';
import 'package:foodary/data/viewmodels/login_screen_view_model.dart';
import 'package:foodary/data/viewmodels/signup_screen_view_model.dart';
import 'package:foodary/data/viewmodels/welcome_screen_view_model.dart';
import 'package:foodary/firebase_options.dart';
import 'package:foodary/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/viewmodels/home_page_view_model.dart';
import '../services/auth_service.dart';

final GetIt getIt = GetIt.instance;
NavigationService navigationService = getIt.get<NavigationService>();
AuthService authService = getIt.get<AuthService>();

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => HomePageViewModel()),
  ChangeNotifierProvider(create: (context) => WelcomeScreenViewModel()),
  ChangeNotifierProvider(create: (context) => LoginScreenViewModel()),
  ChangeNotifierProvider(create: (context) => SignUpScreenViewModel()),
];

Future<void> setUpFireBase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  print("utils --> ${getIt.hashCode}");

  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<NavigationService>(NavigationService());
  // _getIt.registerSingleton<DatabaseServices>(DatabaseServices());

  print("Services Registered");
}