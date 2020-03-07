
import 'dart:async';

import 'package:balance_app/bloc/events/countdown_events.dart';
import 'package:balance_app/bloc/states/countdown_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/async.dart';

class CountdownBloc extends Bloc<CountdownEvents, CountdownState> {
  CountdownTimer _countdownTimer;

  @override
  CountdownState get initialState => CountdownState.idle;

  void dispose() {
    _countdownTimer.cancel();
    _countdownTimer = null;
  }

  @override
  Stream<CountdownState> mapEventToState(CountdownEvents event) async* {
    switch(event) {
      case CountdownEvents.startPreMeasure:
        _countdownTimer = CountdownTimer(Duration(milliseconds: 5000), Duration(milliseconds: 1000))
          ..listen((event) {
            if (event.remaining == Duration(seconds: 0))
              add(CountdownEvents.startMeasure);
        });
        yield CountdownState.preMeasure;
        break;
      case CountdownEvents.startMeasure:
        _countdownTimer = CountdownTimer(Duration(milliseconds: 32000), Duration(milliseconds: 1000))
          ..listen((event) {
            if (event.remaining == Duration(seconds: 0))
              add(CountdownEvents.stop);
        });
        yield CountdownState.preMeasure;
        break;
      case CountdownEvents.stop:
        dispose();
        yield CountdownState.idle;
        break;
    }
  }
}