import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

class DetailPostDescription extends StatelessWidget {
  const DetailPostDescription({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Chi tiết',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          post.description ?? '',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
