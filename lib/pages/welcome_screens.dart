import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodary/constants/strings.dart';
import 'package:foodary/widgets/window_tile.dart';

class WelcomeScreenPage extends StatefulWidget {
  const WelcomeScreenPage({super.key});

  @override
  State<WelcomeScreenPage> createState() => _WelcomeScreenPageState();
}

class _WelcomeScreenPageState extends State<WelcomeScreenPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                windowTile(context, "assets/images/img.jpg", StringsAsset.quoteOne),
                windowTile(context, "assets/images/imgg.jpg", StringsAsset.quoteTwo),
                windowTile(context, "assets/images/imggg.jpg", StringsAsset.quoteThree),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  height: 10.0,
                  width: _currentPage == index ? 12.0 : 10.0,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.orange : Colors.grey,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: (){

          }, child: const Text(
            StringsAsset.getStarted
          )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
