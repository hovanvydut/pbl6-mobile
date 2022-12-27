import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:permissions/data/ipermissions_datasource.dart';
import 'package:permissions/data/remote/mapper.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';

class RemotePermissionsDatasource implements IPermissionsDatasource {
  RemotePermissionsDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<List<Permission>> getUserPermissions() async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);
      final response = await _httpHandler.get(
        ApiPath.personalPermission,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
      );
      final permissionsData = response.data as List;
      return permissionsData
          .map(
            (data) => permissionsEnumMap.keys
                .firstWhere((key) => permissionsEnumMap[key] == data),
          )
          .toList();
    } catch (e) {
      log(e.toString(), name: '$RemotePermissionsDatasource');
      rethrow;
    }
  }
}
