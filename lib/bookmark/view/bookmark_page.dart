import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:widgets/widgets.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
    context.read<BookmarkBloc>().add(GetBookmarks());
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return DismissFocus(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            icon: Assets.icons.arrorLeft.svg(
              color: theme.colorScheme.onSurface,
              height: 32,
            ),
            onPressed: () => context.pop(),
          ),
          title: const BookmarkSearchPanel(),
          centerTitle: true,
          actions: const [BookmarkActionIcon()],
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
            if (state.searchedBookmarks.isEmpty) {
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
                      'Không tìm thấy bài viết nào',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    )
                  ],
                ),
              );
            }
            return const BookmarkList();
          },
        ),
      ),
    );
  }
}

class BookmarkList extends StatefulWidget {
  const BookmarkList({
    super.key,
  });

  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  late ScrollController _bookmarkListScrollController;

  @override
  void initState() {
    super.initState();
    _bookmarkListScrollController = ScrollController()
      ..addListener(() {
        if (_bookmarkListScrollController.position.pixels >=
            _bookmarkListScrollController.position.maxScrollExtent * 0.9) {
          EasyDebounce.debounce(
            'scroll bookmark',
            const Duration(milliseconds: 300),
            () => context.read<BookmarkBloc>().add(ScrollMoreBookmarks()),
          );
        }
      });
  }

  @override
  void dispose() {
    _bookmarkListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final searchedBookmarks =
            context.select((BookmarkBloc bloc) => bloc.state.searchedBookmarks);
        final getMoreBookmarksStatus = context
            .select((BookmarkBloc bloc) => bloc.state.getBookmarkMoreStatus);

        return RefreshIndicator(
          onRefresh: () async =>
              context.read<BookmarkBloc>().add(GetBookmarks()),
          child: ListView.separated(
            controller: _bookmarkListScrollController,
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 16,
              top: 8,
            ),
            itemCount: searchedBookmarks.length + 1,
            itemBuilder: (context, index) {
              if (index == searchedBookmarks.length) {
                if (getMoreBookmarksStatus == LoadingStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              }
              final bookmark = searchedBookmarks[index];
              return BookmarklListTileCard(
                bookmark: bookmark,
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
    );
  }
}

class BookmarkActionIcon extends StatelessWidget {
  const BookmarkActionIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final refreshButton = IconButton(
      icon: Assets.icons.refresh.svg(
        color: context.colorScheme.onSurface,
      ),
      onPressed: () => context.read<BookmarkBloc>().add(GetBookmarks()),
    );
    final searchButton = IconButton(
      icon: Assets.icons.searchOutline.svg(
        color: context.colorScheme.onSurface,
      ),
      onPressed: () => context.read<BookmarkBloc>().add(SearchButtonPressed()),
    );
    final closeButton = IconButton(
      icon: Assets.icons.close.svg(
        color: context.colorScheme.onSurface,
      ),
      onPressed: () => context.read<BookmarkBloc>().add(SearchButtonPressed()),
    );
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        switch (state.getBookmarksStatus) {
          case LoadingStatus.initial:
          case LoadingStatus.loading:
          case LoadingStatus.error:
            return refreshButton;
          case LoadingStatus.done:
            if (state.bookmarks.isEmpty) {
              return refreshButton;
            }
            if (state.isSearching) {
              return closeButton;
            }
            return searchButton;
        }
      },
    );
  }
}
