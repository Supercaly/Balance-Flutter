
import 'package:balance_app/res/string.dart';
import 'package:flutter/material.dart';

/// Show a dialog to ask the user if he wants to close the app during the test.
///
/// This method return a [Future] of [bool] used by the method [didPopRoute]
/// to know if the app should be closed or not.
Future<bool> showLeaveDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(BStrings.leave_dialog_title),
      content: Text(BStrings.leave_dialog_msg),
      actions: [
        // We don't want to leave
        FlatButton(
          onPressed: () {
            // Close the dialog but not the app
            Navigator.pop(context, true);
          },
          child: Text(BStrings.no),
        ),
        // Stop the test and close the app
        FlatButton(
          onPressed: () {
            // Close the dialog and the app
            Navigator.pop(context, false);
          },
          child: Text(BStrings.yes),
        ),
      ],
    )
  );
}