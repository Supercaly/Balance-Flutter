import 'dart:async';

import 'package:balance_app/sensors/sensor_event.dart';
import 'package:flutter/services.dart';

/// Class used to listen to sensor events
class Sensors {
  static const _accEventChannel = const EventChannel("uniurb.it/sensors/accelerometer");
  static const _gyroEventChannel = const EventChannel("uniurb.it/sensors/gyroscope");
  static const _sensorMethodChannel = const MethodChannel("uniurb.it/sensors");

  static Stream<SensorEvent> _accelerometerEvents;
  static Stream<SensorEvent> _gyroscopeEvents;

  static Stream<SensorEvent> get accelerometerStream {
    _accelerometerEvents ??= _accEventChannel
      .receiveBroadcastStream()
      .map((event) => _eventToSensorEvent(event));
    return _accelerometerEvents;
  }

  static Stream<SensorEvent> get gyroscopeStream {
      _gyroscopeEvents ??= _gyroEventChannel
        .receiveBroadcastStream()
        .map((event) => _eventToSensorEvent(event));
    return _gyroscopeEvents;
  }

  static Future<bool> get isAccelerometerPresent => _sensorMethodChannel.invokeMethod("isAccelerometerPresent");
  static Future<bool> get isGyroscopePresent => _sensorMethodChannel.invokeMethod("isGyroscopePresent");

  /// Convert the given event to [SensorEvent]
  static SensorEvent _eventToSensorEvent(event) => SensorEvent(
    event[0] as int,
    event[1] as int,
    event[2] as double,
    event[3] as double,
    event[4] as double
  );
}