import 'package:balance_app/bloc/countdown_bloc.dart';
import 'package:balance_app/bloc/events/countdown_events.dart';
import 'package:balance_app/bloc/states/countdown_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:balance_app/widgets/circular_countdown.dart';

class MeasureCountdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountdownBloc(),
      child: BlocBuilder<CountdownBloc, CountdownState>(
        builder: (context, state) => _buildMeasureWidgets(context, state),
      ),
    );
  }

  Widget _buildMeasureWidgets(BuildContext context, CountdownState state) {
    // ignore: close_sinks
    final CountdownBloc _bloc = BlocProvider.of<CountdownBloc>(context);
    Widget logoWidget;

    switch(state) {
      case CountdownState.idle:
        logoWidget = Container(
          width: 220,
          height: 220,
          color: Colors.red,
        );
        break;
      case CountdownState.preMeasure:
        logoWidget = FakeCounter(5);
        break;
      case CountdownState.measure:
        logoWidget = FakeCounter(32);
        break;
    }

    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(child: logoWidget),
          SizedBox(height: 20),
          Center(
            child: RaisedButton(
              onPressed: () {
                if (state == CountdownState.idle)
                  _bloc.add(CountdownEvents.startPreMeasure);
                else
                  _bloc.add(CountdownEvents.stop);
              },
              child: Text("Start Test"),
            ),
          )
        ],
      ),
    );
  }
}