
import 'package:balance_app/res/colors.dart';
import 'package:balance_app/routes.dart';
import 'package:flutter/material.dart';

/// This class show an introduction when the app is first open.
class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BColors.colorPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: IconTheme(
              child: Icon(Icons.android),
              data: IconThemeData(
                size: 200
              ),
            ),
          ),
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Welcome to Balance",
              style: Theme.of(context).textTheme.headline4.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Description od the app, the reason of his creation and many more...",
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          backgroundColor: BColors.colorAccent,
          onPressed: () => Navigator.pushNamed(context, Routes.onboarding),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /*
  onDone: () async {
        // Set the first time launch as done and go to home page
        await PreferenceManager.firstLaunchDone();
        Navigator.pushReplacementNamed(context, "/main_route");
      },
   */
}