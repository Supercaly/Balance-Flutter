package it.uniurb.balance_app.sensor

import android.content.Context
import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel
import it.uniurb.balance_app.model.SensorData
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit

/**
 *
 * @author Lorenzo Calisti on 09/03/2020
 */
class SensorMonitor(context: Context): EventChannel.StreamHandler {
	private val sharedValues = SensorSharedValues.instance
	private val sensorListener = SensorListener(context)
	private val uiThreadHandler: Handler = Handler(Looper.getMainLooper())
	private var threadPool: ExecutorService? = null

	fun isAccelerometerPresent(): Boolean = sensorListener.isAccelerometerPresent()
	fun isGyroscopePresent(): Boolean = sensorListener.isGyroscopePresent()

	override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
		threadPool = Executors.newSingleThreadExecutor()
		threadPool?.execute(SensorPollingRunnable(
			uiThreadHandler,
			Runnable {
				events?.success(SensorData.mergeSensorData(
					sharedValues.currentAccelerometerValue,
					sharedValues.currentGyroscopeValue
				))
			})
		)
		sensorListener.startListening()
	}

	override fun onCancel(arguments: Any?) {
		threadPool?.shutdownNow()
		try {
			threadPool?.awaitTermination(0L, TimeUnit.SECONDS)
		} catch (ex: InterruptedException) {
			ex.printStackTrace()
		} finally {
			sensorListener.stopListening()
			threadPool = null
		}
	}
}