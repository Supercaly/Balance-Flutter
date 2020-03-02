import 'package:balance_app/screens/main_screen.dart';
import 'package:balance_app/screens/result_screen.dart';
import 'package:balance_app/screens/settings_screen.dart';
import 'package:balance_app/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(BalanceApp());

class BalanceApp extends StatelessWidget {
	@override
  Widget build(BuildContext context) {
		return Builder(
			builder: (context) => MaterialApp(
		  	title: "Balance",
		  	initialRoute: "/main_route",
		  	theme: lightTheme,
		  	darkTheme: darkTheme,
		  	routes: {
		  		"/main_route": (context) => MainScreen(),
		  		"/settings_route": (context) => SettingsScreen(),
		  		"/result_route": (context) => ResultScreen()
		  	},
		  ),
		);
  }
}
