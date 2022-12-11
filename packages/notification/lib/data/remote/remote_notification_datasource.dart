import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:notification/data/inotification_datasource.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';

class RemoteNotificationDatasource extends INotificationDatasource {
  RemoteNotificationDatasource({
    required HttpClientHandler httpHandler,
  }) : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<List<NotificationData>> getNotifications({
    required bool today,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final response = await _httpHandler.get(
        ApiPath.notifications,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        queryParameter: Map.fromEntries(
          {
            'Today': '$today',
            'PageNumber': '$pageNumber',
            'PageSize': '$pageSize',
            'SearchValue': searchValue,
          }.entries.toList()
            ..removeWhere((entry) => entry.value == null),
        ),
      );
      final records =
          (response.data as Map<String, dynamic>)['records'] as List;
      return records
          .map(
            (record) =>
                NotificationData.fromJson(record as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  @override
  Future<UnreadData> getUnreadData() async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final response = await _httpHandler.get(
        ApiPath.countUnreadNotification,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
      final data = response.data as Map<String, dynamic>;
      return UnreadData.fromJson(data);
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  @override
  Future<void> readAllNotifications() async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.put(
        ApiPath.readAllNotification,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  @override
  Future<void> readNotification(int notificationId) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.put(
        ApiPath.readNotification(notificationId),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }
}
