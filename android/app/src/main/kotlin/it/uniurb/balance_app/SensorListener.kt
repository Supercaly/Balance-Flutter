package it.uniurb.balance_app

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel

/**
 * Class implementing a Sensor specific [EventChannel.StreamHandler]
 *
 * During [onListen] a SensorEventListener is registered for the given
 * [sensor] passing every event to the [EventChannel.EventSink] formatted
 * as a list with (in order): timestamp, accuracy, x-value, y-value, z-value.
 *
 * The senor listener is unregistered during [onCancel].
 *
 * @param sensorManager instance of SensorManager
 * @param sensor the Sensor to listen
 * @author Lorenzo Calisti on 24/02/2020
 */
class SensorListener(
	private val sensorManager: SensorManager,
	private val sensor: Sensor?
): EventChannel.StreamHandler, SensorEventListener {
	private var eventSink: EventChannel.EventSink? = null

	override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
		if (events == null || sensor == null) return
		this.eventSink = events
		sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_FASTEST)
	}

	override fun onCancel(arguments: Any?) {
		if (eventSink == null) return
		sensorManager.unregisterListener(this)
		this.eventSink = null
	}

	override fun onAccuracyChanged(p0: Sensor?, p1: Int) { /*No-Op*/ }
	override fun onSensorChanged(p0: SensorEvent?) {
		eventSink?.success(listOf(
			p0?.timestamp,
			p0?.accuracy,
			p0?.values?.get(0),
			p0?.values?.get(1),
			p0?.values?.get(2)
		))
	}
}