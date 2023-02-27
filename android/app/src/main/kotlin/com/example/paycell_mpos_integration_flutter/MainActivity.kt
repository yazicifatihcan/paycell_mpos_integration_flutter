package com.example.paycell_mpos_integration_flutter

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

        private val CHANNEL = "example_integration/mposgatewaylib"
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Initialize MethodChannel with binaryMessenger and CHANNEL name
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        
        // Set the MethodCallHandler for channel
        channel.setMethodCallHandler(handleMethodCall)
    }

    private val handleMethodCall = MethodCallHandler { call, result ->
        
        // Get the arguments from the method call
        val arguments = call.arguments<String>()
        
        // Call the appropriate function based on method name
        when (call.method) {
            "startSalesOperation" -> launchPaycellPos(arguments!!, reqCode = 1, result)
            "completeSalesOperation" -> launchPaycellPos(arguments!!, reqCode = 2, result)
            "checkIfPosAvailable" -> launchPaycellPos(arguments!!, reqCode = 5, result)
            else -> result.notImplemented()
        }
    }

    private fun launchPaycellPos(requestBody: String, reqCode: Int, result: MethodChannel.Result) {
        LaunchMposInterface.launchMpos(
            applicationContext, this@MainActivity, requestBody, reqCode
        ) { data ->
            result.success(data.message)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        // Check if the result is null
        if (data == null) {
            channel.invokeMethod("onActivityResult", null)
        } else {
            val bundle = data.extras
            // Invoke the method with the result data
            channel.invokeMethod("onActivityResult", bundle["mposResult"].toString())
        }
    }
}
