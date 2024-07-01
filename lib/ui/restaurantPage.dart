import 'package:flutter/material.dart';
import 'package:foodary/data/viewmodels/restaurant_page_view_model.dart';
import 'package:provider/provider.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {


  @override
  Widget build(BuildContext context) {
    print("hiii");
    return Consumer<RestaurantPageViewModel>(
  builder: (context, provider, child) {
    print(provider.numberOfListOfRestaurants);
  return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Restaurants to Explore", style: TextStyle(
            fontWeight: FontWeight.bold, fontStyle: FontStyle.italic
        ),
        ),
      ),
      body: ListView.builder(itemCount: provider.numberOfListOfRestaurants, itemBuilder: (_, index) => ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        enabled: true,
        minTileHeight: MediaQuery.of(context).size.height * .15,
        contentPadding: const EdgeInsets.all(8.0),
        leading: Image.asset("assets/images/imggg.jpg", height: MediaQuery.of(context).size.height * .15, width: MediaQuery.of(context).size.width * .2, fit: BoxFit.fill,),
        title: Text("Restaurant name + $index"),
        subtitle: Text("description of the restaurant with index $index"),
      ),),
    );
  },
);
  }
}
