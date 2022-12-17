library multiselect;

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class _TheState {}

var _theState = RM.inject(() => _TheState());

class _SelectRow extends StatelessWidget {
  const _SelectRow({
    Key? key,
    required this.onChange,
    required this.selected,
    required this.text,
  }) : super(key: key);
  final Function(bool) onChange;
  final bool selected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!selected);
        _theState.notify();
      },
      child: Container(
        height: kMinInteractiveDimension,
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).colorScheme.primary,
              value: selected,
              onChanged: (x) {
                onChange(x!);
                _theState.notify();
              },
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}

///
/// A Dropdown multiselect menu
///
///
class DropDownMultiSelect extends StatefulWidget {
  const DropDownMultiSelect({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.whenEmpty,
    this.icon,
    this.hint,
    this.hintStyle,
    this.childBuilder,
    this.menuItembuilder,
    this.isDense = true,
    this.enabled = true,
    this.decoration,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  /// The options form which a user can select
  final List<String> options;

  /// Selected Values
  final List<String> selectedValues;

  /// This function is called whenever a value changes
  final Function(List<String>) onChanged;

  /// defines whether the field is dense
  final bool isDense;

  /// defines whether the widget is enabled;
  final bool enabled;

  /// Input decoration
  final InputDecoration? decoration;

  /// this text is shown when there is no selection
  final String? whenEmpty;

  /// a function to build custom childern
  final Widget Function(List<String> selectedValues)? childBuilder;

  /// a function to build custom menu items
  final Widget Function(String option)? menuItembuilder;

  /// a function to validate
  final String Function(String? selectedOptions)? validator;

  /// defines whether the widget is read-only
  final bool readOnly;

  /// icon shown on the right side of the field
  final Widget? icon;

  /// Textstyle for the hint
  final TextStyle? hintStyle;

  /// hint to be shown when there's nothing else to be shown
  final Widget? hint;

  @override
  _DropDownMultiSelectState createState() => _DropDownMultiSelectState();
}

class _DropDownMultiSelectState extends State<DropDownMultiSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: widget.decoration?.errorText == null
            ? Alignment.centerLeft
            : AlignmentDirectional.topStart,
        children: [
          _theState.rebuild(
            () => widget.childBuilder != null
                ? widget.childBuilder!(widget.selectedValues)
                : Padding(
                    padding: widget.decoration != null
                        ? widget.decoration!.contentPadding != null
                            ? widget.decoration!.contentPadding!
                            : EdgeInsets.symmetric(horizontal: 10) +
                                (widget.decoration?.errorText != null
                                    ? EdgeInsets.only(top: 12)
                                    : EdgeInsets.all(0))
                        : EdgeInsets.symmetric(horizontal: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        widget.selectedValues.length > 0
                            ? widget.selectedValues
                                .reduce((a, b) => a + ', ' + b)
                            : '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
          ),
          Container(
            child: DropdownButtonFormField<String>(
              hint: widget.hint,
              style: widget.hintStyle,
              icon: widget.icon,
              validator: widget.validator != null ? widget.validator : null,
              decoration: widget.decoration,
              onChanged: widget.enabled ? (x) {} : null,
              value: widget.selectedValues.length > 0
                  ? widget.selectedValues[0]
                  : null,
              selectedItemBuilder: (context) {
                return widget.options
                    .map<DropdownMenuItem>(
                      (e) => DropdownMenuItem(
                        child: SizedBox.shrink(),
                      ),
                    )
                    .toList();
              },
              items: widget.options
                  .map(
                    (x) => DropdownMenuItem(
                      value: x,
                      onTap: !widget.readOnly
                          ? () {
                              if (widget.selectedValues.contains(x)) {
                                var ns = widget.selectedValues..add(x);
                                widget.onChanged(ns);
                              } else {
                                var ns = widget.selectedValues..remove(x);

                                widget.onChanged(ns);
                              }
                            }
                          : null,
                      child: _theState.rebuild(() {
                        return widget.menuItembuilder != null
                            ? widget.menuItembuilder!(x)
                            : _SelectRow(
                                selected: widget.selectedValues.contains(x),
                                text: x,
                                onChange: (isSelected) {
                                  if (isSelected) {
                                    var ns = widget.selectedValues..add(x);
                                    widget.onChanged(ns);
                                  } else {
                                    var ns = widget.selectedValues..remove(x);

                                    widget.onChanged(ns);
                                  }
                                },
                              );
                      }),
                    ),
                  )
                  .toList(),
            ),
          ),
          // ),
        ],
      ),
    );
  }
}
