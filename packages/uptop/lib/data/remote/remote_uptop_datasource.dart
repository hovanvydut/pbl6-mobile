import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';
import 'package:uptop/uptop.dart';

class RemoteUptopDatasource implements IUptopDatasource {
  RemoteUptopDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

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
}
