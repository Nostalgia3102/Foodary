import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodary/ui/restaurant_page.dart';

class FoodaryPage extends StatefulWidget {
  const FoodaryPage({super.key});

  @override
  State<FoodaryPage> createState() => _FoodaryPageState();
}

class _FoodaryPageState extends State<FoodaryPage> {
  final List<String> bannerList = [
    "https://firebasestorage.googleapis.com/v0/b/foodary-mobile-app.appspot.com/o/homePageBanners%2Ffoodary1.png?alt=media&token=e37bcf69-e6bb-432a-818f-4acb7a24f035",
    "https://firebasestorage.googleapis.com/v0/b/foodary-mobile-app.appspot.com/o/homePageBanners%2Ffoodary2.png?alt=media&token=93a6f687-6194-4133-90d8-68b817094eaa",
    "https://firebasestorage.googleapis.com/v0/b/foodary-mobile-app.appspot.com/o/homePageBanners%2Ffoodary3.png?alt=media&token=58891bfd-4a24-4ced-b6c3-d05861a2913f",
    "https://firebasestorage.googleapis.com/v0/b/foodary-mobile-app.appspot.com/o/homePageBanners%2Ffoodary3.png?alt=media&token=58891bfd-4a24-4ced-b6c3-d05861a2913f"
  ];

  final List<String> listOfMeals = ["Biryani", "Cake", "Milk", "Bread"];
  int _currentIndex = 0;
  Timer? _timer;
  int value = 0;
  String staticImage = "assets/images/snack_time.png";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % listOfMeals.length;
      });
    });

    staticImage = getGreetingMessage();

    // Simulate a delay for loading images
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  String getGreetingMessage() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    int minute = now.minute;

    if (hour >= 4 && (hour < 12 || (hour == 11 && minute < 60))) {
      return "assets/images/good_morning.png";
    } else if (hour >= 12 && (hour < 16 || (hour == 15 && minute < 60))) {
      return "assets/images/lunch_time.png";
    } else if (hour >= 16 && (hour < 19 || (hour == 18 && minute < 30))) {
      return "assets/images/snack_time.png";
    } else {
      return "assets/images/snack_time.png";
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey[900],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 1,
                      height: 22,
                      child: Container(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.mic,
                      color: Colors.deepOrange,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                hintText: "Search for '${listOfMeals[_currentIndex]}'",
                hintStyle: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.normal,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(staticImage),
            const SizedBox(
              height: 12,
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
              height: 350,
              width: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () {
                    cardClicked(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(bannerList[index]),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0.0, 1.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: 4,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Crafted with Efforts at  ",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Image.asset(
                  "assets/images/gn.png",
                  width: 50,
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void cardClicked(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RestaurantPage(),
        ),
      );
    }
  }
}
