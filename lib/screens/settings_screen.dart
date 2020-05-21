
import 'package:flutter/material.dart';

import 'package:package_info/package_info.dart';

import 'package:balance_app/res/b_icons.dart';
import 'package:balance_app/res/string.dart';
import 'package:balance_app/routes.dart';
import 'package:balance_app/widgets/settings_widget.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo packageInfo;
  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) => setState(() => packageInfo = value));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SettingsGroup(
          title: BStrings.calibration_title,
          children: [
            SettingsElement(
              icon: Icon(BIcons.calibration),
              text: BStrings.calibrate_your_device_txt,
              onTap: () => Navigator.pushNamed(context, Routes.calibration),
            ),
          ],
        ),
        SettingsGroup(
          title: BStrings.your_information_title,
          children: [
            SettingsElement(
              icon: Icon(Icons.info_outline),
              text: BStrings.what_we_know_about_you_txt,
              onTap: () => Navigator.pushNamed(context, Routes.personal_info_recap),
            )
          ]
        ),
        SettingsGroup(
          title: BStrings.legals_title,
          children: [
            SettingsElement(
              icon: Icon(Icons.adb),
              text: BStrings.open_source_txt,
            ),
          ]
        ),
        SettingsGroup(
          title: BStrings.about_title,
          children: [
            SettingsElement(
              icon: Icon(Icons.hotel),
              text: BStrings.about_balance_txt,
            ),
            SettingsElement(
              text: "${BStrings.version_txt} ${packageInfo?.version} (${packageInfo?.buildNumber})",
              onLongPress: () {
                  Scaffold.of(context)
                    .showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(BStrings.easter_egg_txt),
                        duration: Duration(seconds: 2),
                      )
                  );
              }
            ),
            SettingsElement(
              text: BStrings.made_with_heart_txt,
            ),
          ]
        ),
      ]
    );
  }
}