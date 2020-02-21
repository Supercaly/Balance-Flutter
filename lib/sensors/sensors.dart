import 'package:balance_app/sensors/sensor_event.dart';
import 'package:flutter/services.dart';

/// Class used to listen to sensor events
class Sensors {
  static const ACCELEROMETER_CHANNEL = "uniurb.it/sensors/accelerometer";
  static const GYROSCOPE_CHANNEL = "uniurb.it/sensors/gyroscope";
  static const _accEventChannel = EventChannel(ACCELEROMETER_CHANNEL);
  static const _gyroEventChannel = EventChannel(GYROSCOPE_CHANNEL);

  Stream<SensorEvent> _accelerometerEvents;
  Stream<SensorEvent> _gyroscopeEvents;

  Stream<SensorEvent> get accelerometerEvents {
    if (_accelerometerEvents == null)
      _accelerometerEvents = _accEventChannel
        .receiveBroadcastStream()
        .map((event) => _eventToSensorEvent(event));
    return _accelerometerEvents;
  }

  Stream<SensorEvent> get gyroscopeEvents {
    if (_gyroscopeEvents == null)
      _gyroscopeEvents = _gyroEventChannel
        .receiveBroadcastStream()
        .map((event) => _eventToSensorEvent(event));
    return _gyroscopeEvents;
  }

  SensorEvent _eventToSensorEvent(event) => SensorEvent(
    event[0] as int,
    event[1] as int,
    event[2] as double,
    event[3] as double,
    event[4] as double
  );
}