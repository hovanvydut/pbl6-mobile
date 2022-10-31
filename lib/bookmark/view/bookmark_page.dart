import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocListener<BookmarkBloc, BookmarkState>(
      listener: (context, state) {
        // if (state.deleteBookmarkStatus == LoadingStatus.done) {
        //   ScaffoldMessenger.of(context).removeCurrentSnackBar();
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text('Đã xóa bài viết khỏi danh sách đã lưu'),
        //       duration: Duration(seconds: 1),
        //     ),
        //   );
        // }
        // if (state.deleteBookmarkStatus == LoadingStatus.error) {
        //   ToastHelper.showToast('Thực hiện không thành công, xin thử lại');
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Assets.icons.arrorLeft.svg(
              color: theme.colorScheme.onSurface,
              height: 32,
            ),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Bài viết đã lưu',
          ),
          centerTitle: true,
          actions: const [BookmarkRefreshIcon()],
        ),
        body: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            final getBookmarksStatus = state.getBookmarksStatus;
            if (getBookmarksStatus == LoadingStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (getBookmarksStatus == LoadingStatus.error) {
              return const Center(
                child: Text('Lỗi vui lòng thử lại'),
              );
            }
            if (state.bookmarks.isEmpty) {
              return const Center(
                child: Text('Bạn không có bài viết nào đã lưu'),
              );
            }
            return ListView.separated(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 8),
              itemCount: state.bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = state.bookmarks[index];
                return BookmarklListTileCard(
                  bookmark: bookmark,
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
      ),
    );
  }
}

class BookmarkRefreshIcon extends StatelessWidget {
  const BookmarkRefreshIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      icon: Assets.icons.refresh.svg(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: () => context.read<BookmarkBloc>().add(GetBookmarks()),
    );
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        switch (state.getBookmarksStatus) {
          case LoadingStatus.initial:
          case LoadingStatus.loading:
          case LoadingStatus.error:
            return button;
          case LoadingStatus.done:
            if (state.bookmarks.isEmpty) {
              return button;
            }
            return const SizedBox();
        }
      },
    );
  }
}
