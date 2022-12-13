import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';

class UserPostPage extends StatelessWidget {
  const UserPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Assets.icons.arrorLeft.svg(
              color: context.colorScheme.onSurface,
              height: 32,
            ),
            onPressed: () => context.pop(),
          ),
          title: const Text('Bài đăng của bạn'),
          actions: const [
            RefreshActionButton(),
          ],
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: context.colorScheme.primary,
            labelColor: context.colorScheme.onSurface,
            unselectedLabelColor: context.colorScheme.onSurfaceVariant,
            unselectedLabelStyle: context.textTheme.titleSmall,
            tabs: const [
              Tab(
                icon: Text(
                  'Tất cả bài viết',
                ),
              ),
              Tab(
                icon: Text(
                  'Bài viết ưu tiên',
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllPostListView(),
            PriorityPostListView(),
          ],
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
        final userPostsStatus = context.select(
          (UserPostBloc bloc) => bloc.state.userPostsLoadingStatus,
        );
        final userPostsData =
            context.select((UserPostBloc bloc) => bloc.state.userPostsData);
        switch (userPostsStatus) {
          case LoadingStatus.initial:
          case LoadingStatus.error:
            return IconButton(
              icon: Assets.icons.refresh
                  .svg(color: theme.colorScheme.onSurfaceVariant),
              onPressed: () => context.read<UserPostBloc>().add(GetUserPosts()),
            );
          case LoadingStatus.loading:
            return const SizedBox();
          case LoadingStatus.done:
            if (userPostsData.isEmpty) {
              return IconButton(
                icon: Assets.icons.refresh
                    .svg(color: theme.colorScheme.onSurfaceVariant),
                onPressed: () =>
                    context.read<UserPostBloc>().add(GetUserPosts()),
              );
            }
            return const SizedBox();
        }
      },
    );
  }
}
