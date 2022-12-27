import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/l10n/l10n.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class DetailPostCreatedDateInfo extends StatelessWidget {
  const DetailPostCreatedDateInfo({
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
        Text(
          'Ngày đăng',
          style: theme.textTheme.titleLarge,
        ),
        ListTileTheme(
          data: const ListTileThemeData(
            minLeadingWidth: 24,
            contentPadding: EdgeInsets.zero,
          ),
          child: ListTile(
            leading: Assets.icons.calendar2.svg(
              height: 24,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            title: Text(post.createdAt!.yMd),
            subtitle: Timeago(
              locale: context.l10n.localeName,
              date: post.createdAt!,
              builder: (_, timeago) {
                return Text(timeago);
              },
            ),
          ),
        ),
      ],
    );
  }
}
