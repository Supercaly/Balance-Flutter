
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PersonalInfoRecapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Text styles used by the widget
    final titleTextStyle = Theme.of(context).textTheme.subtitle2.copyWith(
      fontSize: 17,
    );
    final headlineTextStyle = Theme.of(context).textTheme.bodyText1;
    final valueTextStyle = Theme.of(context).textTheme.caption;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your personal info"),
      ),
      body: ListView(
        children: <Widget>[
          // General Info Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "General".toUpperCase(),
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Age",
                        style: headlineTextStyle,
                      ),
                      Text(
                        "18",
                        style: valueTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Gender",
                        style: headlineTextStyle,
                      ),
                      Text(
                        "male",
                        style: valueTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Height",
                        style: headlineTextStyle,
                      ),
                      Text(
                        "180 cm",
                        style: valueTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Weight",
                        style: headlineTextStyle,
                      ),
                      Text(
                        "80 Kg",
                        style: valueTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Health Info Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Health".toUpperCase(),
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Postural problems",
                        style: headlineTextStyle,
                      ),
                      Text(
                        "[scogliosi, cifosi]",
                        style: valueTextStyle,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Postural problems in family",
                        style: headlineTextStyle,
                      ),
                      Text(
                        "no",
                        style: valueTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "Use of drugs that can interfere with balance",
                          style: headlineTextStyle,
                        )
                      ),
                      Text(
                        "yes",
                        style: valueTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Trauma Info Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Trauma".toUpperCase(),
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Other trauma",
                        style: headlineTextStyle,
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        child: Text(
                          "[Fratture, Operazioni agli arti, Cadute, Distorsioni, Trauma Cranico]",
                          style: valueTextStyle,
                          textAlign: TextAlign.end,
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Sight/Hear Defects Info Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Difetti Visivi/Uditivi".toUpperCase(),
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Difetti visivi",
                        style: headlineTextStyle,
                      ),
                      Text(
                        "none",
                        style: valueTextStyle,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Difetti uditivi",
                        style: headlineTextStyle,
                      ),
                      Text(
                        "light",
                        style: valueTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 76),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("Edit settings..."),
        child: Icon(Icons.edit),
      ),
    );
  }
}
