package it.uniurb.balance_app.sensor

import it.uniurb.balance_app.model.SensorData

/**
 *
 * @author Lorenzo Calisti on 09/03/2020
 */
class SensorSharedValues {

	companion object {
		private var mInstance: SensorSharedValues? = null

		val instance: SensorSharedValues
			get() {
				if (mInstance == null)
					mInstance = SensorSharedValues()
				return mInstance!!
			}
	}

	@Volatile var currentAccelerometerValue: SensorData? = null
	@Volatile var currentGyroscopeValue: SensorData? = null
}