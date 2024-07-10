import 'package:flutter/material.dart';
import 'package:foodary/utils/constants/colors.dart';
import 'package:provider/provider.dart';

import '../data/models/items.dart';
import '../data/viewmodels/restaurant_personal_page_view_model.dart';
import '../services/upi_payments.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    List<Items> cartItems = [];
    double amount = 0.0;

    return Consumer<RestaurantPersonalPageViewModel>(
      builder: (context, provider, child) {
        for (Items i in provider.listOfItems) {
          if (provider.listOfIds.contains(i.itemsId)) {
            cartItems.add(i);
            amount += i.price * i.count;
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("${arguments['name']}'s Cart"),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Cart Items",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(cartItems[index].name),
                          trailing: Text(
                              "₹${cartItems[index].price} X ${cartItems[index].count} = ₹${cartItems[index].price * cartItems[index].count}"),
                        );
                      }))
            ],
          ),
          bottomSheet: buildBottomSheet(amount),
        );
      },
    );
  }

  BottomSheet buildBottomSheet(double amount) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/upi.jpg",
                        height: 40, width: 40, fit: BoxFit.fill),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("Pay using"),
                            SizedBox(width:MediaQuery.of(context).size.width * .40 ),
                            const Text("Change >", style: TextStyle(
                              color: Colors.deepOrange, fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                        const Text(
                          "Unified Payments Interface",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Assured ₹10 - ₹100 cashback on using \nUPI Services on transactions above ₹150",
                          style: TextStyle(
                            color: AppColor.treeGreenDark,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 3,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElevatedLoginButton(context, amount),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }


  ElevatedButton buildElevatedLoginButton(BuildContext context, double amount) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.deepOrange),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                side: BorderSide(color: Colors.deepOrange)),
          )),
      onPressed: () async {
        UpiPayment.payUsingUpi(amount.toString(), '6283013257@ptsbi', 'Foodary', 'Placing order id - future');
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          "Pay ₹$amount",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}
