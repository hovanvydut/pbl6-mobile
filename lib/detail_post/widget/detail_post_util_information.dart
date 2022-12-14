import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

class DetailPostUtilInformation extends StatelessWidget {
  const DetailPostUtilInformation({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Assets.icons.lightBulb.svg(
                height: 28,
                color: theme.colorScheme.outline,
              ),
              Text(
                8000.inCompactCurrencyNotSymbol,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Assets.icons.waterDrop.svg(
                height: 28,
                color: theme.colorScheme.outline,
              ),
              Text(
                40000.inCompactCurrencyNotSymbol,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Assets.icons.wifi.svg(
                height: 28,
                color: theme.colorScheme.outline,
              ),
              Text(
                'Miễn phí',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
