import 'package:models/models.dart';
import 'package:statistics/statistics.dart';

class StatisticsRepository {
  StatisticsRepository({required IStatisticsDatasource statisticsDatasource})
      : _statisticsDatasource = statisticsDatasource;

  final IStatisticsDatasource _statisticsDatasource;

  Future<List<StatisticsValue>> getPostStatisticsValuesByKey(
    String key, {
    required DateTime fromDate,
    required DateTime toDate,
    bool includeDeleted = false,
  }) =>
      _statisticsDatasource.getPostStatisticsValuesByKey(
        key,
        fromDate: fromDate,
        toDate: toDate,
        includeDeleted: includeDeleted,
      );

  Future<List<StatisticsData>> getDetailPostStatisticsDataByKey(
    String key, {
    required DateTime date,
    bool includeDeletedPost = false,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) =>
      _statisticsDatasource.getDetailPostStatisticsDataByKey(
        key,
        date: date,
        includeDeletedPost: includeDeletedPost,
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchValue: searchValue,
      );

  Future<List<StatisticsData>> getTopPostStatisticsDataByKey(
    String key, {
    int top = 5,
    required DateTime date,
    bool includeDeletedPost = false,
  }) =>
      _statisticsDatasource.getTopPostStatisticsDataByKey(
        key,
        date: date,
        includeDeletedPost: includeDeletedPost,
        top: top,
      );
}
