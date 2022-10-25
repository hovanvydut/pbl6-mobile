import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/post/post.dart';

class DetailPostPage extends StatelessWidget {
  const DetailPostPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.icons.arrorLeft.svg(
            color: theme.colorScheme.onSurface,
            height: 32,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text('Chi tiết phòng'),
        actions: <Widget>[
          IconButton(
            icon: Assets.icons.edit
                .svg(color: theme.colorScheme.onSurfaceVariant),
            onPressed: () {
              context.push(
                AppRouter.editPost,
                extra: ExtraParams2<PostBloc, Post>(
                  param1: context.read<PostBloc>(),
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
                          context.read<PostBloc>().add(DeleteUserPost(post));
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (post.medias.isNotEmpty)
              CachedNetworkImage(
                cacheManager: AppCacheManager.appConfig,
                imageUrl: post.medias.first.url,
                imageBuilder: (context, imageProvider) => Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Assets.images.notImage.image(
                  fit: BoxFit.cover,
                  height: 250,
                ),
              )
            else
              Assets.images.notImage.image(
                fit: BoxFit.cover,
                height: 250,
              ),
            const SizedBox(
              height: 16,
            ),
            Text(
              post.title,
              style: theme.textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
