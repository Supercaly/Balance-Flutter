
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void showTutorialDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularCheckBox(
                  value: true,
                  onChanged: (_) {},
                  activeColor: Colors.blue,
                ),
                SizedBox(width: 8),
                Text("Never show again"),
              ],
            ),
          )
        ],
      ),
      actions: [
        FlatButton(
          onPressed: null,
          child: Text("OK"),
        )
      ],
    ),
  );
}