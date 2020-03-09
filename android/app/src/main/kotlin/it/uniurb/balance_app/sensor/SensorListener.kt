package it.uniurb.balance_app.sensor

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import it.uniurb.balance_app.model.SensorData

/**
 *
 * @author Lorenzo Calisti on 09/03/2020
 */
class SensorListener(context: Context): SensorEventListener {
	private val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as? SensorManager
	private val rawAccelerometerSensor: Sensor? = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
	private val rawGyroscopeSensor: Sensor? = sensorManager?.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
	private val sharedValues = SensorSharedValues.instance

	fun isAccelerometerPresent(): Boolean = rawAccelerometerSensor != null
	fun isGyroscopePresent(): Boolean = rawGyroscopeSensor != null

	fun startListening() {
		if (isAccelerometerPresent())
			sensorManager?.registerListener(this, rawAccelerometerSensor,
				SensorManager.SENSOR_DELAY_FASTEST)
		if (isGyroscopePresent())
			sensorManager?.registerListener(this, rawGyroscopeSensor,
				SensorManager.SENSOR_DELAY_FASTEST)
	}

	fun stopListening() = sensorManager?.unregisterListener(this)

	override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

	override fun onSensorChanged(event: SensorEvent?) {
		when (event?.sensor?.type) {
			Sensor.TYPE_ACCELEROMETER -> sharedValues.currentAccelerometerValue = SensorData(
				event.timestamp,
				event.accuracy,
				event.values[0],
				event.values[1],
				event.values[2],
				null,
				null,
				null
			)
			Sensor.TYPE_GYROSCOPE -> sharedValues.currentGyroscopeValue = SensorData(
				event.timestamp,
				event.accuracy,
				null,
				null,
				null,
				event.values[0],
				event.values[1],
				event.values[2]
			)
		}
	}
}