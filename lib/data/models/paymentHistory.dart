import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentHistory{
  Timestamp createdAt;
  int amount;
  String uniquePaymentId;
  String paymentMethod;
  String paymentHistoryId;

  PaymentHistory({
    required this.createdAt,
    required this.amount,
    required this.uniquePaymentId,
    required this.paymentMethod,
    required this.paymentHistoryId,
  });

  factory PaymentHistory.fromMap(Map<String, dynamic> json) => PaymentHistory(
    createdAt: json["createdAt"],
    amount: json["amount"],
    uniquePaymentId: json["uniquePaymentId"],
    paymentMethod: json["paymentMethod"],
    paymentHistoryId: json["paymentHistoryId"],
  );

  Map<String, dynamic> toMap() => {
    "createdAt": createdAt,
    "amount": amount,
    "uniquePaymentId": uniquePaymentId,
    "paymentMethod": paymentMethod,
    "paymentHistoryId": paymentHistoryId,
  };
}