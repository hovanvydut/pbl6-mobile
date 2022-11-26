import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/post/post.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

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
        title: const Text(
          'Bài đăng của bạn',
        ),
        actions: const [
          RefreshActionButton(),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 32,
        ),
        child: BlocBuilder<PostBloc, PostState>(
          buildWhen: (previous, current) =>
              previous.userPostsLoadingStatus !=
                  current.userPostsLoadingStatus ||
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
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
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
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
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
                  context.read<PostBloc>().add(GetUserPosts()),
              child: ListView.separated(
                itemCount: state.userPostsData.length,
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
      ),
    );
  }
}

class RefreshActionButton extends StatelessWidget {
  const RefreshActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(
      builder: (context) {
        final userPostsStatus = context
            .select((PostBloc bloc) => bloc.state.userPostsLoadingStatus);
        final userPostsData =
            context.select((PostBloc bloc) => bloc.state.userPostsData);
        switch (userPostsStatus) {
          case LoadingStatus.initial:
          case LoadingStatus.error:
            return IconButton(
              icon: Assets.icons.refresh
                  .svg(color: theme.colorScheme.onSurfaceVariant),
              onPressed: () => context.read<PostBloc>().add(GetUserPosts()),
            );
          case LoadingStatus.loading:
            return const SizedBox();
          case LoadingStatus.done:
            if (userPostsData.isEmpty) {
              return IconButton(
                icon: Assets.icons.refresh
                    .svg(color: theme.colorScheme.onSurfaceVariant),
                onPressed: () => context.read<PostBloc>().add(GetUserPosts()),
              );
            }
            return const SizedBox();
        }
      },
    );
  }
}
