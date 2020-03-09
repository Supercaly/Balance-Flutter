import 'dart:async';
import 'package:balance_app/model/sensor_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class SensorPolling {
  static const EventChannel _defaultSensorsEventChannel = const EventChannel("uniurb.it/sensors");

  StreamSubscription<SensorData> _sensorsStreamSubscription;
  List<SensorData> _sensorsData;
  EventChannel _sensorsEventChannel;
  bool _isListening;

  static SensorPolling _instance;
  factory SensorPolling() {
    if (_instance == null)
      _instance = SensorPolling.private(_defaultSensorsEventChannel);
    return _instance;
  }

  /// This constructor is only used for testing and
  /// shouldn't be accessed from outside this class
  @visibleForTesting
  SensorPolling.private(this._sensorsEventChannel):
      _isListening = false,
      _sensorsData = [];

  ///
  void startListening() {
    if (!_isListening) {
      _isListening = true;
      _sensorsStreamSubscription = _sensorsEventChannel
        .receiveBroadcastStream()
        .map((event) => _eventToSensorData(event))
        .listen((event) {
          if (event != null)
            _sensorsData.add(event);
        });
    }
  }

  ///
  void stopListening() {
    if (_isListening) {
      _isListening = false;
      _sensorsStreamSubscription.cancel();
    }
  }

  ///
  static SensorData _eventToSensorData(List event) {
    if (event == null) return null;
    int timestamp = event[0] as int;
    int accuracy = event[1] as int;
    double accX = event[2] as double;
    double accY = event[3] as double;
    double accZ = event[4] as double;
    double gyroX = event[5] as double;
    double gyroY = event[6] as double;
    double gyroZ = event[7] as double;
    return SensorData(timestamp, accuracy, accX, accY, accZ, gyroX, gyroY, gyroZ);
  }
}

