import 'dart:async';

import 'package:balance_app/sensors/sensor_event.dart';
import 'package:balance_app/sensors/sensors_old.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  MockEventChannel accEventChannel;
  MockEventChannel gyroEventChannel;
  MockMethodChannel sensorMethodChannel;

  SensorsOld sensors;

  setUp(() {
    accEventChannel = MockEventChannel();
    gyroEventChannel = MockEventChannel();
    sensorMethodChannel = MockMethodChannel();
    sensors = SensorsOld.private(accEventChannel, gyroEventChannel, sensorMethodChannel);
  });

  group("convert sensor events", () {
    test("convert good data", () {
      var goodData = [1,2,3.0,4.0,5.0];
      expect(SensorsOld.eventToSensorEvent(goodData), isNotNull);
      expect(SensorsOld.eventToSensorEvent(goodData), SensorEvent(1,2,3.0,4.0,5.0));
    });

    test("convert bad data", () {
      var badData = ["wrong",2,3.0,4.0,5.0];
      expect(SensorsOld.eventToSensorEvent(badData), isNull);

      var badData2 = [1,2,0.0];
      expect(SensorsOld.eventToSensorEvent(badData2), isNull);
    });
  });

  group("sensor presence", () {
    test("accelerometerPresent", () async {
      when(sensorMethodChannel.invokeMethod<bool>("isAccelerometerPresent"))
        .thenAnswer((realInvocation) => Future<bool>.value(true));
      expect(await sensors.isAccelerometerPresent, true);
    });
    
    test("accelerometerNotPresent", () async {
      when(sensorMethodChannel.invokeMethod<bool>("isAccelerometerPresent"))
        .thenAnswer((realInvocation) => Future<bool>.value(false));
      expect(await sensors.isAccelerometerPresent, false);
    });

    test("gyroscopePresent", () async {
      when(sensorMethodChannel.invokeMethod<bool>("isGyroscopePresent"))
        .thenAnswer((realInvocation) => Future<bool>.value(true));
      expect(await sensors.isGyroscopePresent, true);
    });

    test("gyroscopeNotPresent", () async {
      when(sensorMethodChannel.invokeMethod<bool>("isGyroscopePresent"))
        .thenAnswer((realInvocation) => Future<bool>.value(false));
      expect(await sensors.isGyroscopePresent, false);
    });
  });
  
  group("sensor events", () {
    StreamController<List> controller;

    setUp(() {
      controller = StreamController();
      when(accEventChannel.receiveBroadcastStream())
        .thenAnswer((realInvocation) => controller.stream);
      when(gyroEventChannel.receiveBroadcastStream())
        .thenAnswer((realInvocation) => controller.stream);
    });

    test("accelerometerEvents", () async {
      final mockEvent = SensorEvent(0,0,0.0,0.0,0.0);

      controller.add([0,0,0.0,0.0,0.0]);
      expect(await sensors.accelerometerStream.first, mockEvent);
    });

    test("gyroscopeEvents", () async {
      final mockEvent = SensorEvent(0,0,0.0,0.0,0.0);

      controller.add([0,0,0.0,0.0,0.0]);
      expect(await sensors.gyroscopeStream.first, mockEvent);
    });

    tearDown(() => controller.close());
  });
}

class MockEventChannel extends Mock implements EventChannel {}
class MockMethodChannel extends Mock implements MethodChannel {}