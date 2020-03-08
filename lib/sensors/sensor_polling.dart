
import 'dart:async';

import 'package:balance_app/sensors/sensor_event.dart';
import 'package:balance_app/sensors/sensors.dart';

class SensorPolling {
  StreamSubscription<SensorEvent> accStream;
  StreamSubscription<SensorEvent> gyroStream;
  Timer timer;

  SensorEvent currentAcc;
  SensorEvent currentGyro;

  List<SensorEvent> accList;
  List<SensorEvent> gyroList;

  void pollSensors() {
    print("Inizio");
    currentAcc = null;
    currentGyro = null;
    accList = [];
    gyroList = [];

    accStream = Sensors().accelerometerStream.listen((event) => currentAcc = event);
    gyroStream = Sensors().gyroscopeStream.listen((event) => currentGyro = event);

    timer = Timer.periodic(Duration(milliseconds: 10), (t) {
      if (currentAcc != null)
        accList.add(currentAcc);
      if (currentGyro != null)
        gyroList.add(currentGyro);
    });
  }

  void stopPolling() {
    timer.cancel();
    accStream.cancel();
    gyroStream.cancel();
    timer = null;
    accStream = null;
    gyroStream = null;
    print("Stop... Ho: ${accList.length} e ${gyroList.length}");
  }
}