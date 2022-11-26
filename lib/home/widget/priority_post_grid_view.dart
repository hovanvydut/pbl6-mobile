import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/home/home.dart';
import 'package:pbl6_mobile/post/post.dart';
import 'package:platform_helper/platform_helper.dart';

class PriorityPostGridView extends StatelessWidget {
  const PriorityPostGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MultiBlocListener(
        listeners: [
          BlocListener<BookmarkBloc, BookmarkState>(
            listenWhen: (previous, current) =>
                previous.deleteBookmarkStatus != current.deleteBookmarkStatus,
            listener: (context, state) {
              if (state.deleteBookmarkStatus == LoadingStatus.done) {
                ToastHelper.showToast('Đã xóa bài viết đã lưu');
              }
              if (state.deleteBookmarkStatus == LoadingStatus.error) {
                ToastHelper.showToast(
                  'Thực hiện không thành công, xin thử lại',
                );
              }
            },
          ),
          BlocListener<BookmarkBloc, BookmarkState>(
            listenWhen: (previous, current) =>
                previous.addBookmarkStatus != current.addBookmarkStatus,
            listener: (context, state) {
              if (state.addBookmarkStatus == LoadingStatus.done) {
                ToastHelper.showToast('Đã thêm bài viết vào danh sách đã lưu');
              }

              if (state.addBookmarkStatus == LoadingStatus.error) {
                ToastHelper.showToast(
                  'Thực hiện không thành công, xin thử lại',
                );
              }
            },
          ),
        ],
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            final allPosts = state.allPostsData;
            final allPostsStatus = state.allPostsLoadingStatus;
            if (allPostsStatus == LoadingStatus.loading) {
              return GridView.builder(
                padding: const EdgeInsets.only(bottom: 16, top: 8),
                shrinkWrap: true,
                primary: false,
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 260,
                ),
                itemBuilder: (context, index) {
                  return const PostGridCardPlaceholder();
                },
              );
            }
            if (allPostsStatus == LoadingStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Assets.images.errorNotFound.svg(
                      height: 200,
                      width: 300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Không thể cập nhật dữ liệu, xin thử lại',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    )
                  ],
                ),
              );
            }
            if (allPosts.isEmpty) {
              return const SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                GridView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: allPosts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 260,
                  ),
                  itemBuilder: (context, index) {
                    final post = allPosts[index];
                    return Builder(
                      builder: (context) {
                        final bookmarks =
                            context.watch<BookmarkBloc>().state.bookmarks;
                        final isBookmarked = bookmarks.any(
                          (bookmark) => bookmark.id == post.id,
                        );
                        return PostGridCard(
                          post: post,
                          isBookmarked: isBookmarked,
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
