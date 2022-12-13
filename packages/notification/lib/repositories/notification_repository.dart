import 'package:models/models.dart';
import 'package:notification/notification.dart';

class NotificationRepository {
  NotificationRepository({
    required INotificationDatasource notificationDatasource,
  }) : _notificationDatasource = notificationDatasource;

  final INotificationDatasource _notificationDatasource;

  Future<List<NotificationData>> getNotifications({
    required bool today,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) =>
      _notificationDatasource.getNotifications(
        today: today,
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchValue: searchValue,
      );

  Future<void> readAllNotifications() =>
      _notificationDatasource.readAllNotifications();

  Future<UnreadData> getUnreadData() => _notificationDatasource.getUnreadData();

  Future<void> readNotification(int notificationId) =>
      _notificationDatasource.readNotification(notificationId);
}
