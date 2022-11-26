import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';
import 'package:uptop/uptop.dart';

class RemoteUptopDatasource implements IUptopDatasource {
  RemoteUptopDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<void> createUptopSession({
    required int postId,
    required int days,
    required DateTime startTime,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.post(
        ApiPath.uptop(),
        body: {
          'postId': postId,
          'days': days,
          'startTime': startTime.toUtc().toIso8601String(),
        },
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  @override
  Future<UptopData> getUptopDataByPost(int postId) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final responseData = await _httpHandler.get(
        ApiPath.uptop(postId),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
      return UptopData.fromJson(responseData.data as Map<String, dynamic>);
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }
}
