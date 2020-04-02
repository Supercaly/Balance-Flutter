
import 'package:balance_app/bloc/measurements_bloc.dart';
import 'package:balance_app/bloc/states/measurements_state.dart';
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:balance_app/routes.dart';

class MeasurementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MeasurementsBloc.create(Provider.of<MeasurementDatabase>(context, listen: false)),
      child: BlocBuilder<MeasurementsBloc, MeasurementsState>(
        builder: (context, state) {
          if (state is MeasurementsEmpty)
            return _emptyScreen(context);
          if (state is MeasurementsError)
            return _errorScreen(context);
          if (state is MeasurementsSuccess)
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) =>
                _measurementItemTemplate(context, state.measurements[index]),
              itemCount: state.measurements.length,
            );
          return _loadingScreen(context);
        }
      ),
    );
  }

  /// Build the empty screen
  Widget _emptyScreen(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconTheme(
          data: IconThemeData(
            size: 100
          ),
          child: Icon(Icons.perm_data_setting),
        ),
        SizedBox(height: 42),
        Text(
          "Nothing to show here!",
          style: Theme.of(context).textTheme.headline5.copyWith(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    ),
  );

  /// Build the error screen
  Widget _errorScreen(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconTheme(
          data: IconThemeData(
            size: 100
          ),
          child: Icon(Icons.error),
        ),
        SizedBox(height: 42),
        Text(
          "Ops! Something went wrong",
          style: Theme.of(context).textTheme.headline5.copyWith(
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    ),
  );

  /// Build the loading screen
  Widget _loadingScreen(BuildContext context) => Center(
    child: Text("loading..."),
  );

  /// Returns a [Widget] with a measurement item
  Widget _measurementItemTemplate(BuildContext context, Measurement measurement) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, Routes.result, arguments: measurement.id),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Test ${measurement.id}",
                style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w500
                )
              ),
              SizedBox(height: 12),
              Row(children: <Widget>[
                Icon(Icons.calendar_today),
                SizedBox(width: 16),
                Text(
                  measurement.creationDate.toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ]),
              SizedBox(height: 8),
              Row(children: <Widget>[
                Icon(
                  measurement.eyesOpen?
                    Icons.remove_red_eye:
                    Icons.panorama_fish_eye,
                ),
                SizedBox(width: 16),
                Text(
                  measurement.eyesOpen? "Eyes Open": "Eyes Closed",
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ]),
            ]
          ),
        ),
      ),
    );
  }
}