import 'package:flutter/material.dart';
import 'package:foodary/constants/colors.dart';
import 'package:foodary/constants/strings.dart';
import 'package:foodary/services/NavigationService.dart';
import 'package:foodary/utils/utilities.dart';
import 'package:foodary/viewmodels/home_page_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

final GetIt _getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpFireBase();
  await registerServices();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late AuthService _authService;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    // _authService = _getIt.get<AuthService>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: StringsAsset.projectName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.treeGreenLight),
          useMaterial3: true,
        ),
        initialRoute: '/',
        navigatorKey: _navigationService.navigatorKey,
        routes: NavigationService().routes,
      ),
    );
  }
}
