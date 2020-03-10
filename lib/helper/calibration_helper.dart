import 'dart:async';
import 'package:balance_app/manager/preference_manager.dart';
import 'package:balance_app/model/sensor_bias.dart';
import 'package:balance_app/sensors/sensor_event.dart';
import 'package:balance_app/sensors/sensors_old.dart';
import 'package:quiver/async.dart';

/// Helper class for the device calibration process
///
/// This class contains methods to listen to sensors
/// for some time, and after that compute the [SensorBias]es
class CalibrationHelper {
  final List<SensorEvent> _accEvents = [];
  final List<SensorEvent> _gyroEvents = [];
  StreamSubscription<SensorEvent> _gyroscopeSub;
  StreamSubscription<SensorEvent> _accelerometerSub;
  CountdownTimer _countdownTimer;
  bool _timerCanceled;
  bool _calibrating;
  final Function _onDone;

  CalibrationHelper(this._onDone):
      _timerCanceled = false, _calibrating = false;

  /// Start the calibration process
  void startCalibration() {
    if (!_calibrating) {
      _calibrating = true;
      _timerCanceled = false;
      // Start listening to sensors events
      _accelerometerSub = SensorsOld().accelerometerStream.listen((event) => _accEvents.add(event));
      _gyroscopeSub = SensorsOld().gyroscopeStream.listen((event) => _gyroEvents.add(event));
      // Start the CountdownTimer
      _countdownTimer = CountdownTimer(Duration(milliseconds: 10000), Duration(milliseconds: 1000))
        ..listen((event) => null,
          onError: (e) => print("CalibrationHelper.startCalibration: Error during calibration: $e"),
          onDone: () {
            _calibrating = false;
            // Stop listening to sensors events
            _accelerometerSub?.cancel();
            _gyroscopeSub?.cancel();
            _accelerometerSub = null;
            _gyroscopeSub = null;
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
    if (_accEvents.length == 0) return null;
    double xSum = 0, ySum = 0, zSum = 0;
    for (var event in _accEvents){
      xSum += event.x;
      ySum += event.y;
      zSum += event.z;
    }

    return SensorBias(
      xSum / _accEvents.length,
      ySum / _accEvents.length,
      zSum / _accEvents.length,
    );
  }

  /// Returns the [SensorBias] for gyroscope values
  SensorBias get _gyroscopeBias {
    if (_gyroEvents.length == 0) return null;
    double xSum = 0, ySum = 0, zSum = 0;
    for (var event in _gyroEvents) {
      xSum += event.x;
      ySum += event.y;
      zSum += event.z;
    }

    return SensorBias(
      xSum / _gyroEvents.length,
      ySum / _gyroEvents.length,
      zSum / _gyroEvents.length,
    );
  }
}
