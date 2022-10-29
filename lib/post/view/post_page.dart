import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/post/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(GetUserPosts());
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Assets.images.logo.svg(),
        ),
        actions: const [
          RefreshActionButton(),
        ],
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
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (loadingStatus == LoadingStatus.error) {
              return Center(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      context.read<PostBloc>().add(GetUserPosts()),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state.userPostsData.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    )
                  ],
                ),
              );
            }
            return Column(
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
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        context.read<PostBloc>().add(GetUserPosts()),
                    child: ListView.separated(
                      itemCount: state.userPostsData.length,
                      itemBuilder: (context, index) {
                        final post = state.userPostsData[index];
                        return PostListTileCard(post: post);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                    ),
                  ),
                ),
              ],
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
