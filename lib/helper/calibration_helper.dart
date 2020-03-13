import 'package:balance_app/manager/preference_manager.dart';
import 'package:balance_app/model/sensor_bias.dart';
import 'package:balance_app/sensors/sensor_monitor.dart';
import 'package:quiver/async.dart';

/// Helper class for the device calibration process
///
/// This class contains methods to listen to sensors
/// for some time, and after that compute the [SensorBias]es
class CalibrationHelper {
  CountdownTimer _countdownTimer;
  bool _timerCanceled;
  bool _calibrating;
  final Function _onDone;
  final SensorMonitor _sensorMonitor;

  CalibrationHelper(this._onDone):
      _sensorMonitor = SensorMonitor(),
      _timerCanceled = false,
      _calibrating = false;

  /// Start the calibration process
  void startCalibration() {
    if (!_calibrating) {
      _calibrating = true;
      _timerCanceled = false;
      // Start listening to sensors events
      _sensorMonitor.startListening();
      // Start the CountdownTimer
      _countdownTimer = CountdownTimer(Duration(milliseconds: 10000), Duration(milliseconds: 1000))
        ..listen((event) => null,
          onError: (e) => print("CalibrationHelper.startCalibration: Error during calibration: $e"),
          onDone: () {
            // Stop listening to sensors events
            _calibrating = false;
            _sensorMonitor.stopListening();

            // If the calibration was not cancelled
            if (!_timerCanceled) {
              print("CalibrationHelper.startCalibration: Calibration done!");
              // Save the biases into Shared Preferences
              PreferenceManager.updateSensorBiases(_accelerationBias, _gyroscopeBias);
              _onDone();
            }
          },
        );
    }
  }

  /// Cancel the calibration process
  ///
  /// Note: This method must be called in the parent
  /// widget dispose method before super.dispose.
  void cancelCalibration() {
    if (_calibrating) {
      print("CalibrationHelper.cancelCalibration: Calibration Cancelled!");
      _timerCanceled = true;
      _countdownTimer?.cancel();
      _countdownTimer = null;
    }
  }

  /// Returns the [SensorBias] for accelerometer values
  SensorBias get _accelerationBias {
    if (_sensorMonitor.data.length == 0) return null;
    double xSum = 0, ySum = 0, zSum = 0;
    for (var event in _sensorMonitor.data){
      xSum += event.accelerometerX;
      ySum += event.accelerometerY;
      zSum += event.accelerometerZ;
    }

    return SensorBias(
      xSum / _sensorMonitor.data.length,
      ySum / _sensorMonitor.data.length,
      zSum / _sensorMonitor.data.length,
    );
  }

  /// Returns the [SensorBias] for gyroscope values
  SensorBias get _gyroscopeBias {
    if (_sensorMonitor.data.length == 0) return null;
    double xSum = 0, ySum = 0, zSum = 0;
    for (var event in _sensorMonitor.data) {
      xSum += event.gyroscopeX;
      ySum += event.gyroscopeY;
      zSum += event.gyroscopeZ;
    }

    return SensorBias(
      xSum / _sensorMonitor.data.length,
      ySum / _sensorMonitor.data.length,
      zSum / _sensorMonitor.data.length,
    );
  }
}
