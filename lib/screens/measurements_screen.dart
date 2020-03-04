import 'package:balance_app/measurements-bloc.dart';
import 'package:balance_app/measurements-state.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/text_appearance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MeasurementsBloc.create(),
      child: BlocBuilder<MeasurementsBloc, MeasurementsState>(
        builder: (context, state) {
          if (state is MeasurementsEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Placeholder(
                    fallbackWidth: 100,
                    fallbackHeight: 100,
                  ),
                  SizedBox(height: 38),
                  Text(
                    "Nothing to show here!",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            );
          }
          if (state is MeasurementsError) {
            return Text("Error!!");
          }
          if (state is MeasurementsSuccess) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemBuilder: (context, index) =>
                _measurementItemTemplate(context, state.measurements[index]),
              itemCount: state.measurements.length,
            );
          }
          return Center(
            child: SizedBox(
              // TODO: 03/03/20 Customize the progress bar
              child: CircularProgressIndicator(
                strokeWidth: 6,
              ),
              height: 100,
              width: 100,
            ),
          );
        }
      ),
    );
  }

  /// Returns a [Widget] with a measurement item
  Widget _measurementItemTemplate(BuildContext context, Measurement measurement) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/result_route", arguments: measurement.id),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Test ${measurement.id}",
                style: Theme.of(context).textTheme.cardTitle
              ),
              SizedBox(height: 12),
              Row(children: <Widget>[
                Icon(Icons.calendar_today, color: Theme.of(context).iconTheme.color),
                SizedBox(width: 16),
                Text(
                  measurement.creationDate,
                  style: Theme.of(context).textTheme.cardBody,
                )
              ]),
              SizedBox(height: 8),
              Row(children: <Widget>[
                Icon(
                  measurement.eyesOpen? Icons.remove_red_eye: Icons.panorama_fish_eye, color: Theme.of(context).iconTheme.color),
                SizedBox(width: 16),
                Text(
                  measurement.eyesOpen? "Eyes Open": "Eyes Closed",
                  style: Theme.of(context).textTheme.cardBody,
                )
              ]),
            ]),
      )),
    );
  }
}