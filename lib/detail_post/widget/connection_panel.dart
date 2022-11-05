import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:widgets/widgets.dart';

class ConnectionPanel extends StatelessWidget {
  const ConnectionPanel({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          height: context.height * 0.12,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButtonWithIcon(
                onPressed: () {},
                icon: Assets.icons.messageOutline.svg(
                  color: theme.colorScheme.onPrimary,
                ),
                label: const Text('Chat ngay'),
              ),
              OutlinedButton(
                onPressed: () => context.pushToChild(
                  AppRouter.booking,
                  extra: ExtraParams3<PostBloc, Post, BookmarkBloc>(
                    param1: context.read<PostBloc>(),
                    param2: post,
                    param3: context.read<BookmarkBloc>(),
                  ),
                ),
                child: const Text('Đặt lịch xem trọ'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Assets.icons.callOutline.svg(height: 20),
                label: const Text('Gọi'),
              )
            ],
          ),
        );
      },
    );
  }
}
