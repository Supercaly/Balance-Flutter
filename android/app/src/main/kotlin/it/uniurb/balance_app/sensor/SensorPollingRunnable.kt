package it.uniurb.balance_app.sensor

import android.os.Handler

/**
 *
 * @author Lorenzo Calisti on 09/03/2020
 */
class SensorPollingRunnable(
	private val handler: Handler,
	private val runnable: Runnable
): Runnable {

	override fun run() {
		while (!Thread.currentThread().isInterrupted) {
			try {
				Thread.sleep(10)
				handler.post(runnable)
			} catch (ex: InterruptedException) {
				Thread.currentThread().interrupt()
			}
		}
	}
}