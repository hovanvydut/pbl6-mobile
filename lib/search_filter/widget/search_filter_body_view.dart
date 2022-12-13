import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/search_filter/search_filter.dart';
import 'package:pbl6_mobile/user_post/user_post.dart';

class SearchFilterBodyView extends StatelessWidget {
  const SearchFilterBodyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
      builder: (context, state) {
        final loadingStatus = state.loadingStatus;
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
              mainAxisAlignment: MainAxisAlignment.center,
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
        if (state.posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Assets.images.empty.svg(
                  height: 200,
                  width: 300,
                ),
                const SizedBox(height: 16),
                Text(
                  'Không có bài viết nào',
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
        return const SearchFilterListView();
      },
    );
  }
}
