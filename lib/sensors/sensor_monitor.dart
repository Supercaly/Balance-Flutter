import 'dart:async';
import 'package:balance_app/model/sensor_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// Class for monitor device's sensors
///
/// This class is able to listen to the sensors present in the device
/// through specific methods.
class SensorMonitor {
  static const EventChannel _defaultSensorsEventChannel = const EventChannel("uniurb.it/sensors/stream");
  static const MethodChannel _defaultSensorsMethodChannel = const MethodChannel("uniurb.it/sensors/presence");

  final EventChannel _sensorsEventChannel;
  final MethodChannel _sensorsMethodChannel;
  final List<SensorData> _sensorsData;
  StreamSubscription<SensorData> _sensorsStreamSubscription;
  bool _isListening;

  /// Returns all the retrieved [SensorData]
  List<SensorData> get data => _sensorsData;

  /// Default constructor
  SensorMonitor():
      _sensorsEventChannel = _defaultSensorsEventChannel,
      _sensorsMethodChannel = _defaultSensorsMethodChannel,
      _isListening = false,
      _sensorsData = [];

  /// This constructor is only used for testing and
  /// shouldn't be accessed from outside this class
  @visibleForTesting
  SensorMonitor.private(this._sensorsMethodChannel, this._sensorsEventChannel):
      _isListening = false,
      _sensorsData = [];

  /// Returns true if the accelerometer sensor is present
  Future<bool> get isAccelerometerPresent =>
    _sensorsMethodChannel.invokeMethod("isAccelerometerPresent")
      .then<bool>((value) => value);
  /// Returns true if the gyroscope sensor is present
  Future<bool> get isGyroscopePresent =>
    _sensorsMethodChannel.invokeMethod("isGyroscopePresent")
      .then<bool>((value) => value);

  /// Start listening to sensor events
  void startListening() {
    if (!_isListening) {
      _sensorsData.clear();
      _isListening = true;
      _sensorsStreamSubscription = _sensorsEventChannel
        .receiveBroadcastStream()
        .map((event) => eventToSensorData(event))
        .listen((event) {
          if (event != null)
            _sensorsData.add(event);
        });
    }
  }

  /// Stop listening to sensor events
  void stopListening() {
    if (_isListening) {
      _isListening = false;
      _sensorsStreamSubscription.cancel();
    }
  }

  /// Map any received event to a [SensorData]
  ///
  /// This method maps any event received from [EventChannel]
  /// to a [SensorData] or null if the data is incorrect.
  @visibleForTesting
  static SensorData eventToSensorData(List event) {
    try {
      int timestamp = event[0] as int;
      int accuracy = event[1] as int;
      double accX = event[2] as double;
      double accY = event[3] as double;
      double accZ = event[4] as double;
      double gyroX = event[5] as double;
      double gyroY = event[6] as double;
      double gyroZ = event[7] as double;
      return SensorData(
        timestamp,
        accuracy,
        accX,
        accY,
        accZ,
        gyroX,
        gyroY,
        gyroZ
      );
    } catch (_) {
      return null;
    }
  }
}

