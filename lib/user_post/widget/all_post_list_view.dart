import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';

class AllPostListView extends StatelessWidget {
  const AllPostListView({
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
      child: BlocBuilder<UserPostBloc, UserPostState>(
        buildWhen: (previous, current) =>
            previous.userPostsLoadingStatus != current.userPostsLoadingStatus ||
            previous.userPostsData != current.userPostsData,
        builder: (context, state) {
          final loadingStatus = state.userPostsLoadingStatus;
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
          if (state.userPostsData.isEmpty) {
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
                    'Bạn không có bài viết nào',
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
            onRefresh: () async =>
                context.read<UserPostBloc>().add(GetUserPosts()),
            child: ListView.separated(
              itemCount: state.userPostsData.length,
              itemBuilder: (context, index) {
                final post = state.userPostsData[index];
                return PostListTileCard(
                  post: post,
                  hideBookmark: true,
                  onCardTap: () => context.push(
                    AppRouter.detailPost,
                    extra: ExtraParams3<UserPostBloc, Post, BookmarkBloc?>(
                      param1: context.read<UserPostBloc>(),
                      param2: post,
                      param3: null,
                    ),
                  ),
                  onCardLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return BlocProvider.value(
                          value: context.read<UserPostBloc>(),
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
