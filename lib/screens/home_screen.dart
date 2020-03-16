import 'dart:async';

import 'package:balance_app/sensors/sensor_monitor.dart';
import 'package:balance_app/sensors/sensor_widget.dart';
import 'package:balance_app/widgets/cicular_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return SensorWidget(
      builder: (_, controller) {
        print("${controller.state}");
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                controller.state == SensorController.listening?
                  controller.cancel():
                  controller.listen();
              },
              child: Text("Measure"),
            ),
            RaisedButton(
              onPressed: null,
              child: Text("Boh"),
            ),
          ]
        );
      },
    );
  }
}
