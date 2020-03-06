import 'package:balance_app/moor/moor-database.dart';
import 'package:balance_app/screens/main_screen.dart';
import 'package:balance_app/screens/result_screen.dart';
import 'package:balance_app/screens/settings_screen.dart';
import 'package:balance_app/res/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	final dbInstance = await MoorDatabase.getDatabase();
	runApp(BalanceApp(dbInstance));
}

class BalanceApp extends StatelessWidget {
	final MoorDatabase dbInstance;

	const BalanceApp(this.dbInstance);

	@override
  Widget build(BuildContext context) {
		return Builder(
			builder: (context) => MultiProvider(
				providers: [
					Provider<MoorDatabase>(create: (context) => dbInstance),
				],
			  child: MaterialApp(
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
			),
		);
  }
}
