package com.example.foodary

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.foodary/channels"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "payUsingUpi" -> {
                    val amount = call.argument<String>("amount")
                    val upiId = call.argument<String>("upi_id")
                    val name = call.argument<String>("name")
                    val note = call.argument<String>("note")
                    if (amount != null && upiId != null && name != null && note != null) {
                        payUsingUpi(amount, upiId, name, note, result)
                    } else {
                        result.error("INVALID_ARGUMENT", "Arguments missing", null)
                    }
                }

                "sendMessage" -> {
                    val message = call.argument<String>("message")
                    if (message != null) {
                        sendMessage(message, result)
                    } else {
                        result.error("INVALID_ARGUMENT", "Message argument is missing", null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun payUsingUpi(
        amount: String,
        upiId: String,
        name: String,
        note: String,
        result: MethodChannel.Result
    ) {
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
            Toast.makeText(
                this,
                "No UPI App found, Please install one to continue",
                Toast.LENGTH_SHORT
            ).show()
            result.error("NO_UPI_APP", "No UPI App found, Please install one to continue", null)
        }
    }

    private fun sendMessage(message: String, result: MethodChannel.Result) {
        val sendIntent = Intent().apply {
            action = Intent.ACTION_SEND
            putExtra(Intent.EXTRA_TEXT, message)
            type = "text/plain"
        }
        val chooser = Intent.createChooser(sendIntent, "Send message with")

        if (sendIntent.resolveActivity(packageManager) != null) {
            startActivity(chooser)
            result.success(null)
        } else {
            result.error("NO_APP_FOUND", "No messaging app found to send the message", null)
        }
    }
}
