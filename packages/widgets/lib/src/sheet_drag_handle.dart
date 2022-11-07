import 'package:flutter/material.dart';

class SheetDragHandle extends StatelessWidget {
  const SheetDragHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.4,
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
        ),
      ),
    );
  }
}
