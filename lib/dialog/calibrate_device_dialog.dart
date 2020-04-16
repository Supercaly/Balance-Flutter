
import 'package:flutter/material.dart';
import 'package:balance_app/routes.dart';

/// Display a dialog that prompt the user to the calibration screen
void showCalibrateDeviceDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text("You need to calibrate the device!"),
      content: Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        "Duis ipsum scelerisque ipsum, nec quam sit ac et. Dui integer lacus eu "
        "sed nulla eu dolor nulla felis."
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.calibration);
          },
          child: Text("GOT IT"),
        )
      ],
    ),
  );
}