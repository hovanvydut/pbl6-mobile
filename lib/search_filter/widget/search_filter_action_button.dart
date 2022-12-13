import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/search_filter/search_filter.dart';

class SearchFilterActionButton extends StatelessWidget {
  const SearchFilterActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final filterButton = IconButton(
      icon: Assets.icons.filterBold.svg(
        height: 28,
        color: theme.colorScheme.onSurface,
      ),
      onPressed: () {
        showModalBottomSheet(
          elevation: 1,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          isScrollControlled: true,
          builder: (_) {
            return BlocProvider.value(
              value: context.read<SearchFilterBloc>(),
              child: const FilterBottomSheet(),
            );
          },
        );
      },
    );
    final refreshButton = IconButton(
      icon: Assets.icons.refresh.svg(color: theme.colorScheme.onSurface),
      onPressed: () => context.read<SearchFilterBloc>().add(GetPosts()),
    );
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
      builder: (context, state) {
        final loadingStatus = state.loadingStatus;
        switch (loadingStatus) {
          case LoadingStatus.initial:
          case LoadingStatus.loading:
          case LoadingStatus.error:
            return refreshButton;
          case LoadingStatus.done:
            if (state.posts.isEmpty) {
              return refreshButton;
            }
            return filterButton;
        }
      },
    );
  }
}
