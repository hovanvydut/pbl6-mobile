import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/home/home.dart';
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
                ToastHelper.showToast('Đã xóa bài đăng đã lưu');
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
                ToastHelper.showToast('Đã thêm bài đăng vào danh sách đã lưu');
              }

              if (state.addBookmarkStatus == LoadingStatus.error) {
                ToastHelper.showToast(
                  'Thực hiện không thành công, xin thử lại',
                );
              }
            },
          ),
        ],
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final allPosts = state.allPosts;
            final allPostsStatus = state.homeLoadingStatus;
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
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurface,
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
