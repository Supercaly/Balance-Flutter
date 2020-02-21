package it.uniurb.balance_app

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    companion object {
        private const val ACCELEROMETER_CHANNEL = "uniurb.it/sensors/accelerometer"
        private const val GYROSCOPE_CHANNEL = "uniurb.it/sensors/gyroscope"
    }

    private val sensorManager by lazy { context.getSystemService(Context.SENSOR_SERVICE) as SensorManager }
    private val accelerometerSensor by lazy { sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) }
    private val gyroscopeSensor by lazy { sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE) }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        // Setup EventChannel for accelerometer events
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, ACCELEROMETER_CHANNEL)
                .setStreamHandler(StreamHandlerImpl(sensorManager, accelerometerSensor))
        // Setup EventChannel for gyroscope events
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, GYROSCOPE_CHANNEL)
                .setStreamHandler(StreamHandlerImpl(sensorManager, gyroscopeSensor))
    }
}

class StreamHandlerImpl(
        private val sensorManager: SensorManager,
        private val sensor: Sensor?
): EventChannel.StreamHandler {

    private var sensorEventListener: SensorEventListener? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sensorEventListener = createSensorEventListener(events)
        sensorManager.registerListener(sensorEventListener, sensor, SensorManager.SENSOR_DELAY_FASTEST)
    }

    override fun onCancel(arguments: Any?) = sensorManager.unregisterListener(sensorEventListener)

    private fun createSensorEventListener(sink: EventChannel.EventSink?) = object : SensorEventListener {
        override fun onSensorChanged(event: SensorEvent?) {
            sink?.success(listOf(
                    event?.timestamp,
                    event?.accuracy,
                    event?.values?.get(0),
                    event?.values?.get(1),
                    event?.values?.get(2)
            ))
        }
        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
    }
}
