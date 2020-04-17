
import 'dart:async';
import 'package:balance_app/repository/test_repository.dart';
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
  TestRepository _repository;

  /// Private constructor of [CountdownBloc]
  CountdownBloc._(MeasurementDatabase db):
    _repository = TestRepository(db),
    _isCountdownCancelled = false,
    _sensorMonitor = SensorMonitor(Duration(milliseconds: 5));

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
        _countdownTimer = CountdownTimer(
          Duration(milliseconds: 6000),
          Duration(milliseconds: 1000)
        )..listen((event) { /*No-op*/ },
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
        await _repository.createNewMeasurement(_sensorMonitor.result, true);
        print("idle?");
        yield CountdownState.idle;
        break;
    }
  }
}