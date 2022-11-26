import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets/widgets.dart';

extension SizeExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;
}

extension EdgeInsetsExtension on BuildContext {
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
}

extension MoreGoRouterExtenstion on BuildContext {
  String get currentLocation => GoRouter.of(this).location;

  String currentWithChild(String child) {
    if (currentLocation == '/') {
      return '/$child';
    }
    return '${GoRouter.of(this).location}/$child';
  }

  void goToChild(String child, {Object? extra}) =>
      GoRouter.of(this).go(currentWithChild(child), extra: extra);

  void pushToChild(String child, {Object? extra}) =>
      GoRouter.of(this).push(currentWithChild(child), extra: extra);
}

extension NavigatorToViewFullImageExtension on BuildContext {
  void pushToViewImage(String imageUrl) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (_) => FullImageView(imageUrl: imageUrl),
      ),
    );
  }
}
