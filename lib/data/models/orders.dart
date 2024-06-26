import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodary/data/models/user_profile.dart';

import 'items.dart';

class Orders{
  int totalAmount;
  Id vendorId;
  String orderStatus;
  Id userId;
  List<Items> items;
  String deliveryAddress;
  String paymentMethod;
  Timestamp createdAt;
  Id paymentId;
  String ordersId;

  Orders({
    required this.totalAmount,
    required this.vendorId,
    required this.orderStatus,
    required this.userId,
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.createdAt,
    required this.paymentId,
    required this.ordersId,
  });

  factory Orders.fromMap(Map<String, dynamic> json) => Orders(
    totalAmount: json["totalAmount"],
    vendorId: Id.fromMap(json["vendorId"]),
    orderStatus: json["orderStatus"],
    userId: Id.fromMap(json["userId"]),
    items: List<Items>.from(json["items"].map((x) => Items.fromMap(x))),
    deliveryAddress: json["deliveryAddress"],
    paymentMethod: json["paymentMethod"],
    createdAt: json["createdAt"],
    paymentId: Id.fromMap(json["paymentId"]),
    ordersId: json["ordersId"],
  );

  Map<String, dynamic> toMap() => {
    "totalAmount": totalAmount,
    "vendorId": vendorId.toMap(),
    "orderStatus": orderStatus,
    "userId": userId.toMap(),
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
    "deliveryAddress": deliveryAddress,
    "paymentMethod": paymentMethod,
    "createdAt": createdAt,
    "paymentId": paymentId.toMap(),
    "ordersId": ordersId,
  };
}