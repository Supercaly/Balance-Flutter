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
        builder: (sensorListener) {
          switch (sensorListener.state) {
            case SensorListeningState.none:
              print("None");
              break;
            case SensorListeningState.listening:
              print("Listening");
              break;
            case SensorListeningState.cancelled:
              print("Cancelled");
              break;
            case SensorListeningState.complete:
              print("Complete");
              break;
          }

          print("on Child ${sensorListener.state}");
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  (sensorListener.state == SensorListeningState.listening)?
                    sensorListener.cancel() :
                    sensorListener.listen();
                },
                child: Text("Measure"),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("Boh"),
              ),
            ]
          );
        }
    );
  }
}
