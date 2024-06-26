import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodary/data/models/user_profile.dart';

class Items{
  Id vendorId;
  String name;
  String description;
  int price;
  String category;
  String imageUrl;
  bool available;
  Timestamp createdAt;
  Timestamp updatedAt;
  String itemsId;

  Items({
    required this.vendorId,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.available,
    required this.createdAt,
    required this.updatedAt,
    required this.itemsId,
  });

  factory Items.fromMap(Map<String, dynamic> json) => Items(
    vendorId: Id.fromMap(json["vendorId"]),
    name: json["name"],
    description: json["description"],
    price: json["price"],
    category: json["category"],
    imageUrl: json["imageUrl"],
    available: json["available"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    itemsId: json["itemsId"],
  );

  Map<String, dynamic> toMap() => {
    "vendorId": vendorId.toMap(),
    "name": name,
    "description": description,
    "price": price,
    "category": category,
    "imageUrl": imageUrl,
    "available": available,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "itemsId": itemsId,
  };
}