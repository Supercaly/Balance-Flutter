
import 'package:balance_app/res/string.dart';
import 'package:flutter/material.dart';
import 'package:balance_app/routes.dart';

/// Display a dialog that prompt the user to the calibration screen
void showCalibrateDeviceDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(BStrings.need_to_calibrate_title),
      content: Text(BStrings.need_to_calibrate_msg),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.calibration);
          },
          child: Text(BStrings.got_it_btn),
        )
      ],
    ),
  );
}