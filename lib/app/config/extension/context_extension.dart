import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;
}

extension EdgeInsetsExtension on BuildContext {
  EdgeInsets get padding => MediaQuery.of(this).padding;
}
