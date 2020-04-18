
import 'package:flutter/material.dart';

/// Show a dialog to ask the user if he wants to close the app during the test.
///
/// This method return a [Future] of [bool] used by the method [didPopRoute]
/// to know if the app should be closed or not.
/// [onPositivePressed] is called every time the positive action is pressed
/// and lets the parent Widget stop the test
Future<bool> showLeaveDialog(BuildContext context, VoidCallback onPositivePressed) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Are you sure you want to leave?"),
      content: Text("If you leave the test will fail"),
      actions: [
        // We don't want to leave
        FlatButton(
          onPressed: () {
            // Close the dialog but not the app
            Navigator.pop(context, true);
          },
          child: Text("No"),
        ),
        // Stop the test and close the app
        FlatButton(
          onPressed: () {
            onPositivePressed();
            // Close the dialog and the app
            Navigator.pop(context, false);
          },
          child: Text("Yes"),
        ),
      ],
    )
  );
}