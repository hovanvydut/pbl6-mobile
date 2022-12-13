import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';
import 'package:pbl6_mobile/search_filter/search_filter.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';

class SearchFilterListView extends StatefulWidget {
  const SearchFilterListView({super.key});

  @override
  State<SearchFilterListView> createState() => _SearchFilterListViewState();
}

class _SearchFilterListViewState extends State<SearchFilterListView> {
  late ScrollController _searchFilterScrollController;

  @override
  void initState() {
    super.initState();
    _searchFilterScrollController = ScrollController()
      ..addListener(() {
        if (_searchFilterScrollController.position.pixels >=
            _searchFilterScrollController.position.maxScrollExtent) {
          if (!_searchFilterScrollController.hasClients ||
              context.read<SearchFilterBloc>().state.loadingMoreStatus ==
                  LoadingStatus.loading) {
            return;
          }
          EasyDebounce.debounce(
            'filter',
            const Duration(milliseconds: 300),
            () => context.read<SearchFilterBloc>().add(ScrollMoreReached()),
          );
        }
      });
  }

  @override
  void dispose() {
    _searchFilterScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final posts =
            context.select((SearchFilterBloc bloc) => bloc.state.posts);
        final loadingMoreStatus = context
            .select((SearchFilterBloc bloc) => bloc.state.loadingMoreStatus);
        return RefreshIndicator(
          onRefresh: () async =>
              context.read<SearchFilterBloc>().add(GetPosts()),
          child: ListView.separated(
            controller: _searchFilterScrollController,
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            itemCount: posts.length + 1,
            itemBuilder: (context, index) {
              if (index == posts.length) {
                if (loadingMoreStatus == LoadingStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              }
              final post = posts[index];
              return Builder(
                builder: (context) {
                  final bookmarks =
                      context.watch<BookmarkBloc>().state.bookmarks;
                  final isBookmarked = bookmarks.any(
                    (bookmark) => bookmark.id == post.id,
                  );
                  return PostListTileCard(
                    key: ValueKey(post.id),
                    post: post,
                    isBookmarked: isBookmarked,
                    onCardTap: () => context.push(
                      AppRouter.detailPost,
                      extra: ExtraParams3<UserPostBloc, Post, BookmarkBloc?>(
                        param1: context.read<UserPostBloc>(),
                        param2: post,
                        param3: context.read<BookmarkBloc>(),
                      ),
                    ),
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
    );
  }
}
