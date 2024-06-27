import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodary/ui/foodary_page.dart';
import 'package:foodary/ui/grocery_page.dart';
import 'package:foodary/ui/reorder_page.dart';
import 'package:foodary/ui/tiffin_service_page.dart';
import 'package:foodary/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../data/viewmodels/home_page_view_model.dart';

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
            systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.black, // Navigation bar
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarContrastEnforced: true),// Status bar
            backgroundColor: Colors.transparent,
           leadingWidth: MediaQuery.of(context).size.width * 0.7,
           leading: const Padding(
             padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     Icon(Icons.double_arrow_rounded, color: Colors.deepOrange, ),
                     Text("Office", style: TextStyle(
                       color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18
                     ),),
                     Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,),
                   ],
                 ),
                 Text("Ground Floor, Sector 67, Sahibza..."),
               ],
             ),
           ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    size: 20,
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,14,0),
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
                      Icons.person_2_rounded,
                      color: Colors.black,
                    )),
              )
            ],
          ),
          body:IndexedStack(
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
            selectedIconTheme: const IconThemeData(
              color: Colors.deepOrange
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood),
                label: 'Foodary',
                tooltip: "Foodary Icon",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit),
                label: 'Tiffin-Service',
                tooltip: "Tiffin-Service Icon"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_grocery_store),
                label: 'Grocery',
                  tooltip: "Grocery Icon"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Reorder',
                  tooltip: "Reorder Icon"
              ),
            ],
            currentIndex: provider.selectedIndex,
            selectedItemColor: Colors.deepOrange,
            onTap:  (index) =>
              setState(() {
                provider.selectedIndex = index;
              }),
          ),
        );
      },
    );
  }
}
