import 'package:balance_app/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              child: SvgPicture.asset("assets/icons/calibration_phone.svg", height: 200)
            )
          ),
          Expanded(child: SizedBox(height: 24)),
          Expanded(
            flex: 2,
            child: _getTextElements()
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                onPressed: () => setState(() {
                  if (_state == CalibrationState.IDLE)
                    _state = CalibrationState.CALIBRATING;
                  else if (_state == CalibrationState.CALIBRATING)
                    _state = CalibrationState.DONE;
                  else
                    _state = CalibrationState.IDLE;
                }),
                child: _getCalibrateButtonText(),
              ),
            )
          )
        ],
      ),
    );
  }

  /// Return the correct text for the calibrate button
  Text _getCalibrateButtonText() {
    switch(_state) {
      case CalibrationState.DONE:
        return Text("Calibrate Again");
      default:
        return Text("Start Calibration");
    }
  }

  /// Returns the correct Widget to put in the center of
  /// the screen and display the current state
  ///
  /// return a different Widget for every state:
  ///     IDLE -> warning text
  ///     CALIBRATING -> progressbar and calibrating text
  ///     DONE -> calibration completed text
  Widget _getTextElements() {
    Widget element;
    switch (_state) {
      case CalibrationState.IDLE:
        element = Text(
          BStrings.calibration_message_txt,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        );
        break;
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