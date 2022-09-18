import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';

abstract class AppTextTheme {
  static const headline4 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 34,
    color: AppPalette.textPrimaryColor,
  );

  /// Default
  static const headline5 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: AppPalette.textPrimaryColor,
  );
  static const headline6 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: AppPalette.textPrimaryColor,
  );

  /// Sub head using `copyWith(fontWeight: FontWeight.w600)`
  static const body1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppPalette.textPrimaryColor,
  );
  static const body2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppPalette.textPrimaryColor,
  );
  static const subtitle1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppPalette.textPrimaryColor,
  );
  static const subtitle2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppPalette.textPrimaryColor,
  );
  static const caption = TextStyle(
    fontSize: 11,
    color: AppPalette.grayColor,
    fontWeight: FontWeight.w400,
  );
  static const button = TextStyle(
    color: AppPalette.whiteBackgroundColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  );
}
