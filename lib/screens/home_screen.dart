import 'dart:async';

import 'package:balance_app/sensors/sensors.dart';
import 'package:balance_app/widgets/cicular_counter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final sensor = Sensors();
  StreamSubscription _sensorStream;
  int _eventCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularCounter(),
        SizedBox(height: 30),
        RaisedButton(
          onPressed: () {},
          child: Text("Boh"),
        ),
      ]);
  }

  @override
  void dispose() {
    print("Dispose");
    super.dispose();
  }
}
