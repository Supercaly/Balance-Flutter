import 'package:balance_app/manager/preference_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

/// This class show an introduction when the app is first open.
class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Balance",
          body: "Description od the app, the reason of his creation and many more...",
          image: Center(child: Icon(Icons.android)),
        ),
        PageViewModel(
          title: "Page 2",
          body: "Description 2",
          image: Center(child: Icon(Icons.map)),
        ),
        PageViewModel(
          title: "Page 3",
          body: "Description 3",
          image: Center(child: Icon(Icons.watch)),
        ),
      ],
      next: Icon(Icons.arrow_forward_ios),
      done: Text("Done"),
      onDone: () async {
        // Set the first time launch as done and go to home page
        await PreferenceManager.firstLaunchDone();
        Navigator.pushReplacementNamed(context, "/main_route");
      },
    );
  }
}