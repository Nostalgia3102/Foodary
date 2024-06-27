import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FoodaryPage extends StatefulWidget {
  const FoodaryPage({super.key});

  @override
  State<FoodaryPage> createState() => _FoodaryPageState();
}

class _FoodaryPageState extends State<FoodaryPage> {

  String urlBannerOne = "https://firebasestorage.googleapis.com/v0/b/foodary-mobile-app.appspot.com/o/homePageBanners%2Fgood_morning.png?alt=media&token=9e62a300-867f-404f-9a70-1046e278e3c2";

  final List<String> bannerList = [
    "https://firebasestorage.googleapis.com/v0/b/foodary-mobile-app.appspot.com/o/homePageBanners%2Ffoodary1.png?alt=media&token=e37bcf69-e6bb-432a-818f-4acb7a24f035",
    "https://firebasestorage.googleapis.com/v0/b/foodary-mobile-app.appspot.com/o/homePageBanners%2Ffoodary2.png?alt=media&token=93a6f687-6194-4133-90d8-68b817094eaa",
    "https://firebasestorage.googleapis.com/v0/b/foodary-mobile-app.appspot.com/o/homePageBanners%2Ffoodary3.png?alt=media&token=58891bfd-4a24-4ced-b6c3-d05861a2913f",
    "https://firebasestorage.googleapis.com/v0/b/foodary-mobile-app.appspot.com/o/homePageBanners%2Ffoodary3.png?alt=media&token=58891bfd-4a24-4ced-b6c3-d05861a2913f"
  ];

  final List<String> listOfMeals = ["Biryani", "Cake", "Milk", "Bread"];
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % listOfMeals.length;
      });
    });
    loadImages();
  }

  Future<void> loadImages() async{
    try{
      final ref = FirebaseStorage.instance.ref().child('homePageBanners/lunch_time.png');
      urlBannerOne = await ref.getDownloadURL();
      debugPrint("THE URL IS ---->> $urlBannerOne");
    }catch(e){
      print(e);
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
                          color: Colors.grey[800], fontWeight: FontWeight.normal),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 20,
                ),
                // FutureBuilder(
                //   future: loadImages(),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return CircularProgressIndicator();
                //     } else if (snapshot.hasError) {
                //       return Text("Error loading image");
                //     } else {
                //       return Image.network(url_banner_one ?? "");
                //     }
                //   },
                // ),
                Image.network(
                    urlBannerOne),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 350,
                  width: 350,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (_, index) => Container(
                      // padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(bannerList[index])),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,// blur radius
                          )
                        ]
                      ),
                      // child: Image.network(
                      //   bannerList[index],
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    itemCount: 4,
                  ),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Crafted with Efforts at  ", style: TextStyle(
                      color: Colors.grey[600], fontWeight: FontWeight.bold, fontStyle: FontStyle.italic
                    ),),
                    Image.asset("assets/images/gn.png", width: 50,height: 30,)
                  ],
                )
              ],
            )));
  }
}
