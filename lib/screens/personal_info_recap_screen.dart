import 'package:flutter/material.dart';

class PersonalInfoRecapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your personal info"),
      ),
      body: Center(
        child: Text("Le tue info qui"),
      ),
    );
  }
}
