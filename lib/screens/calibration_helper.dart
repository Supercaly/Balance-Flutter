import 'dart:async';
import 'package:balance_app/screens/sensor_bias.dart';
import 'package:balance_app/sensors/sensor_event.dart';
import 'package:balance_app/sensors/sensors.dart';

class CalibrationHelper {
  static StreamSubscription<SensorEvent> _accelerometerSub;
  static StreamSubscription<SensorEvent> _gyroscopeSub;

  static List<SensorEvent> _accEvents = List();
  static List<SensorEvent> _gyroEvents = List();

  static void startCalibration() {
    _accelerometerSub = Sensors.accelerometerStream.listen((event) => _accEvents.add(event));
    _gyroscopeSub = Sensors.gyroscopeStream.listen((event) => _gyroEvents.add(event));
  }

  static void stopCalibration() {
    _accelerometerSub?.cancel();
    _gyroscopeSub?.cancel();
    _accelerometerSub = null;
    _gyroscopeSub = null;
  }

  static SensorBias get accelerationBias {
    if (_accEvents.length == 0) return null;
    double xSum = 0, ySum = 0, zSum = 0;
    _accEvents.forEach((element) {
      xSum += element.x;
      ySum += element.y;
      zSum += element.z;
    });
    return SensorBias(
      xSum / _accEvents.length,
      ySum / _accEvents.length,
      zSum / _accEvents.length,
    );
  }

  static SensorBias get gyroscopeBias {
    if (_gyroEvents.length == 0) return null;
    double xSum = 0, ySum = 0, zSum = 0;
    _gyroEvents.forEach((element) {
      xSum += element.x;
      ySum += element.y;
      zSum += element.z;
    });
    return SensorBias(
      xSum / _gyroEvents.length,
      ySum / _gyroEvents.length,
      zSum / _gyroEvents.length,
    );
  }
}
