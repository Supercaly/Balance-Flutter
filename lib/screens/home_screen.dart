import 'package:balance_app/sensors/sensor_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SensorWidget(
      builder: (context, controller) => Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "${controller.state}",
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () => controller.state == SensorController.listening?
                controller.cancel():
                controller.listen(),
              child: Text(
                controller.state == SensorController.listening?
                "Stop": "Measure"
              ),
            ),
            RaisedButton(
              onPressed: null,
              child: Text("Toggle Button"),
            )
          ],
        ),
      ),
    );
  }
}
