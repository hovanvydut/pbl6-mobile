import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/post/post.dart';

class DetailPostAuthorInfo extends StatelessWidget {
  const DetailPostAuthorInfo({
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
          'Người đăng',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListTileTheme(
          data: const ListTileThemeData(
            minLeadingWidth: 24,
            contentPadding: EdgeInsets.zero,
          ),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: post.authorInfo?.avatar ??
                  'https://avatars.githubusercontent.com/u/63831488?v=4',
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 32,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => CircleAvatar(
                radius: 32,
                backgroundColor: theme.colorScheme.surface,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                ),
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 32,
                backgroundColor: theme.colorScheme.surface,
                child: Assets.icons.danger.svg(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            title: Text(post.authorInfo!.displayName),
            onTap: () => context.push(
              AppRouter.detailHost,
              extra: ExtraParams3<PostBloc, User, BookmarkBloc>(
                param1: context.read<PostBloc>(),
                param2: post.authorInfo!,
                param3: context.read<BookmarkBloc>(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
