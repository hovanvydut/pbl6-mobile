import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/authentication/authentication.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';

class DetailPostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailPostAppBar({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return AppBar(
      leading: IconButton(
        icon: Assets.icons.arrorLeft.svg(
          color: theme.colorScheme.onSurface,
          height: 32,
        ),
        onPressed: () => context.pop(),
      ),
      title: const Text('Chi tiết phòng'),
      actions: <Widget>[
        if (context.read<AuthenticationBloc>().state.user != null &&
            context.read<AuthenticationBloc>().state.user?.id ==
                post.authorInfo?.id) ...[
          IconButton(
            icon: Assets.icons.edit
                .svg(color: theme.colorScheme.onSurfaceVariant),
            onPressed: () {
              context.push(
                AppRouter.editPost,
                extra: ExtraParams2<UserPostBloc, Post>(
                  param1: context.read<UserPostBloc>(),
                  param2: post,
                ),
              );
            },
          ),
          IconButton(
            icon: Assets.icons.delete
                .svg(color: theme.colorScheme.onSurfaceVariant),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Xóa bài viết'),
                    content: const Text(
                      'Bạn có muốn xóa bài viết',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context
                              .read<UserPostBloc>()
                              .add(DeleteUserPost(post));
                          context.pop();
                        },
                        child: const Text('Đồng ý'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Hủy'),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ] else ...[
          PermissionWrapper(
            permission: Permission.bookmarkCreate,
            child: Builder(
              builder: (context) {
                final bookmarks = context.watch<BookmarkBloc>().state.bookmarks;
                final isBookmarked = bookmarks.any(
                  (bookmark) => bookmark.id == post.id,
                );
                return BookmarkIconButton(
                  isBookmarked: isBookmarked,
                  onBookmarkedPressed: () =>
                      context.read<BookmarkBloc>().add(DeleteBookmark(post)),
                  onUnBookmarkedPressed: () =>
                      context.read<BookmarkBloc>().add(AddBookmark(post)),
                  backgroundTransprent: true,
                );
              },
            ),
          ),
          IconButton(
            icon: Assets.icons.share
                .svg(color: theme.colorScheme.onSurfaceVariant),
            onPressed: () {},
          ),
        ]
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
