import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        actions: [  
          IconButton(
            icon: Assets.icons.refresh
                .svg(color: theme.colorScheme.onSurfaceVariant),
            onPressed: () => context.read<PostBloc>().add(GetUserPosts()),
          ),
        ],
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
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemCount: state.userPostsData.length,
                          itemBuilder: (context, index) {
                            final post = state.userPostsData[index];
                            return PostCard(post: post);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                        );
                },
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
