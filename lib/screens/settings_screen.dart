
import 'package:balance_app/routes.dart';
import 'package:balance_app/widgets/settings_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SettingsGroup(
          title: "Calibration",
          children: [
            SettingsElement(
              icon: Icon(Icons.send),
              text: "Calibrate your Device",
              onTap: () => Navigator.pushNamed(context, Routes.calibration),
            ),
          ],
        ),
        SettingsGroup(
          title: "You Informations",
          children: [
            SettingsElement(
              icon: Icon(Icons.info_outline),
              text: "What we know about you",
              onTap: () => Navigator.pushNamed(context, Routes.personal_info_recap),
            )
          ]
        ),
        SettingsGroup(
          title: "Legals",
          children: [
            SettingsElement(
              icon: Icon(Icons.chrome_reader_mode),
              text: "Privacy policy",
            ),
            SettingsElement(
              icon: Icon(Icons.adb),
              text: "Open Source",
            ),
          ]
        ),
        SettingsGroup(
          title: "About",
          children: [
            SettingsElement(
              icon: Icon(Icons.hotel),
              text: "About Balance",
            ),
            SettingsElement(
              text: "Version 0.0.1 (1)",
              onLongPress: () {
                  Scaffold.of(context)
                    .showSnackBar(
                      SnackBar(
                        content: Text("This is not an Easter Egg!!!"),
                        duration: Duration(seconds: 2),
                      )
                  );
              }
            ),
            SettingsElement(
              text: "Made with ❤ from Italy",
            ),
          ]
        ),
      ]
    );
  }
}