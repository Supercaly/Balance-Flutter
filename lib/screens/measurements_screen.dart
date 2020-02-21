import 'package:flutter/material.dart';

class MeasurementsScreen extends StatelessWidget {

  final List<int> results = [0,1,2,3,4,5];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      itemBuilder: (context, index) => measurementItemTemplate(context, results[index]),
      itemCount: results.length,
    );
  }

  Widget measurementItemTemplate(BuildContext context, int measId) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/result_route"),
      child: Card(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Test $measId", style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 12),
              Row(children: <Widget>[
                Icon(Icons.calendar_today),
                Text("20/20/2020 20:20:20")
              ]),
              SizedBox(height: 8),
              Row(children: <Widget>[
                Icon(Icons.remove_red_eye),
                Text("Eye Open")
              ]),
            ])
        ),
      )),
    );
  }
}