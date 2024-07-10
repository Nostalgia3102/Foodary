package com.example.foodary

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.foodary/upi"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "payUsingUpi") {
                val amount = call.argument<String>("amount")
                val upiId = call.argument<String>("upi_id")
                val name = call.argument<String>("name")
                val note = call.argument<String>("note")
                if (amount != null && upiId != null && name != null && note != null) {
                    payUsingUpi(amount, upiId, name, note, result)
                } else {
                    result.error("INVALID_ARGUMENT", "Arguments missing", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun payUsingUpi(amount: String, upiId: String, name: String, note: String, result: MethodChannel.Result) {
        val uri = Uri.parse("upi://pay").buildUpon()
            .appendQueryParameter("pa", upiId)
            .appendQueryParameter("pn", name)
            .appendQueryParameter("tn", note)
            .appendQueryParameter("am", amount)
            .appendQueryParameter("cu", "INR")
            .build()

        val upiPayIntent = Intent(Intent.ACTION_VIEW)
        upiPayIntent.data = uri

        val chooser = Intent.createChooser(upiPayIntent, "Pay with")

        if (null != chooser.resolveActivity(packageManager)) {
            startActivityForResult(chooser, 1)
            result.success(null)
        } else {
            Toast.makeText(this, "No UPI App found, Please install one to continue", Toast.LENGTH_SHORT).show()
            result.error("NO_UPI_APP", "No UPI App found, Please install one to continue", null)
        }
    }
}
