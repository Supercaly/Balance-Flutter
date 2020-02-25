package it.uniurb.balance_app

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    private val sensorManager by lazy { context.getSystemService(Context.SENSOR_SERVICE) as SensorManager }
    private val accelerometerSensor by lazy { sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) }
    private val gyroscopeSensor by lazy { sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE) }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger

        // Setup EventChannels for sensor events
        EventChannel(binaryMessenger, "uniurb.it/sensors/accelerometer")
          .setStreamHandler(SensorListener(sensorManager, accelerometerSensor))
        EventChannel(binaryMessenger, "uniurb.it/sensors/gyroscope")
          .setStreamHandler(SensorListener(sensorManager, gyroscopeSensor))

        // Setup MethodChannel for getting sensors information
        MethodChannel(binaryMessenger, "uniurb.it/sensors")
          .setMethodCallHandler { call, result ->
              when(call.method) {
                  "isAccelerometerPresent" -> result.success(accelerometerSensor != null)
                  "isGyroscopePresent" -> result.success(gyroscopeSensor != null)
                  else -> result.notImplemented()
              }
          }
    }
}
