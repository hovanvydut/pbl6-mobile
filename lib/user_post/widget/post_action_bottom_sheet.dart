import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/uptop/uptop.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';

class PostActionBottomSheet extends StatelessWidget {
  const PostActionBottomSheet({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DecoratedBox(
      decoration: BoxDecoration(color: theme.colorScheme.surface),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!post.isPriorityPost!)
              ListTile(
                leading: Assets.icons.upSquare.svg(
                  color: theme.colorScheme.onSurface,
                ),
                title: Text(
                  'Đẩy bài viết lên tin nổi bật',
                  style: theme.textTheme.titleMedium,
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<UserPostBloc>(),
                        child: CreateUptopDialog(post: post),
                      );
                    },
                  );
                },
              )
            else
              ListTile(
                leading: Assets.icons.clock.svg(
                  color: theme.colorScheme.onSurface,
                ),
                title: Text(
                  'Xem thời hạn tin nổi bật',
                  style: theme.textTheme.titleMedium,
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) {
                      return DetailUptopDialog(post: post);
                    },
                  );
                },
              ),
            ListTile(
              leading: Assets.icons.edit.svg(
                color: theme.colorScheme.onSurface,
              ),
              title: Text(
                'Chỉnh sửa bài viết',
                style: theme.textTheme.titleMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                context.push(
                  AppRouter.editPost,
                  extra: ExtraParams2<UserPostBloc, Post>(
                    param1: context.read<UserPostBloc>(),
                    param2: post,
                  ),
                );
              },
            ),
            ListTile(
              leading: Assets.icons.delete.svg(
                color: theme.colorScheme.onSurface,
              ),
              title: Text(
                'Xóa bài viết',
                style: theme.textTheme.titleMedium,
              ),
              onTap: () {
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
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Đồng ý'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}
