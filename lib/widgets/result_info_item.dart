
import 'package:balance_app/floor/test_database_view.dart';
import 'package:balance_app/res/b_icons.dart';
import 'package:balance_app/res/string.dart';
import 'package:flutter/material.dart';

/// Widget that represent a single result info item
///
/// This Widget displays a Card containing the date and
/// eye information of a given [Test]
class ResultInfoItem extends StatelessWidget {
  final Test test;

  ResultInfoItem(this.test);

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
                Icon(BIcons.calendar, color: Theme.of(context).iconTheme.color),
                SizedBox(width: 16),
                Text(
                  // TODO: 05/04/20 Fix how to display the error
                  DateTime.fromMillisecondsSinceEpoch(test?.creationDate ?? 0).toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  // TODO: 05/04/20 Fix the error icon
                  test.eyesOpen? BIcons.eye_open: BIcons.eye_close,
                ),
                SizedBox(width: 16),
                Text(
                  // TODO: 05/04/20 Fix the error text
                  test.eyesOpen? BStrings.eyes_open: BStrings.eyes_closed,
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