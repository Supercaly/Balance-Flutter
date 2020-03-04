import 'package:flutter/material.dart';
import 'package:balance_app/res/colors.dart';

/// Light Theme for the app
final ThemeData lightTheme = ThemeData.light().copyWith(
  // Theme colors
  primaryColor: BColors.colorPrimary,
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: BColors.colorPrimaryLight,
  primaryColorDark: BColors.colorPrimaryDark,
  accentColor: BColors.colorAccent,
  accentColorBrightness: Brightness.dark,
  // TODO: 02/03/20 Sostituire con il colore migliore
  hintColor: Color( 0x8a000000 ),
  errorColor: Color( 0xffd32f2f ),
  // Button theme
  buttonTheme: ButtonThemeData(
    buttonColor: BColors.colorPrimary,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
  ),
  // Text Theme
  textTheme: TextTheme(
    headline1: TextStyle(
      color: BColors.textColor,
      fontSize: 96.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),
    headline2: TextStyle(
      color: BColors.textColor,
      fontSize: 60.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
    ),
    headline3: TextStyle(
      color: BColors.textColor,
      fontSize: 48.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline4: TextStyle(
      color: BColors.textColor,
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline5: TextStyle(
      color: BColors.textColor,
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline6: TextStyle(
      color: BColors.textColor,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: TextStyle(
      color: BColors.textColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: TextStyle(
      color: BColors.textColor,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: TextStyle(
      color: BColors.textColor,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyText2: TextStyle(
      color: BColors.textColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    caption: TextStyle(
      color: BColors.textColor,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    button: TextStyle(
      color: BColors.textColor,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    overline: TextStyle(
      color: BColors.textColor,
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  iconTheme: IconThemeData(
    color: BColors.textColor,
  ),
);

/// Dark Theme for the app
final ThemeData darkTheme = ThemeData.dark().copyWith(
  // Theme colors
  accentColor: BColors.colorAccent,
  accentColorBrightness: Brightness.dark,
  // TODO: 02/03/20 Sostituire con il colore migliore
  hintColor: Color( 0x8a000000 ),
  errorColor: Color( 0xffd32f2f ),
  // Button theme
  buttonTheme: ButtonThemeData(
    buttonColor: BColors.colorPrimary,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
  ),
);