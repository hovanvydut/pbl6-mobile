import 'dart:io';

import 'package:auth/data/iauth_datasource.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';

class RemoteAuthDatasource implements IAuthDatasource {
  const RemoteAuthDatasource({
    required HttpClientHandler httpHandler,
  }) : _httpHandler = httpHandler;
  final HttpClientHandler _httpHandler;

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final httpResponse = await _httpHandler.post(
        ApiPath.authLogin,
        body: {
          'email': email,
          'password': password,
        },
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );
      final loginData = httpResponse.data as Map<String, dynamic>;
      final jwt = loginData['accessToken'] as String;
      final userId = loginData['id'] as int;
      await SecureStorageHelper.writeValueToKey(
        key: SecureStorageKey.jwt,
        value: jwt,
      );
      await SecureStorageHelper.writeValueToKey(
        key: SecureStorageKey.userId,
        value: '$userId',
      );
    } on ServerErrorException {
      throw Exception();
    }
  }

  @override
  Future<void> removeToken() async {
    await SecureStorageHelper.deleteAllKeys();
  }
}
