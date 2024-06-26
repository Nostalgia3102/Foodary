import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodary/data/models/user_profile.dart';

class Reviews{
  Timestamp createdAt;
  int rating;
  Id vendorId;
  String comment;
  Id userId;
  Timestamp updatedAt;
  String reviewsId;

  Reviews({
    required this.createdAt,
    required this.rating,
    required this.vendorId,
    required this.comment,
    required this.userId,
    required this.updatedAt,
    required this.reviewsId,
  });

  factory Reviews.fromMap(Map<String, dynamic> json) => Reviews(
    createdAt: json["createdAt"],
    rating: json["rating"],
    vendorId: Id.fromMap(json["vendorId"]),
    comment: json["comment"],
    userId: Id.fromMap(json["userId"]),
    updatedAt: json["updatedAt"],
    reviewsId: json["reviewsId"],
  );

  Map<String, dynamic> toMap() => {
    "createdAt": createdAt,
    "rating": rating,
    "vendorId": vendorId.toMap(),
    "comment": comment,
    "userId": userId.toMap(),
    "updatedAt": updatedAt,
    "reviewsId": reviewsId,
  };
}