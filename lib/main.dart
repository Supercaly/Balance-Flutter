import 'package:balance_app/colors.dart';
import 'package:balance_app/screens/main_screen.dart';
import 'package:balance_app/screens/result_screen.dart';
import 'package:balance_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(BalanceApp());

class BalanceApp extends StatelessWidget {

	static final ThemeData lightTheme = ThemeData(
		brightness: Brightness.light,
		primarySwatch: BColors.colorPrimary,
		primaryColorDark: BColors.colorPrimaryDark,
		accentColor: BColors.colorAccent,
		accentColorBrightness: Brightness.light,
		buttonTheme: ButtonThemeData(
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
			buttonColor: BColors.colorPrimary,
			textTheme: ButtonTextTheme.primary
		),
	);

	static final ThemeData darkTheme = ThemeData.dark().copyWith(
		accentColor: BColors.colorAccent,
		accentColorBrightness: Brightness.dark,
		buttonTheme: ButtonThemeData(
			buttonColor: BColors.colorPrimary,
			textTheme: ButtonTextTheme.primary
		),
	);

	@override
  Widget build(BuildContext context) {
		return MaterialApp(
			title: "Balance",
			initialRoute: "/main_route",
			theme: lightTheme,
			darkTheme: darkTheme,
			routes: {
				"/main_route": (context) => MainScreen(),
				"/settings_route": (context) => SettingsScreen(),
				"/result_route": (context) => ResultScreen()
			},
		);
  }
}
