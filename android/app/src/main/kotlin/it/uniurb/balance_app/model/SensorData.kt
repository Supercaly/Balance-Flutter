package it.uniurb.balance_app.model

/**
 *
 * @author Lorenzo Calisti on 09/03/2020
 */
data class SensorData(
	val timestamp: Long = 0L,
	val accuracy: Int = 0,
	val accelerometerX: Float? = null,
	val accelerometerY: Float? = null,
	val accelerometerZ: Float? = null,
	val gyroscopeX: Float? = null,
	val gyroscopeY: Float? = null,
	val gyroscopeZ: Float? = null
) {

	companion object {
		fun mergeSensorData(acc: SensorData?, gyr: SensorData?): List<Number?>? =
			when {
				// Merge the two data into one
				(acc != null && gyr != null) ->
					listOf(
						maxOf(acc.timestamp, gyr.timestamp),
						maxOf(acc.accuracy, gyr.accuracy),
						acc.accelerometerX,
						acc.accelerometerY,
						acc.accelerometerZ,
						gyr.gyroscopeX,
						gyr.gyroscopeY,
						gyr.gyroscopeZ
					)
				// The gyroscope data are null
				acc != null -> listOf(acc.timestamp, acc.accuracy, acc.accelerometerX, acc.accelerometerY, acc.accelerometerZ, null, null, null)
				// The accelerometer data are null
				gyr != null -> listOf(gyr.timestamp, gyr.accuracy, null, null, null, gyr.gyroscopeX, gyr.gyroscopeY, gyr.gyroscopeZ)
				// Both data are null, we cannot merge
				else -> null
			}
	}
}
