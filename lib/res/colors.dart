import 'dart:ui';

import 'package:flutter/material.dart';

// Class containing all the [MaterialColor] of the app
class BColors {
  static const MaterialColor colorPrimary = _malibu;
  static const MaterialColor colorPrimaryDark = _scampi;
  static const MaterialColor colorPrimaryLight = _periwinkle;
  static const MaterialColor colorAccent = _dodger_blue;
  static const Color textColor = _dove_gray;

  static const MaterialColor _malibu = MaterialColor(0xFF8C88FF, {
    50: Color.fromRGBO(140, 136, 255, .1),
    100: Color.fromRGBO(140, 136, 255, .2),
    200: Color.fromRGBO(140, 136, 255, .3),
    300: Color.fromRGBO(140, 136, 255, .4),
    400: Color.fromRGBO(140, 136, 255, .5),
    500: Color.fromRGBO(140, 136, 255, .6),
    600: Color.fromRGBO(140, 136, 255, .7),
    700: Color.fromRGBO(140, 136, 255, .8),
    800: Color.fromRGBO(140, 136, 255, .9),
    900: Color.fromRGBO(140, 136, 255, 1),
  });
  static const MaterialColor _scampi = MaterialColor(0xFF6865AC, {
    50: Color.fromRGBO(104, 101, 172, .1),
    100: Color.fromRGBO(104, 101, 172, .2),
    200: Color.fromRGBO(104, 101, 172, .3),
    300: Color.fromRGBO(104, 101, 172, .4),
    400: Color.fromRGBO(104, 101, 172, .5),
    500: Color.fromRGBO(104, 101, 172, .6),
    600: Color.fromRGBO(104, 101, 172, .7),
    700: Color.fromRGBO(104, 101, 172, .8),
    800: Color.fromRGBO(104, 101, 172, .9),
    900: Color.fromRGBO(104, 101, 172, 1),
  });
  static const MaterialColor _periwinkle = MaterialColor(0xFFCECCFF, {
    50: Color.fromRGBO(206, 204, 255, .1),
    100: Color.fromRGBO(206, 204, 255, .2),
    200: Color.fromRGBO(206, 204, 255, .3),
    300: Color.fromRGBO(206, 204, 255, .4),
    400: Color.fromRGBO(206, 204, 255, .5),
    500: Color.fromRGBO(206, 204, 255, .6),
    600: Color.fromRGBO(206, 204, 255, .7),
    700: Color.fromRGBO(206, 204, 255, .8),
    800: Color.fromRGBO(206, 204, 255, .9),
    900: Color.fromRGBO(206, 204, 255, 1),
  });
  static const MaterialColor _dodger_blue = MaterialColor(0xFF34C6F9, {
    50: Color.fromRGBO(52, 198, 249, .1),
    100: Color.fromRGBO(52, 198, 249, .2),
    200: Color.fromRGBO(52, 198, 249, .3),
    300: Color.fromRGBO(52, 198, 249, .4),
    400: Color.fromRGBO(52, 198, 249, .5),
    500: Color.fromRGBO(52, 198, 249, .6),
    600: Color.fromRGBO(52, 198, 249, .7),
    700: Color.fromRGBO(52, 198, 249, .8),
    800: Color.fromRGBO(52, 198, 249, .9),
    900: Color.fromRGBO(52, 198, 249, 1),
  });
  static const MaterialColor _venice_blue = MaterialColor(0xFF0A698D, {
    50: Color.fromRGBO(10, 105, 141, .1),
    100: Color.fromRGBO(10, 105, 141, .2),
    200: Color.fromRGBO(10, 105, 141, .3),
    300: Color.fromRGBO(10, 105, 141, .4),
    400: Color.fromRGBO(10, 105, 141, .5),
    500: Color.fromRGBO(10, 105, 141, .6),
    600: Color.fromRGBO(10, 105, 141, .7),
    700: Color.fromRGBO(10, 105, 141, .8),
    800: Color.fromRGBO(10, 105, 141, .9),
    900: Color.fromRGBO(10, 105, 141, 1),
  });
  static const MaterialColor _lili_white = MaterialColor(0xFFE4F5FF, {
    50: Color.fromRGBO(228, 245, 255, .1),
    100: Color.fromRGBO(228, 245, 255, .2),
    200: Color.fromRGBO(228, 245, 255, .3),
    300: Color.fromRGBO(228, 245, 255, .4),
    400: Color.fromRGBO(228, 245, 255, .5),
    500: Color.fromRGBO(228, 245, 255, .6),
    600: Color.fromRGBO(228, 245, 255, .7),
    700: Color.fromRGBO(228, 245, 255, .8),
    800: Color.fromRGBO(228, 245, 255, .9),
    900: Color.fromRGBO(228, 245, 255, 1),
  });

  static const Color _dove_gray = Color.fromARGB(255, 102, 102, 102);
}