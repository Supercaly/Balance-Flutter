import 'dart:async';
import 'package:balance_app/sensors/sensor_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Class used to listen to sensor events
class Sensors {
  static const _defaultAccelerometerEventChannel = const EventChannel("uniurb.it/sensors/accelerometer");
  static const _defaultGyroscopeEventChannel = const EventChannel("uniurb.it/sensors/gyroscope");
  static const _defaultSensorMethodChannel = const MethodChannel("uniurb.it/sensors/presence");

  /// Instance of the Sensors class
  static Sensors _instance;

  factory Sensors() {
    if (_instance == null) {
      _instance = Sensors.private(
        _defaultAccelerometerEventChannel,
        _defaultGyroscopeEventChannel,
        _defaultSensorMethodChannel
      );
    }
    return _instance;
  }

  /// This constructor is only used for testing and shouldn't be accessed
  @visibleForTesting
  Sensors.private(this._accelerometerEventChannel, this._gyroscopeEventChannel, this._sensorMethodChannel);

  final EventChannel _accelerometerEventChannel;
  final EventChannel _gyroscopeEventChannel;
  final MethodChannel _sensorMethodChannel;

  Stream<SensorEvent> _accelerometerEvents;
  Stream<SensorEvent> _gyroscopeEvents;

  Stream<SensorEvent> get accelerometerStream {
    _accelerometerEvents ??= _accelerometerEventChannel
      .receiveBroadcastStream()
      .map((event) => eventToSensorEvent(event));
    return _accelerometerEvents;
  }

  Stream<SensorEvent> get gyroscopeStream {
      _gyroscopeEvents ??= _gyroscopeEventChannel
        .receiveBroadcastStream()
        .map((event) => eventToSensorEvent(event));
    return _gyroscopeEvents;
  }

  Future<bool> get isAccelerometerPresent => 
    _sensorMethodChannel.invokeMethod("isAccelerometerPresent")
      .then<bool>((value) => value);
  Future<bool> get isGyroscopePresent => 
    _sensorMethodChannel.invokeMethod("isGyroscopePresent")
      .then<bool>((value) => value);

  /// Convert the given event to [SensorEvent]
  /// 
  /// Returns a new instance of [SensorEvent] from the
  /// given [List] of parameters obtained by the platform
  /// code.
  /// In case of error during conversion it will return [null].
  @visibleForTesting
  static SensorEvent eventToSensorEvent(List event) {
    try {
      int timestamp = event[0] as int;
      int accuracy = event[1] as int;
      double x = event[2] as double;
      double y = event[3] as double;
      double z = event[4] as double;
      return SensorEvent(timestamp, accuracy, x, y, z);
    } catch(e) {
      print("Sensors.eventToSensorEvent: Error parsing event: $e");
      return null;
    }
  }
}