import 'package:flutter/material.dart';
import 'package:foodary/services/navigation_service.dart';
import 'package:foodary/utils/constants/strings.dart';
import 'package:foodary/utils/utilities.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: StringsAsset.projectName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        initialRoute: '/',
        navigatorKey: navigationService.navigatorKey,
        routes: NavigationService().routes,
      ),
    );
  }
}
