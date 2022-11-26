import 'dart:developer';
import 'dart:io';

import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:secure_storage_helper/secure_storage_helper.dart';
import 'package:statistics/statistics.dart';

class RemoteStatisticsDatasource implements IStatisticsDatasource {
  RemoteStatisticsDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<List<StatisticsData>> getDetailPostStatisticsDataByKey(
    String key, {
    required DateTime date,
    bool includeDeletedPost = false,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);

      final responseData = await _httpHandler.get(
        ApiPath.detailPostStatistics,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        queryParameter: Map.fromEntries(
          {
            'Key': key,
            'Date': date.toIso8601String(),
            'IncludeDeletedPost': '$includeDeletedPost',
            'PageNumber': '$pageNumber',
            'PageSize': '$pageSize',
            'SearchValue': searchValue
          }.entries.toList()
            ..removeWhere((entry) => entry.value == null),
        ),
      );
      final data = responseData.data as Map<String, dynamic>;
      final listRecords = data['records'] as List;
      return listRecords
          .map(
            (record) => StatisticsData.fromJson(record as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  @override
  Future<List<StatisticsValue>> getPostStatisticsValuesByKey(
    String key, {
    required DateTime fromDate,
    required DateTime toDate,
    bool includeDeleted = false,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);

      final responseData = await _httpHandler.get(
        ApiPath.postStatistics,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        queryParameter: {
          'Key': key,
          'FromDate': fromDate.toIso8601String(),
          'ToDate': toDate.toIso8601String(),
          'IncludeDeletedPost': '$includeDeleted',
        },
      );
      final listData = responseData.data as List;
      return listData
          .map<StatisticsValue>(
            (e) => StatisticsValue.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }

  @override
  Future<List<StatisticsData>> getTopPostStatisticsDataByKey(
    String key, {
    int top = 5,
    required DateTime date,
    bool includeDeletedPost = false,
  }) async {
    try {
      final jwt =
          await SecureStorageHelper.readValueByKey(SecureStorageKey.jwt);

      final responseData = await _httpHandler.get(
        ApiPath.topPostStatistics,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        queryParameter: {
          'Key': key,
          'Top': '$top',
          'Date': date.toIso8601String(),
          'IncludeDeletedPost': '$includeDeletedPost',
        },
      );
      final listData = responseData.data as List;
      return listData
          .map<StatisticsData>(
            (e) => StatisticsData.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      log(e.toString(), name: runtimeType.toString());
      rethrow;
    }
  }
}
