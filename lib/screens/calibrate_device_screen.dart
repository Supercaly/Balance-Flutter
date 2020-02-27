import 'package:balance_app/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helper/calibration_helper.dart';

/// This Widget represent the Calibrate Device Screen
///
/// His purpose is to display all the calibration related
/// UI and let the user calibrate his phone before any
/// test. The calibration is achieved through [CalibrationHelper].
class CalibrateDeviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: CalibrationWidget());
  }
}

/// Enum class used to represent the state of the calibration
enum CalibrationState { idle, calibrating, done }

class CalibrationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalibrationWidgetState();
  }
}

class _CalibrationWidgetState extends State<CalibrationWidget> with WidgetsBindingObserver {
  CalibrationState _state;
  CalibrationHelper _calibrationHelper;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _state = CalibrationState.idle;
    _calibrationHelper = CalibrationHelper(() => setState(() => _state = CalibrationState.done));
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused)
      _calibrationHelper.cancelCalibration();
    else if (state == AppLifecycleState.resumed && _state == CalibrationState.calibrating)
      setState(() => _state = CalibrationState.idle);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _calibrationHelper?.cancelCalibration();
    _calibrationHelper = null;
    super.dispose();
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
              // TODO: 24/02/20 Animate the Picture during the calibration
              child: SvgPicture.asset("assets/icons/calibration_phone.svg", height: 200)
            )
          ),
          Expanded(child: SizedBox(height: 24)),
          Expanded(flex: 2, child: textElements),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                onPressed: (_state == CalibrationState.calibrating)? null: () {
                  setState(() => _state = CalibrationState.calibrating);
                  _calibrationHelper.startCalibration();
                },
                child: calibrateButtonText,
              ),
            )
          )
        ],
      ),
    );
  }

  /// Returns the correct Text for the calibrate button
  /// based on the current state of the calibration
  Text get calibrateButtonText {
    switch(_state) {
      case CalibrationState.done:
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
      case CalibrationState.idle:
        element = Text(
          BStrings.calibration_message_txt,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        );
        break;
      // Display the progress bar and the calibrating texts
      case CalibrationState.calibrating:
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
      case CalibrationState.done:
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