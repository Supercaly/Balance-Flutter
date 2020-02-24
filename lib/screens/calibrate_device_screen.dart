import 'dart:async';
import 'package:balance_app/sensors/sensors.dart';
import 'package:balance_app/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiver/async.dart';

class CalibrateDeviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: CalibrationWidget());
  }
}

/// Enum class used to represent the state of the calibration
enum CalibrationState { IDLE, CALIBRATING, DONE }

class CalibrationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalibrationWidgetState();
  }
}

class _CalibrationWidgetState extends State<CalibrationWidget> {
  CalibrationState _state;
  CountdownTimer _timer;
  Sensors _sensors;
  bool _isTimerCancelled;

  StreamSubscription _accStream;

  @override
  void initState() {
    _isTimerCancelled = false;
    _state = CalibrationState.IDLE;
    _sensors = Sensors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.bottomCenter,
              // TODO: 24/02/20 Animate the Picture douring the calibration
              child: SvgPicture.asset("assets/icons/calibration_phone.svg", height: 200)
            )
          ),
          Expanded(child: SizedBox(height: 24)),
          Expanded(
            flex: 2,
            child: textElements
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                onPressed: (_state == CalibrationState.CALIBRATING)? null: () {
                  setState(() => _state = CalibrationState.CALIBRATING);
                  _accStream = _sensors.accelerometerEvents.listen((event) => null);
                  _timer = CountdownTimer(Duration(milliseconds: 10000), Duration(milliseconds: 1000))
                    ..listen(
                        (event) => print("Calibrating... ${event.elapsed.inSeconds} - ${event.remaining.inSeconds}"),
                        onDone: () {
                          _accStream?.cancel();
                          _accStream = null;
                          if (mounted && !_isTimerCancelled) {
                            setState(() => _state = CalibrationState.DONE);
                            print("Dalibration Done... Calculating biases...");
                          }
                        },
                        onError: (e) => print("Calibration Error: $e"),
                        cancelOnError: true
                      );
                },
                child: calibrateButtonText,
              ),
            )
          )
        ],
      ),
    );
  }


  @override
  void dispose() {
    print("_CalibrationWidgetState.dispose: Disposing...");
    _isTimerCancelled = true;
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  /// Returns the correct Text for the calibrate button
  /// based on the current state of the calibration
  Text get calibrateButtonText {
    switch(_state) {
      case CalibrationState.DONE:
        return Text("Calibrate Again");
      default:
        return Text("Start Calibration");
    }
  }

  /// Returns the correct block of widgets based
  /// on the current state of the calibration
  Widget get textElements {
    Widget element;
    switch (_state) {
      // Display the calibration guide text
      case CalibrationState.IDLE:
        element = Text(
          BStrings.calibration_message_txt,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        );
        break;
      // Display the progress bar and the calibrating texts
      case CalibrationState.CALIBRATING:
        element = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 300, height: 3, child: LinearProgressIndicator()),
            SizedBox(height: 16),
            Text(
              BStrings.calibrating_txt,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 8),
            Text(
              BStrings.do_not_move_the_device_txt,
              style: Theme.of(context).textTheme.bodyText1
            ),
          ],
        );
        break;
      // Display the calibration complete text
      case CalibrationState.DONE:
        element = Text(
          BStrings.calibration_completed_txt,
          style: Theme.of(context).textTheme.headline5,
        );
        break;
    }
    return Container(
      child: element,
    );
  }
}