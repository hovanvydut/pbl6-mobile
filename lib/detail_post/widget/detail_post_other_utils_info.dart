import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

class DetailPostOtherUtilsInfo extends StatelessWidget {
  const DetailPostOtherUtilsInfo({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.groupProperties!
            .firstWhere((group) => group.id == 2)
            .properties
            .isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Tiện ích',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: post.groupProperties!
                .elementAt(1)
                .properties
                .map<Chip>(
                  (property) => Chip(
                    label: Text(
                      property.displayName,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
        ] else
          const SizedBox(),
      ],
    );
  }
}
