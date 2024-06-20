import 'package:flutter/material.dart';
import 'package:foodary/data/viewmodels/welcome_screen_view_model.dart';
import 'package:foodary/widgets/window_tile.dart';
import 'package:provider/provider.dart';
import '../utils/constants/strings.dart';
import '../utils/utilities.dart';

class WelcomeScreenPage extends StatefulWidget {
  const WelcomeScreenPage({super.key});
  @override
  State<WelcomeScreenPage> createState() => _WelcomeScreenPageState();
}

class _WelcomeScreenPageState extends State<WelcomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WelcomeScreenViewModel>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset("assets/images/canvaFoodary.png"),
                Expanded(child: buildPageView(provider, context)),
                buildDotsRow(provider),
                const SizedBox(height: 10),
                (provider.currentPage == 2)
                    ? buildElevatedButton()
                    : const SizedBox(height: 50),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(Colors.deepOrange),
          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(12)),
                side: BorderSide(color: Colors.deepOrange)),
          )),
        onPressed: () {
          navigationService.pushReplacementNamed("/login_page");
        },
        child: const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text(
            StringsAsset.getStarted,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Row buildDotsRow(WelcomeScreenViewModel provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return GestureDetector(
          onTap: () {
            provider.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            height: 10.0,
            width: provider.currentPage == index ? 12.0 : 10.0,
            decoration: BoxDecoration(
              color:
                  provider.currentPage == index ? Colors.deepOrange : Colors.grey,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        );
      }),
    );
  }

  PageView buildPageView(
      WelcomeScreenViewModel provider, BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: provider.pageController,
      onPageChanged: (int page) {
        setState(() {
          provider.currentPage = page;
        });
      },
      children: [
        windowTile(context, "assets/images/img.jpg", StringsAsset.quoteOne),
        windowTile(context, "assets/images/imgg.jpg", StringsAsset.quoteTwo),
        windowTile(context, "assets/images/imggg.jpg", StringsAsset.quoteThree),
      ],
    );
  }
}
