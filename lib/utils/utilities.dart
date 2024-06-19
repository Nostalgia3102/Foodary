import 'package:firebase_core/firebase_core.dart';
import 'package:foodary/firebase_options.dart';
import 'package:foodary/services/NavigationService.dart';
import 'package:foodary/viewmodels/home_page_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final GetIt _getIt = GetIt.instance;
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context)=>HomePageViewModel())
];

Future<void> setUpFireBase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  print("utils --> ${_getIt.hashCode}");

  // _getIt.registerSingleton<AuthService>(AuthService());
  _getIt.registerSingleton<NavigationService>(NavigationService());
  // _getIt.registerSingleton<DatabaseServices>(DatabaseServices());

  print("Services Registered");
}