import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.errorText,
    this.suffixIcon,
    this.onChanged,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.lastField = false,
  });

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool lastField;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputAction = textInputAction ??
        (lastField ? TextInputAction.go : TextInputAction.next);
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        suffixIcon: suffixIcon,
        hintStyle: theme.textTheme.bodyLarge,
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.all(8),
        //   child: Assets.icons.emailOutline.svg(),
        // ),
      ),
      textInputAction: inputAction,
      onChanged: onChanged,
    );
  }
}
