
import 'package:balance_app/manager/preference_manager.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Show the [TutorialDialog]
///
/// The callback [onDone] is called every time the action button
/// is pressed and it lets the parent Widget start the measuring
void showTutorialDialog(BuildContext context, VoidCallback onDone) {
  showDialog(
    context: context,
    builder: (context) => TutorialDialog(onDone),
  );
}

/// Widget that implements a tutorial dialog
///
/// This dialog has the purpose of teaching the user
/// how to correctly perform a measurement.
class TutorialDialog extends StatefulWidget {
  final VoidCallback callback;

  TutorialDialog(this.callback);

  @override
  _TutorialDialogState createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog> {
  bool _neverShowAgainCheck = false;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            height: 267,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(9.0))
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                "Scelerisque eu ultricies aliquet quis a fermentum, dignissim"
                " facilisi a. Egestas mattis sem eget aliquam molestie ac. "
                "Augue mi sit hac."
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() => _neverShowAgainCheck = !_neverShowAgainCheck);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularCheckBox(
                    value: _neverShowAgainCheck,
                    onChanged: (value) {
                      setState(() => _neverShowAgainCheck = value);
                    },
                    activeColor: Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Text("Never show again"),
                ],
              ),
            ),
          )
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () {
            if (_neverShowAgainCheck)
              PreferenceManager.neverShowMeasuringTutorial();
            widget.callback();
            Navigator.pop(context);
          },
          child: Text("OK")
        ),
      ],
    );
  }
}
