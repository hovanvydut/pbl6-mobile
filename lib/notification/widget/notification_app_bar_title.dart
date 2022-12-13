import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/notification/notification.dart';
import 'package:widgets/widgets.dart';

class NotificationAppBarTitle extends StatelessWidget {
  const NotificationAppBarTitle({
    super.key,
    required FocusNode searchFocus,
  }) : _searchFocus = searchFocus;

  final FocusNode _searchFocus;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final searchMode =
            context.select((NotificationBloc bloc) => bloc.state.searchMode);

        if (searchMode) {
          return SearchField(
            focusNode: _searchFocus,
            hintText: 'Bạn muốn tìm kiếm thông báo gì',
            suffixIcon:
                Assets.icons.close.svg(color: context.colorScheme.onSurface),
            onChanged: (value) => EasyDebounce.debounce(
              'searchnotification',
              const Duration(milliseconds: 300),
              () => context
                  .read<NotificationBloc>()
                  .add(SearchValueChanged(value: value)),
            ),
            onSuffixIconPressed: (_) =>
                context.read<NotificationBloc>().add(GetNotifications()),
          );
        }
        return const Text('Thông báo');
      },
    );
  }
}
