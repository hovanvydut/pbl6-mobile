import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/notification/notification.dart';

class NotificationListView extends StatefulWidget {
  const NotificationListView({
    super.key,
  });

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  late ScrollController _notificationController;

  @override
  void initState() {
    super.initState();
    _notificationController = ScrollController()
      ..addListener(() {
        if (_notificationController.offset >=
            _notificationController.position.maxScrollExtent) {
          if (!_notificationController.hasClients ||
              context.read<NotificationBloc>().state.isLoadingMore) {
            return;
          }
          EasyDebounce.debounce(
            'loadingmore all',
            const Duration(milliseconds: 300),
            () =>
                context.read<NotificationBloc>().add(LoadMoreAllNotification()),
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final loadingStatus =
            context.select((NotificationBloc bloc) => bloc.state.loadingStatus);
        final notifications =
            context.select((NotificationBloc bloc) => bloc.state.notifications);
        final isLoadingMore =
            context.select((NotificationBloc bloc) => bloc.state.isLoadingMore);
        if (loadingStatus == LoadingStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (loadingStatus == LoadingStatus.error) {
          return const Center(
            child: Text('Có lỗi xảy ra, vui lòng thử lại'),
          );
        }
        if (notifications.isEmpty) {
          return const Center(
            child: Text('Bạn không có thông báo nào'),
          );
        }
        return RefreshIndicator(
          onRefresh: () async =>
              context.read<NotificationBloc>().add(GetNotifications()),
          child: ListView.separated(
            controller: _notificationController,
            itemCount: notifications.length + 1,
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 16,
              top: 12,
            ),
            itemBuilder: (context, index) {
              if (index == notifications.length) {
                if (isLoadingMore) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              }
              final notification = notifications[index];
              return NotificationCard(
                key: ObjectKey(notification),
                notification: notification,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          ),
        );
      },
    );
  }
}
