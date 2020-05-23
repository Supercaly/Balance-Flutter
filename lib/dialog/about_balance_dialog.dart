
import 'package:balance_app/res/string.dart';
import 'package:flutter/material.dart';

void showAboutBalanceDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(BStrings.about_balance_title),
      content: Text(BStrings.about_balance_msg),
      actions: [
        FlatButton(
          child: Text(BStrings.cool_btn),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );
}