import 'package:balance_app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text("Settings", style: TextStyle(fontSize: 30.0)),
          FlatButton(
            child: Text("cALIbrate"),
            onPressed: () => Navigator.pushNamed(context, Routes.calibration),
          )
        ]
      )
    );
  }
}
