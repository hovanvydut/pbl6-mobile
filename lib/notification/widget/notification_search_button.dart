import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/notification/notification.dart';

class NotificationSearchButton extends StatelessWidget {
  const NotificationSearchButton({
    super.key,
    required this.searchFocus,
  });

  final FocusNode searchFocus;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final searchMode =
            context.select((NotificationBloc bloc) => bloc.state.searchMode);
        return IconButton(
          icon: Assets.icons.searchOutline.svg(
            color: context.colorScheme.onSurface,
          ),
          selectedIcon: Assets.icons.searchBold.svg(
            color: context.colorScheme.onSurface,
          ),
          isSelected: searchMode,
          onPressed: () {
            context.read<NotificationBloc>().add(SearchModeToggled());
            searchMode ? searchFocus.unfocus() : searchFocus.requestFocus();
          },
        );
      },
    );
  }
}
