import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/notification/notification.dart';
import 'package:platform_helper/platform_helper.dart';

class ReadAllNotificationButton extends StatelessWidget {
  const ReadAllNotificationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final notifications =
            context.select((NotificationBloc bloc) => bloc.state.notifications);
        final isAllRead =
            notifications.every((notification) => notification.hasRead);
        return IconButton(
          icon:
              Assets.icons.checkCheck.svg(color: context.colorScheme.onSurface),
          onPressed: isAllRead
              ? () => ToastHelper.showToast('Tất cả thông báo đã được đọc')
              : () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<NotificationBloc>(),
                        child: AlertDialog(
                          title: const Text('Đọc toàn bộ thông báo'),
                          content: const Text(
                            'Bạn xác nhận đọc hết toàn bộ thông bác?',
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Xác nhận'),
                              onPressed: () {
                                context
                                    .read<NotificationBloc>()
                                    .add(ReadAllNotifications());
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text('Hủy'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
        );
      },
    );
  }
}
