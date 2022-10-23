import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/post/post.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Assets.images.logo.svg(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tất cả bài viết của bạn',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                buildWhen: (previous, current) =>
                    previous.userPostsLoadingStatus !=
                        current.userPostsLoadingStatus ||
                    previous.userPostsData != current.userPostsData,
                builder: (context, state) {
                  final loadingStatus = state.userPostsLoadingStatus;
                  return loadingStatus == LoadingStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          itemCount: state.userPostsData.length,
                          itemBuilder: (context, index) {
                            final post = state.userPostsData[index];
                            return SizedBox(
                              height: 130,
                              child: GestureDetector(
                                onTap: () => context.push(
                                  AppRouter.detailPost,
                                  extra: ExtraParams2<PostBloc, Post>(
                                    param1: context.read<PostBloc>(),
                                    param2: post,
                                  ),
                                ),
                                child: Card(
                                  color: theme.colorScheme.surface,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 4, 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              post.medias.first.url,
                                              fit: BoxFit.cover,
                                              height: 120,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  post.title,
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    color: theme.colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  '${post.price} VND/tháng',
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    color: theme
                                                        .colorScheme.primary,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  '${post.address}, ${post.fullAddress}',
                                                  style: theme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                    color: theme.colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon:
                                              Assets.icons.bookmarkOutline.svg(
                                            color: theme.colorScheme.onSurface,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
