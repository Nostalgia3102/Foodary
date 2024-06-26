import 'package:cloud_firestore/cloud_firestore.dart';
import 'address.dart';
import 'order_history.dart';

class UserProfile {
  String usersId;
  String name;
  String phone;
  List<OrderHistory> orderHistory;
  String email;
  String image;
  List<Address> address;
  Timestamp createdAt;
  Timestamp updatedAt;

  UserProfile(
      {required this.usersId,
      required this.name,
      required this.phone,
      required this.email,
      required this.address,
      required this.createdAt,
      required this.image,
      required this.orderHistory,
      required this.updatedAt});


  factory UserProfile.fromMap(Map<String, dynamic> json) => UserProfile(
    phone: json["phone"],
    name: json["name"],
    orderHistory: List<OrderHistory>.from(json["orderHistory"].map((x) => OrderHistory.fromMap(x))).toList(),
    email: json["email"],
    image: json["image"],
    address: List<Address>.from(json["address"].map((x) => Address.fromMap(x))).toList(),
    createdAt:json["createdAt"],
    updatedAt: json["updatedAt"],
    usersId: json["usersId"],
  );

  Map<String, dynamic> toMap() => {
    "phone": phone,
    "name": name,
    "orderHistory": List<dynamic>.from(orderHistory.map((x) => x.toMap())),
    "email": email,
    "image": image,
    "address": List<dynamic>.from(address.map((x) => x.toMap())),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "usersId": usersId,
  };
}

class Id {
  String datatype;
  String value;

  Id({
    required this.datatype,
    required this.value,
  });

  factory Id.fromMap(Map<String, dynamic> json) => Id(
    datatype: json["__datatype__"],
    value: json["value"],
  );

  Map<String, dynamic> toMap() => {
    "__datatype__": datatype,
    "value": value,
  };
}