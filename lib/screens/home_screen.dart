import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/sensors/sensor_polling.dart';
import 'package:balance_app/widgets/cicular_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';

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

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final sp = SensorPolling();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void dispose() {
    print("_HomeState.dispose: ");
    sp.stopListening();
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    print("_HomeState.didPopRoute: ");
    sp.stopListening();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MeasureCountdown(
          onPreCountdown: () => print("La misurazione stà per partire"),
          onMeasureDone: () => print("Misurazione finita"),
          onMeasureCancel: () => print("Misurazione cancellata"),
          onMeasureStart: () => print("Inisio a misurare"),
        ),
        SizedBox(height: 30),
        RaisedButton(
          onPressed: () {
            CountdownTimer(Duration(seconds: 5), Duration(seconds: 1))
              ..listen((event) => print(event.elapsed),
              onDone: () => sp.stopListening());
            sp.startListening();
          },
          child: Text("Measure"),
        ),
        RaisedButton(
          onPressed: () async {
            int a = await Provider.of<MeasurementDatabase>(context, listen: false).measurementDao
              .insertMeasurement(Measurement.create(eyesOpen: true));
            print(a);
          },
          child: Text("Boh"),
        ),
      ]);
  }
}
