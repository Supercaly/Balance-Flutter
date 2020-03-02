import 'package:balance_app/text_appearance.dart';
import 'package:flutter/material.dart';

class MeasurementsScreen extends StatelessWidget {
  final List<int> results = [1,2,3,5,8];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      itemBuilder: (context, index) => _measurementItemTemplate(context, results[index]),
      itemCount: results.length,
    );
  }

  Widget _measurementItemTemplate(BuildContext context, int measId) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/result_route", arguments: measId),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Test $measId",
                style: Theme.of(context).textTheme.cardTitle
              ),
              SizedBox(height: 12),
              Row(children: <Widget>[
                Icon(Icons.calendar_today, color: Theme.of(context).iconTheme.color),
                SizedBox(width: 16),
                Text(
                  "20/20/2020 20:20:20",
                  style: Theme.of(context).textTheme.cardBody,
                )
              ]),
              SizedBox(height: 8),
              Row(children: <Widget>[
                Icon(Icons.remove_red_eye, color: Theme.of(context).iconTheme.color),
                SizedBox(width: 16),
                Text(
                  "Eye Open",
                  style: Theme.of(context).textTheme.cardBody,
                )
              ]),
            ]),
      )),
    );
  }
}