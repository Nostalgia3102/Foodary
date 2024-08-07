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
        initialRoute:"/",
        navigatorKey: navigationService.navigatorKey,
        routes: NavigationService().routes,
      ),
    );
  }
}


//Installed Shorebird for no update code changes
//using Sliver App Bar for dynamic App bar
//using Shimmer for the loading effect
//How to access internet without any package ?
// Android & iOS -> Http Client
// Web -> Http Request
// and in flutter : http package does this task for us.
//In Native Android -> with library : Volley , Retrofit | without library : HTTPUrl Connectivity