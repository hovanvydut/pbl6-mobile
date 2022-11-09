import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';

class DetailPostAddressInformation extends StatelessWidget {
  const DetailPostAddressInformation({
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
          'Địa chỉ và liên hệ',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        ListTileTheme(
          data: const ListTileThemeData(
            minLeadingWidth: 24,
            contentPadding: EdgeInsets.zero,
          ),
          child: ListTile(
            leading: Assets.icons.position.svg(
              height: 24,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            title: Text(
              '${post.address}, ${post.fullAddress}',
            ),
            trailing: Assets.icons.chevronRight.svg(
              height: 24,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        ListTileTheme(
          data: const ListTileThemeData(
            minLeadingWidth: 24,
            contentPadding: EdgeInsets.zero,
          ),
          child: ListTile(
            leading: Assets.icons.callOutline.svg(
              height: 24,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            title: const Text('Số điện thoại'),
            subtitle:
                Text(post.authorInfo!.phoneNumber ?? 'Không có thông tin'),
          ),
        ),
      ],
    );
  }
}
