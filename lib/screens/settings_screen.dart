
import 'package:balance_app/res/b_icons.dart';
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
          title: "Calibration",
          children: [
            SettingsElement(
              icon: Icon(BIcons.calibration),
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
              text: "${BStrings.version_txt} ${packageInfo?.version} (${packageInfo?.buildNumber})",
              onLongPress: () {
                  Scaffold.of(context)
                    .showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
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