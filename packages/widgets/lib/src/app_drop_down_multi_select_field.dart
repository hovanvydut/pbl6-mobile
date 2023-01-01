import 'package:enhanced_multiselect/enhanced_multiselect.dart';
import 'package:flutter/material.dart';

class AppDropDownMuliSelectField extends StatefulWidget {
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
  State<AppDropDownMuliSelectField> createState() =>
      _AppDropDownMuliSelectFieldState();
}

class _AppDropDownMuliSelectFieldState
    extends State<AppDropDownMuliSelectField> {
  List<String> _selected = [];

  @override
  void didUpdateWidget(covariant AppDropDownMuliSelectField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItems != oldWidget.selectedItems) {
      _selected = widget.selectedItems;
    }
  }

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
        labelText: widget.labelText,
        errorText: widget.errorText,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      onChanged: widget.onChanged,
      options: widget.options,
      selectedValues: _selected,
    );
  }
}
