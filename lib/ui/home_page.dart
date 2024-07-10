import 'dart:convert';
import 'package:foodary/data/viewmodels/restaurant_page_view_model.dart';
import 'package:foodary/utils/constants/strings.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodary/ui/fragments/foodary_page.dart';
import 'package:foodary/ui/fragments/grocery_page.dart';
import 'package:foodary/ui/fragments/reorder_page.dart';
import 'package:foodary/ui/fragments/tiffin_service_page.dart';
import 'package:foodary/utils/utilities.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../data/viewmodels/home_page_view_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final locationController = Location();
  // final restaurantPageViewModel = RestaurantPageViewModel();

  Future<void> fetchLocationUpdates() async {
    debugPrint("Inside the Location Function");

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final currentLocation = await locationController.getLocation();

    debugPrint("LOCATION");
    debugPrint(currentLocation.toString());

    try {
      ///for local host use Uri.http and for ngrok use Uri.https
      var url = Uri.https(
          StringsAsset.ngrokUrl, StringsAsset.locationApi, {'q': '{http}'});
      final result = await http.post(url,
          headers: {'Content-Type': 'application/json'}, // Set the content type
          body: jsonEncode({
            'lat': currentLocation.latitude.toString(),
            'long': currentLocation.longitude.toString()
          }));

      print('Status code: ${result.statusCode}');
      print('Response body: ${result.body.toString()}');

      final data = await jsonDecode(result.body);

      // Access the listOfRestaurants from the response
      List<dynamic> listOfRestaurants = data['listOfRestaurants'];

      // Print the list of restaurants for debugging
      print('List of Restaurants: $listOfRestaurants');
      print('List of Restaurants: ${listOfRestaurants.length}');

      final restaurantPageViewModel = Provider.of<RestaurantPageViewModel>(context, listen: false);

      restaurantPageViewModel.numberOfListOfRestaurants = listOfRestaurants.length;
      print("number");
      print(restaurantPageViewModel.numberOfListOfRestaurants);
      List<String> stringList = listOfRestaurants.map((element) => element.toString()).toList();
      restaurantPageViewModel.vendorIds = stringList;

      if (data['status-code'] != "200") {
        // Assuming the status code is 'status-code'
        throw 'An unexpected error occurred!';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.black, // Navigation bar
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarContrastEnforced: true),
            // Status bar
            backgroundColor: Colors.transparent,
            leadingWidth: MediaQuery
                .of(context)
                .size
                .width * 0.7,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      fetchLocationUpdates();
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.double_arrow_rounded,
                          color: Colors.deepOrange,
                        ),
                        Text(
                          "Office",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const Text("Ground Floor, Sector 67, Sahibza..."),
                ],
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    size: 20,
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                child: IconButton(
                    onPressed: () async {
                      try {
                        bool result = await authService.logout();
                        if (result) {
                          navigationService.pushReplacementNamed("/login_page");
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    )),
              )
            ],
          ),
          body: IndexedStack(
            index: provider.selectedIndex,
            children: const [
              FoodaryPage(),
              TiffinServicePage(),
              GroceryPage(),
              ReorderPage()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedIconTheme: const IconThemeData(color: Colors.deepOrange),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: 'Foodary',
                tooltip: "Foodary Icon",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.ac_unit),
                  label: 'Tiffin-Service',
                  tooltip: "Tiffin-Service Icon"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_grocery_store),
                  label: 'Grocery',
                  tooltip: "Grocery Icon"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Reorder',
                  tooltip: "Reorder Icon"),
            ],
            currentIndex: provider.selectedIndex,
            selectedItemColor: Colors.deepOrange,
            onTap: (index) =>
                setState(() {
                  provider.selectedIndex = index;
                }),
          ),
        );
      },
    );
  }
}
