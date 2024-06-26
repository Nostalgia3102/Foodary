import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class Vendors {
  Timestamp createdAt;
  String address;
  String phone;
  String name;
  int rating;
  String category;
  Timestamp updatedAt;
  Location location;
  String vendorId;

  Vendors({
    required this.createdAt,
    required this.address,
    required this.phone,
    required this.name,
    required this.rating,
    required this.category,
    required this.updatedAt,
    required this.location,
    required this.vendorId,
  });

  factory Vendors.fromMap(Map<String, dynamic> json) => Vendors(
    createdAt: json["createdAt"],
    address: json["address"],
    phone: json["phone"],
    name: json["name"],
    rating: json["rating"],
    category: json["category"],
    updatedAt: json["updatedAt"],
    location: json["location"],
    vendorId: json["vendorId"],
  );

  Map<String, dynamic> toMap() => {
    "createdAt": createdAt,
    "address": address,
    "phone": phone,
    "name": name,
    "rating": rating,
    "category": category,
    "updatedAt": updatedAt,
    "location": location,
    "vendorId": vendorId,
  };
}
