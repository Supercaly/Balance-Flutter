import 'package:flutter/material.dart';

/// Extension on [TextTheme] adding some specific [TextStyle]s
extension BTextTheme on TextTheme {
  TextStyle get featureTitle => headline6.copyWith(
    fontSize: 19.0,
    fontWeight: FontWeight.w600,
  );
  TextStyle get featuresHeadline => subtitle2.copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
  );
  TextStyle get featuresValue => caption.copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );
  TextStyle get featuresValueBold => caption.copyWith(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );

  TextStyle get cardTitle => headline5.copyWith(
    fontSize: 28.0,
    fontWeight: FontWeight.w500,
  );
  TextStyle get cardBody => bodyText1.copyWith(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
}