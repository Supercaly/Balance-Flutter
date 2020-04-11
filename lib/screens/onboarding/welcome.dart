
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

/// First intro screen
///
/// This Widget represents the first of the intro
/// screens, his purpose is to display a welcome
/// message to the user and explain the app.
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) => current is NeedToValidateState && current.index == 0,
      // This page is always valid
      listener: (context, _) => context.bloc<IntroBloc>().add(ValidationSuccessEvent()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: IconTheme(
              child: Icon(Icons.android),
              data: IconThemeData(
                size: 200,
                color: Colors.white
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
    );
  }
}