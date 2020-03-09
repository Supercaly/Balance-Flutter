
import 'dart:async';

import 'package:flutter/services.dart';

class SensorPolling {
  EventChannel eventChannel = const EventChannel("uniurb.it/sensors");
  Stream<SensorData> _stream;
  StreamSubscription<SensorData> _streamSubscription;
  List<SensorData> _data = [];

  Stream<SensorData> get stream {
    _stream ??= eventChannel.receiveBroadcastStream().map((e) => _eventToSensorData(e));
    return _stream;
  }

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

  void startListen() {
    _streamSubscription = stream.listen((event) {
      if (event != null)
        _data.add(event);
      print(event);
    });
  }

  void stopListen() {
    _streamSubscription?.cancel();
    print("Ho ottenuto ${_data?.length} dati");
    print("${_data[0]}");
  }
}

class SensorData {
  final int timestamp;
  final int accuracy;
  final double accelerometerX;
  final double accelerometerY;
  final double accelerometerZ;
  final double gyroscopeX;
  final double gyroscopeY;
  final double gyroscopeZ;

  SensorData(
    this.timestamp,
    this.accuracy,
    this.accelerometerX,
    this.accelerometerY,
    this.accelerometerZ,
    this.gyroscopeX,
    this.gyroscopeY,
    this.gyroscopeZ,
  );

  @override
  String toString() => "SensorData(timestamp=$timestamp, "
    "accuracy=$accuracy, "
    "accelerometerX=$accelerometerX, "
    "accelerometerY=$accelerometerY, "
    "accelerometerZ=$accelerometerZ, "
    "gyroscopeX=$gyroscopeX, "
    "gyroscopeY=$gyroscopeY, "
    "gyroscopeZ=$gyroscopeZ)";
}