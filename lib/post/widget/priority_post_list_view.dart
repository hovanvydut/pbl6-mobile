import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/post/post.dart';

class PriorityPostListView extends StatelessWidget {
  const PriorityPostListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 32,
      ),
      child: BlocBuilder<PostBloc, PostState>(
        buildWhen: (previous, current) =>
            previous.userPostsLoadingStatus != current.userPostsLoadingStatus ||
            previous.userPostsData != current.userPostsData,
        builder: (context, state) {
          final loadingStatus = state.userPostsLoadingStatus;
          final priorityPost = state.userPostsData
              .where(
                (post) => post.isPriorityPost! == true,
              )
              .toList();
          if (loadingStatus == LoadingStatus.loading) {
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const PostListTileCardPlaceholder();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
            );
          } else if (loadingStatus == LoadingStatus.error) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  Assets.images.errorNotFound.svg(
                    height: 200,
                    width: 300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Đã có lỗi xảy ra, vui lòng thử lại',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            );
          }
          if (priorityPost.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  Assets.images.empty.svg(
                    height: 200,
                    width: 300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Bạn không có bài viết ưu tiên nào',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => context.read<PostBloc>().add(GetUserPosts()),
            child: ListView.separated(
              itemCount: priorityPost.length,
              itemBuilder: (context, index) {
                final post = state.userPostsData[index];
                return PostListTileCard(
                  post: post,
                  hideBookmark: true,
                  onCardTap: () => context.push(
                    AppRouter.detailPost,
                    extra: ExtraParams3<PostBloc, Post, BookmarkBloc?>(
                      param1: context.read<PostBloc>(),
                      param2: post,
                      param3: null,
                    ),
                  ),
                  onCardLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<PostBloc>(),
                          child: PostActionBottomSheet(post: post),
                        );
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
            ),
          );
        },
      ),
    );
  }
}