import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar({required String message}) {
    final theme = Theme.of(this);
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.onInverseSurface,
          ),
        ),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(this).colorScheme.inverseSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
