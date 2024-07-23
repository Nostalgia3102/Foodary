import 'package:flutter/services.dart';

class MethodChannels {

  static const MethodChannel _channel = MethodChannel('com.example.foodary/channels');

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

  static Future<void> sendMessage(String message) async {
    try {
      await _channel.invokeMethod('sendMessage', {
        'message': message,
      });
    } on PlatformException catch (e) {
      print("Failed to open messaging app: '${e.message}'.");
    }
  }

}
