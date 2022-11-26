import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/bookmark/bookmark.dart';

class BookmarkSearchPanel extends StatelessWidget {
  const BookmarkSearchPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      buildWhen: (previous, current) =>
          previous.isSearching != current.isSearching,
      builder: (context, state) {
        if (!state.isSearching) {
          return const Text(
            'Bài viết đã lưu',
          );
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
          ),
          alignment: Alignment.center,
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Tìm kiếm theo tiêu đề',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            onChanged: (value) => EasyDebounce.debounce(
              'search bookmark',
              const Duration(milliseconds: 300),
              () => context.read<BookmarkBloc>().add(SearchBookmark(value)),
            ),
          ),
        );
      },
    );
  }
}
