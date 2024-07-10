import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodary/data/models/items.dart';
import 'package:foodary/data/viewmodels/restaurant_personal_page_view_model.dart';
import 'package:provider/provider.dart';

import '../data/models/pairs.dart';
import '../utils/constants/colors.dart';

class RestaurantPersonalPage extends StatefulWidget {
  const RestaurantPersonalPage({super.key});

  @override
  State<RestaurantPersonalPage> createState() => _RestaurantPersonalPageState();
}

class _RestaurantPersonalPageState extends State<RestaurantPersonalPage> {
  Future<void> fetchData(BuildContext context) async {
    RestaurantPersonalPageViewModel restaurantPersonalPageViewModel =
        Provider.of<RestaurantPersonalPageViewModel>(context, listen: false);

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot doc =
        await firestore.collection('vendors').doc(arguments['vendorId']).get();

    List<Items> menuList = [];

    if (doc.exists) {
      print("inside IF statement");
      DocumentReference ref = doc['itemsId'];
      DocumentSnapshot refDoc = await ref.get();

      if (refDoc.exists) {
        try {
          Map<String, dynamic>? data = refDoc.data() as Map<String, dynamic>;
          var vendorsItems = data['vendorsItems'] as List<dynamic>;

          for (var item in vendorsItems) {
            Items i = Items(
                name: item['name'],
                description: item['description'],
                price: item['price'],
                category: item['category'],
                imageUrl: item['imageUrl'],
                available: item['available'],
                createdAt: item['createdAt'],
                updatedAt: item['updatedAt'],
                itemsId: item['itemsId']);
            menuList.add(i);
          }
        } catch (e) {
          print(e);
        }
      } else {
        debugPrint("No vendorsItems found in the document");
      }
    } else {
      debugPrint("Referenced document does not exist");
    }
    restaurantPersonalPageViewModel.listOfItems = menuList;
  }



  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Consumer<RestaurantPersonalPageViewModel>(
      builder: (context, provider, child) {
        if (provider.visitingFirstTime) {
          print("mai run hua - visitingfirsttime");
          provider.visitingFirstTime = !provider.visitingFirstTime;
          fetchData(context);
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    arguments['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  const Text("Healthy | Salad | Fast Food"),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "3.4",
                        style: TextStyle(
                          backgroundColor: AppColor.darkGreen,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "1.4K ratings",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("14 min . "),
                      SizedBox(width: 10),
                      Text("1 Km  | "),
                      SizedBox(width: 10),
                      Text("Sector 67 "),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Menu",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 22),
                  ),
                  SizedBox(
                    height: 800, // Adjust the height as needed
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.listOfItems.length,
                      itemBuilder: (context, index) {
                        // debugPrint("The value in count is ${provider.listOfItems[index].count}");
                        return ListTile(
                          leading: Image.network(
                            provider.listOfItems[index].imageUrl,
                            width: 40,
                            height: 40,
                          ),
                          title: Text(
                            provider.listOfItems[index].name,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            provider.listOfItems[index].description.toString(),
                            maxLines: 1,
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "₹ ${provider.listOfItems[index].price.toString()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                  height: 20,
                                  child: (provider.listOfItems[index].count > 0)
                                      ? buildRowPlusMinus(provider, index)
                                      : GestureDetector(
                                          onTap: () {
                                            provider.listOfItems[index].count++;
                                            provider.numberOfItemsInCart++;
                                            if (!provider.listOfIds.contains(
                                                provider.listOfItems[index]
                                                    .itemsId)) {
                                              provider.listOfIds.add(provider
                                                  .listOfItems[index].itemsId);
                                            }
                                            provider.setState();
                                            debugPrint(
                                                "The value in count is (add)${provider.listOfItems[index].count}");
                                          },
                                          child: (provider.listOfItems[index]
                                                      .count ==
                                                  0)
                                              ? const Text("Add + ",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.deepOrange))
                                              : buildRowPlusMinus(
                                                  provider, index),
                                        ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: (provider.numberOfItemsInCart > 0)
              ? buildBottomSheetWithGestureDetector(provider, context, arguments)
              : const SizedBox.shrink(),
        );
      },
    );
  }

  GestureDetector buildBottomSheetWithGestureDetector(RestaurantPersonalPageViewModel provider, BuildContext context, Map<dynamic, dynamic> arguments) {
    return GestureDetector(
                onTap: () {
                  print(provider.numberOfItemsInCart);
                  Navigator.pushNamed(context, "/cart_screen", arguments: {
                    "name": arguments['name'],
                    "description": arguments['description'],
                    "vendorId": arguments['vendorId']
                  });
                },
                child: BottomSheet(
                    backgroundColor: AppColor.treeGreenDark,
                    enableDrag: false,
                    onClosing: () {},
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            (provider.numberOfItemsInCart > 1)
                                ? Text(
                                    "${provider.numberOfItemsInCart} Items added ",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "${provider.numberOfItemsInCart} Item added ",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),
                                  ),
                            const Text(
                              "View Cart >",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }),
              );
  }

  Row buildRowPlusMinus(RestaurantPersonalPageViewModel provider, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () {
              if (provider.listOfItems[index].count > 0) {
                if (provider.listOfItems[index].count == 1) {
                  ///delete this item
                  provider.listOfIds.remove(provider.listOfItems[index].itemsId);
                }
                provider.listOfItems[index].count--;
                provider.numberOfItemsInCart--;

                provider.setState();
                debugPrint(
                    "The value in count is -- ${provider.listOfItems[index].count}");
              }
            },
            icon: const Icon(
              Icons.remove,
              size: 10,
              color: Colors.black,
            )),
        Text(provider.listOfItems[index].count.toString()),
        IconButton(
            onPressed: () {
              print("My Index Number is $index");

              provider.listOfItems[index].count++;
              provider.numberOfItemsInCart++;

              provider.setState();
              debugPrint(
                  "The value in count is ++ ${provider.listOfItems[index].count}");

              provider.setState();
              debugPrint(
                  "The value in count is ++ ${provider.listOfItems[index].count}");
            },
            icon: const Icon(
              Icons.add,
              size: 10,
              color: Colors.black,
            ))
      ],
    );
  }
}
