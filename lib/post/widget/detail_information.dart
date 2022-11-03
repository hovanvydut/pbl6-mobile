import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

class DetailInformation extends StatelessWidget {
  const DetailInformation({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              'Tối đa',
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${post.limitTenant} người',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Diện tích',
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${post.area.toStringAsFixed(0)}m²',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Đặt cọc',
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              post.prePaidPrice?.inCompactCurrencyNotSymbol ?? '',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        )
      ],
    );
  }
}
