
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_app/res/theme.dart';
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/manager/preference_manager.dart';
import 'package:balance_app/routes.dart';

import 'package:balance_app/screens/personal_info_recap_screen.dart';
import 'package:balance_app/screens/intro_screen.dart';
import 'package:balance_app/screens/main_screen.dart';
import 'package:balance_app/screens/result_screen.dart';
import 'package:balance_app/screens/calibrate_device_screen.dart';
import 'package:balance_app/screens/onboarding_screen.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	// Create an app-wide instance of the database
	final isFirstTimeLaunch = await PreferenceManager.isFirstTimeLaunch;
	final dbInstance = await MeasurementDatabase.getDatabase();
	runApp(BalanceApp(isFirstTimeLaunch, dbInstance));
}

class BalanceApp extends StatelessWidget {
	final bool isFirstLaunch;
	final MeasurementDatabase dbInstance;

	const BalanceApp(this.isFirstLaunch, this.dbInstance);

	@override
  Widget build(BuildContext context) {
		return Builder(
			builder: (context) => MultiProvider(
				providers: [
					Provider<MeasurementDatabase>(create: (context) => dbInstance),
				],
			  child: MaterialApp(
					title: "Balance",
					initialRoute: isFirstLaunch ? Routes.intro: Routes.main,
					theme: lightTheme,
					darkTheme: darkTheme,
					routes: {
						Routes.intro: (_) => IntroScreen(),
						Routes.main: (_) => MainScreen(),
						Routes.calibration: (_) => CalibrateDeviceScreen(),
						Routes.personal_info_recap: (_) => PersonalInfoRecapScreen(),
						Routes.onboarding: (_) => OnBoardingScreen(),
						Routes.result: (_) => ResultScreen()
					},
				),
			),
		);
  }
}
