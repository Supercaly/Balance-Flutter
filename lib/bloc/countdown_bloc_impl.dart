
import 'dart:async';
import 'package:quiver/async.dart';
import 'package:balance_app/floor/measurement_database.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/events/countdown_events.dart';
import 'package:balance_app/bloc/states/countdown_state.dart';
import 'package:balance_app/sensors/sensor_monitor.dart';

class CountdownBloc extends Bloc<CountdownEvents, CountdownState> {
  CountdownTimer _countdownTimer;
  bool _isCountdownCancelled;
  SensorMonitor _sensorMonitor;
  StreamSubscription<Duration> _monitorSub;

  /// Private constructor of [CountdownBloc]
  CountdownBloc._(MeasurementDatabase db):
    _isCountdownCancelled = false,
    _sensorMonitor = SensorMonitor(Duration(seconds: 8));

  /// Factory method for creating an instance of [CountdownBloc]
  factory CountdownBloc.create(MeasurementDatabase db) => CountdownBloc._(db);

  @override
  CountdownState get initialState => CountdownState.idle;

  @override
  Stream<CountdownState> mapEventToState(CountdownEvents event) async* {
    switch (event) {
      // Start the pre measuring countdown
      case CountdownEvents.startPreMeasure:
        print("CountdownBloc.mapEventToState: startPreMeasure");
        _isCountdownCancelled = false;
        _countdownTimer = CountdownTimer(Duration(seconds: 6), Duration(seconds: 1))
          ..listen((event) { /*No-op*/ },
            onDone: () {
              if (!_isCountdownCancelled)
                add(CountdownEvents.startMeasure);
            }
          );
        yield CountdownState.preMeasure;
        break;
      // Start the measuring
      case CountdownEvents.startMeasure:
        print("CountdownBloc.mapEventToState: startMeasure");
        _monitorSub = _sensorMonitor.sensorStream.listen((event) { },
          onDone: () {
            _monitorSub = null;
            add(CountdownEvents.measureComplete);
          }
        );
        yield CountdownState.measure;
        break;
      // Stop the pre measuring countdown
      case CountdownEvents.stopPreMeasure:
        print("CountdownBloc.mapEventToState: stopPreMeasure");
        _isCountdownCancelled = true;
        _countdownTimer.cancel();
        _countdownTimer = null;
        yield CountdownState.idle;
        break;
      // Stop the measuring
      case CountdownEvents.stopMeasure:
        print("CountdownBloc.mapEventToState: stopMeasure");
        _monitorSub.cancel();
        _monitorSub = null;
        yield CountdownState.idle;
        break;
      // Save the new test into the database
      case CountdownEvents.measureComplete:
        print("Store ${_sensorMonitor.result.length} data to db");
        yield CountdownState.idle;
        break;
    }
  }
}