import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class AppDropDownMuliSelectField extends StatelessWidget {
  const AppDropDownMuliSelectField({
    super.key,
    this.labelText,
    this.errorText,
    required this.options,
    required this.selectedItems,
    required this.onChanged,
  });

  final String? labelText;
  final String? errorText;
  final List<String> options;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropDownMultiSelect(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        labelText: labelText,
        errorText: errorText,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      onChanged: onChanged,
      options: options,
      selectedValues: selectedItems,
    );
  }
}
