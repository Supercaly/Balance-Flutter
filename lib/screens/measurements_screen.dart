import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/text_appearance.dart';
import 'package:flutter/material.dart';

class MeasurementsScreen extends StatelessWidget {

  // TODO: 03/03/20 Replace this fake data with the good ones from database
  Stream<List<Measurement>> get _fakeMeasurements {
    return Stream.fromFuture(Future.delayed(Duration(seconds: 5), () => [
      Measurement(1, "02-03-2020 20:20:20", true),
      Measurement(2, "02-03-1919 20:20:20", false),
      Measurement(3, "02-03-2020 20:20:20", true),
      Measurement(4, "02-05-2019 20:20:20", false),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Measurement>>(
      stream: _fakeMeasurements,
      builder: (context, snapshot) {
        // Check if there are some errors
        if (snapshot.hasError) {
          print("MeasurementsScreen.build: Error retrieving measurements: ${snapshot.error}");
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Errore!"),
          ));
          return null;
        }
        // Check if there are some data
        if (snapshot.hasData) {
          // The snapshot contains an empty list
          if (snapshot.data.isEmpty)
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
                    style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                  ),
                ],
              ),
            );
          // Build a list with the data from the snapshot
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemBuilder: (context, index) => _measurementItemTemplate(context, snapshot.data[index]),
            itemCount: snapshot.data.length,
          );
        }
        // No data or error present, display the loading screen
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