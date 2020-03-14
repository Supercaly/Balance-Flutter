import 'dart:async';

import 'package:balance_app/model/sensor_data.dart';
import 'package:balance_app/sensors/sensor_monitor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';

typedef Widget SensorWidgetBuilder(SensorListener listener);

class SensorWidget extends StatefulWidget {
  final Duration duration;
  final SensorWidgetBuilder builder;

  SensorWidget({Key key, this.duration: const Duration(seconds: 5), this.builder}): super(key: key);

  @override
  _SensorWidgetState createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> with WidgetsBindingObserver {
  SensorListener _sensorListener;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _sensorListener = SensorListener(widget.duration);
    super.initState();
  }

  @override
  Future<bool> didPopRoute() async {
    _sensorListener.cancel();
    return false;
  }

  @override
  void dispose() {
    _sensorListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _sensorListener,
      child: Consumer<SensorListener>(
        builder: (context, value, child) {
          return widget.builder(value);
        },
      ),
    );
  }
}

enum SensorListeningState { none, listening, cancelled, complete }

class SensorListener extends ChangeNotifier {
  final Duration timerDuration;
  final SensorMonitor _monitor;
  CountdownTimer _timer;
  bool _timerCancelled;
  bool _isListening;
  SensorListeningState _state;

  SensorListeningState get state => _state;

  List<SensorData> get result => _monitor.data;

  SensorListener(this.timerDuration):
    _monitor = SensorMonitor(),
    _state = SensorListeningState.none,
    _timerCancelled = false,
    _isListening = false;

  void listen() {
    if (!_isListening) {
      _isListening = true;
      _timerCancelled = false;
      _state = SensorListeningState.listening;
      _timer = CountdownTimer(timerDuration, Duration(seconds: 1))
        ..listen((event) => print("tick: ${event.elapsed}"),
          cancelOnError: false,
          onError: (e) => print("SensorMonitorHelper.start: Error listening sensors: $e"),
          onDone: () {
            _isListening = false;
            _monitor.stopListening();
            _state = SensorListeningState.cancelled;
            // If the timer was not cancelled notify the completion
            if (!_timerCancelled)
              _state = SensorListeningState.complete;
            notifyListeners();
          }
        );
      _monitor.startListening();
      notifyListeners();
    }
  }

  void cancel() {
    if (_isListening) {
      _timerCancelled = true;
      _timer?.cancel();
      _timer = null;
    }
  }
}
