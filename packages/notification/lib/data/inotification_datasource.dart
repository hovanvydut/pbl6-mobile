import 'package:models/models.dart';

abstract class INotificationDatasource {
  Future<List<NotificationData>> getNotifications({
    required bool today,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  });

  Future<void> readAllNotifications();

  Future<UnreadData> getUnreadData();

  Future<void> readNotification(int notificationId);
}
