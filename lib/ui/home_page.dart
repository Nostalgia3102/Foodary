import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/viewmodels/home_page_view_model.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/strings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text(
              StringsAsset.projectName,
              style: TextStyle(
                  color: AppColor.orange,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        blurRadius: 1.0,
                        offset: Offset(2.0, 2.0))
                  ]),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Hello World!"),
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  provider.numbers.length.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              provider.add();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
