
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/manager/preference_manager.dart';

import 'package:balance_app/dialog/calibrate_device_dialog.dart';
import 'package:balance_app/dialog/leave_confirmation_dialog.dart';
import 'package:balance_app/dialog/measuring_tutorial_dialog.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/countdown_bloc.dart';
import 'package:provider/provider.dart';

/// Widget that manage the entire measuring process
///
/// This widget has the purpose of managing the entirety of the
/// posture test process; it contains an instance of [CountdownBloc]
/// rebuilding the ui on every new state, it intercept [didPopRoute]
/// events asking the user if he wants to abort the test and close
/// the app.
class MeasureCountdown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MeasureCountdownState();
}

class _MeasureCountdownState extends State<MeasureCountdown> with WidgetsBindingObserver {
  CountdownBloc _bloc;
  CountdownState _state;

  @override
  void initState() {
    super.initState();
    // Create aCountdownBloc with an instance of the database
    _bloc = CountdownBloc
      .create(Provider.of<MeasurementDatabase>(context, listen: false));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<bool> didPopRoute() async{
    // If we are measuring ask the user if he wants to leave
    if (_state == CountdownState.measure)
      return await showLeaveDialog(
        context,
        () => _bloc.add(CountdownEvents.stopMeasure)
      );
    // If we are in pre measure stop the countdown
    if (_state == CountdownState.preMeasure)
      _bloc.add(CountdownEvents.stopPreMeasure);
    // Close the app
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    // If the test is running stop it
    if (_state == CountdownState.preMeasure)
      _bloc.add(CountdownEvents.stopPreMeasure);
    if (_state == CountdownState.measure)
      _bloc.add(CountdownEvents.stopMeasure);
    // Dismiss the bloc
    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountdownBloc>.value(
      value: _bloc,
      child: BlocConsumer<CountdownBloc, CountdownState>(
        listener: (_, state) => _state = state,
        builder: (context, state) {
          return Column(
            children: [
              _buildWidgetForState(context, state),
              SizedBox(height: 0),
              RaisedButton(
                onPressed: () async{
                  if (state == CountdownState.idle) {
                    /*
                   * Every time the user presses the start button we need to check
                   * two conditions:
                   * - the device is calibrated? if not ask the user to do it
                   * - we need to show the tutorial?
                   */
                    bool isDeviceCalibrated = await PreferenceManager.isDeviceCalibrated;
                    bool showTutorial = await PreferenceManager.showMeasuringTutorial;
                    if (!isDeviceCalibrated)
                      showCalibrateDeviceDialog(context);
                    else if (showTutorial)
                      showTutorialDialog(
                        context,
                        () => context.bloc<CountdownBloc>().add(CountdownEvents.startPreMeasure)
                      );
                    else
                      context.bloc<CountdownBloc>().add(CountdownEvents.startPreMeasure);
                  }
                  else if (state == CountdownState.preMeasure)
                    // Stop the pre measure countdown
                    context.bloc<CountdownBloc>().add(CountdownEvents.stopPreMeasure);
                  else if (state == CountdownState.measure)
                    // Stop the measurement
                    context.bloc<CountdownBloc>().add(CountdownEvents.stopMeasure);
                },
                child: Text(state == CountdownState.idle ? "START TEST" : "STOP TEST"),
              )
            ],
          );
        }
      ),
    );
  }

  /// Return the correct widget based on the current state
  Widget _buildWidgetForState(BuildContext context, CountdownState state) {
    switch(state) {
      case CountdownState.preMeasure:
        return _buildMeasure(context, "pre");
      case CountdownState.measure:
        return _buildMeasure(context, "meas");
      default:
        return Container(
          margin: const EdgeInsets.all(20),
          width: 180,
          height: 180,
          child: Center(
            child: Image.asset("assets/logo.png"),
          ),
        );
    }
  }

  Widget _buildMeasure(BuildContext context, String time) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(90),
      ),
      child: Center(
        child: Text(time),
      ),
    );
  }
}