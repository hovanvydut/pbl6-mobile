import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';
import 'package:user/data/iuser_datasource.dart';

class RemoteUserDatasource implements IUserDatasource {
  const RemoteUserDatasource({
    required HttpClientHandler httpHandler,
  }) : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<User> getUserByUserId(int userId) async {
    try {
      final jsonData = await _httpHandler.get(
        ApiPath.userAnonymous,
        queryParameter: {'userId': '$userId'},
      ) as Map<String, dynamic>;
      final userJsonData = jsonData['data'] as Map<String, dynamic>;
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
      final jsonData = await _httpHandler.get(
        ApiPath.userPersonal,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      ) as Map<String, dynamic>;
      final userJsonData = jsonData['data'] as Map<String, dynamic>;
      return User.fromJson(userJsonData);
    } on ServerErrorException {
      throw Exception();
    } on UnauthorizedException {
      throw Exception();
    }
  }

  @override
  Future<void> updateUserInformation(User user) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      await _httpHandler.post(
        ApiPath.userAnonymous,
        body: user.toJson(),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
          HttpHeaders.contentTypeHeader: ContentType.json.value,
        },
      ) as Map<String, dynamic>;
    } on ServerErrorException catch (e) {
      throw Exception('Update user information has a error: $e');
    }
  }
}
