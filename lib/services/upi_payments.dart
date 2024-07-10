import 'package:flutter/services.dart';

class UpiPayment {
  static const MethodChannel _channel = MethodChannel('com.example.foodary/upi');

  static Future<void> payUsingUpi(String amount, String upiId, String name, String note) async {
    try {
      await _channel.invokeMethod('payUsingUpi', {
        'amount': amount,
        'upi_id': upiId,
        'name': name,
        'note': note,
      });
    } on PlatformException catch (e) {
      print("Failed to initiate UPI payment: '${e.message}'.");
    }
  }
}
