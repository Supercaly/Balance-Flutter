import 'package:balance_app/routes.dart';
import 'package:balance_app/widgets/settings_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _easterEggTapCount;

  @override
  void initState() {
    _easterEggTapCount = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SettingsGroup(
          title: "Calibration",
          children: [
            SettingsElement(
              icon: Icon(Icons.send),
              text: Text("Calibrate your Device"),
              onTap: () => Navigator.pushNamed(context, Routes.calibration),
            ),
          ],
        ),
        SettingsGroup(
          title: "You Informations",
          children: [
            SettingsElement(
              icon: Icon(Icons.info_outline),
              text: Text("What we know about you"),
              onTap: () => Navigator.pushNamed(context, Routes.calibration),
            )
          ]
        ),
        SettingsGroup(
          title: "Legals",
          children: [
            SettingsElement(
              icon: Icon(Icons.chrome_reader_mode),
              text: Text("Privacy policy"),
            ),
            SettingsElement(
              icon: Icon(Icons.adb),
              text: Text("Open Source"),
            ),
          ]
        ),
        SettingsGroup(
          title: "About",
          children: [
            SettingsElement(
              icon: Icon(Icons.hotel),
              text: Text("About Balance"),
            ),
            SettingsElement(
              text: Text("Version 0.0.1 (1)"),
              onTap: () {
                _easterEggTapCount++;
                if (_easterEggTapCount == 5) {
                  _easterEggTapCount = 0;
                  Scaffold.of(context)
                    .showSnackBar(
                      SnackBar(
                        content: Text("This is not an Easter Egg!!!"),
                        duration: Duration(seconds: 2),
                      )
                  );
                }
              }
            ),
            SettingsElement(
              text: Text("Made with ❤ from Italy"),
            ),
          ]
        ),
      ]
    );
  }
}