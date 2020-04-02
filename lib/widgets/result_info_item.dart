
import 'package:balance_app/model/measurement.dart';
import 'package:flutter/material.dart';

/// Widget that represent a single result info item
///
/// This Widget displays a Card containing the date and
/// eye information of a given [Measurement]
class ResultInfoItem extends StatelessWidget {
  final Measurement measurement;

  ResultInfoItem(this.measurement);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.today, color: Theme.of(context).iconTheme.color),
                SizedBox(width: 16),
                Text(
                  DateTime.fromMicrosecondsSinceEpoch(measurement.creationDate).toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  measurement.eyesOpen? Icons.remove_red_eye: Icons.panorama_fish_eye,
                ),
                SizedBox(width: 16),
                Text(
                  measurement.eyesOpen? "Eyes Open": "Eye Closed",
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}