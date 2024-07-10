import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodary/data/viewmodels/restaurant_page_view_model.dart';
import 'package:provider/provider.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key});

  Future<List<DocumentSnapshot>> fetchDocuments(List<String> docIds) async {
    List<DocumentSnapshot> documents = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (String docId in docIds) {
      DocumentSnapshot doc =
          await firestore.collection('vendors').doc(docId).get();
      if (doc.exists) {
        documents.add(doc);
      }
    }
    return documents;
  }

  @override
  Widget build(BuildContext context) {
    print("Restaurant page says Hi");
    return Consumer<RestaurantPageViewModel>(
        builder: (context, provider, child) {
      print(provider.numberOfListOfRestaurants);
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            "Restaurants to Explore",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<DocumentSnapshot>>(
            future: fetchDocuments(provider.vendorIds ?? []),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No Documents Found'));
              } else {
                return ListView.builder(
                    itemCount: provider.numberOfListOfRestaurants,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data![index];
                      return ListTile(
                        style: ListTileStyle.drawer,
                        onTap: (){
                          Navigator.pushNamed(context, "/restaurant_personal_page",arguments: {"name" :
                          document['name'], "description": document['description'], "vendorId" : document['vendorId']});
                        },
                        titleAlignment: ListTileTitleAlignment.titleHeight,
                        enabled: true,
                        minTileHeight: MediaQuery.of(context).size.height * .15,
                        contentPadding: const EdgeInsets.all(8.0),
                        leading: Image.network(document['image'], height: 60, width: 60, fit: BoxFit.fill,),
                        title: Text(document['name']),
                        subtitle: Text(
                          document['description'],
                          maxLines: 2,
                        ),
                      );
                    });
              }
            },
          ),
        ),
      );
    });
  }
}
