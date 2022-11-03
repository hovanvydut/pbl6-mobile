import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

class BasicInformation extends StatelessWidget {
  const BasicInformation({
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
          post.category.name,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.onSurface),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          post.title,
          style: theme.textTheme.headlineMedium
              ?.copyWith(color: theme.colorScheme.onSurface),
        ),
        const SizedBox(
          height: 8,
        ),
        Text.rich(
          TextSpan(
            text: 'Giá phòng: ',
            style: theme.textTheme.titleMedium,
            children: [
              TextSpan(
                text: '${post.price.inCompactLongCurrency} / tháng',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
