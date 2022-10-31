import 'package:flutter/material.dart';

class PostSearchPanel extends StatelessWidget {
  const PostSearchPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Tìm theo quận, tên đường, địa điểm',
          hintStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
