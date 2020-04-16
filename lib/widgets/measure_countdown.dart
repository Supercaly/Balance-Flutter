
import 'dart:async';

import 'package:balance_app/dialog/calibrate_device_dialog.dart';
import 'package:balance_app/dialog/measuring_tutorial_dialog.dart';
import 'package:balance_app/floor/measurement_database.dart';
import 'package:flutter/material.dart';
import 'package:balance_app/manager/preference_manager.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/countdown_bloc.dart';
import 'package:provider/provider.dart';

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
    _bloc = CountdownBloc.create(Provider.of<MeasurementDatabase>(context, listen: false));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<bool> didPopRoute() async{
    // If we are measuring ask the user if he wants to leave
    if (_state == CountdownState.measure) {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Are you sure you want to leave?"),
          content: Text("If you leave the test will fail"),
          actions: [
            // We don't want to leave
            FlatButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("No"),
            ),
            // Stop the test and close the app
            FlatButton(
              onPressed: () {
                _bloc.add(CountdownEvents.stopMeasure);
                Navigator.pop(context, false);
              },
              child: Text("Yes"),
            ),
          ],
        )
      );
    }
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
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () async{
                  // Check if we can start the test
                  if (state == CountdownState.idle) {
                    bool isDeviceCalibrated = await PreferenceManager.isDeviceCalibrated;
                    bool showTutorial = true;
                    if (!isDeviceCalibrated)
                      showCalibrateDeviceDialog(context);
                    else if (showTutorial)
                      showTutorialDialog(context);
                    else
                      context.bloc<CountdownBloc>().add(CountdownEvents.startPreMeasure);
                  }
                  // Stop the pre measure countdown
                  else if (state == CountdownState.preMeasure)
                    context.bloc<CountdownBloc>().add(CountdownEvents.stopPreMeasure);
                  // Stop the measurement
                  else if (state == CountdownState.measure)
                    context.bloc<CountdownBloc>().add(CountdownEvents.stopMeasure);
                },
                child: Text(state == CountdownState.idle ? "Start" : "Stop"),
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: Colors.red.shade200,
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