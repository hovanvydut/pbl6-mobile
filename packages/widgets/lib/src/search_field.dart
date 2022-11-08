import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.focusNode,
    required this.hintText,
    required this.suffixIcon,
    this.onChanged,
    this.onSuffixIconPressed,
  });

  final FocusNode? focusNode;
  final String hintText;
  final Widget suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSuffixIconPressed;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _searchController;
  late bool _isValueEmpty;

  @override
  void initState() {
    super.initState();
    _isValueEmpty = true;
    _searchController = TextEditingController()
      ..addListener(() {
        setState(() {
          _isValueEmpty = _searchController.text.isEmpty;
        });
      });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: _searchController,
        decoration: InputDecoration(  
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          suffixIcon: !_isValueEmpty
              ? IconButton(
                  icon: widget.suffixIcon,
                  onPressed: () {
                    _searchController.clear();
                    widget.onSuffixIconPressed?.call(_searchController.text);
                  },
                )
              : null,
        ),
        onChanged: (_) => widget.onChanged?.call(_searchController.text),
      ),
    );
  }
}
