import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';
import 'package:user/user.dart';

class RemoteUserDatasource implements IUserDatasource {
  const RemoteUserDatasource({
    required HttpClientHandler httpHandler,
  }) : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<User> getUserByUserId(int userId) async {
    try {
      final httpResponse = await _httpHandler.get(
        '${ApiPath.userAnonymous}/$userId',
      );
      final userJsonData = httpResponse.data as Map<String, dynamic>;
      return User.fromJson(userJsonData);
    } on ServerErrorException {
      throw Exception();
    }
  }

  @override
  Future<User?> getUserInformation() async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      if (jwt == null) {
        return null;
      }
      final httpResponse = await _httpHandler.get(
        ApiPath.userPersonal,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
      final userJsonData = httpResponse.data as Map<String, dynamic>;
      return User.fromJson(userJsonData);
    } on UnauthorizedException {
      await SecureStorageHelper.deleteAllKeys();
      rethrow;
    } on ServerErrorException {
      rethrow;
    }
  }

  @override
  Future<void> updateUserInformation(User user) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.put(
        ApiPath.userPersonal,
        body: user.toJson(),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      );
    } on ServerErrorException {
      throw Exception('Update user information has a error:');
    } catch (e) {
      log(e.toString());
    }
  }
}
