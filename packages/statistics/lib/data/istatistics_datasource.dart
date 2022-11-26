import 'package:models/models.dart';

abstract class IStatisticsDatasource {
  Future<List<StatisticsValue>> getPostStatisticsValuesByKey(
    String key, {
    required DateTime fromDate,
    required DateTime toDate,
    bool includeDeleted = false,
  });

  Future<List<StatisticsData>> getDetailPostStatisticsDataByKey(
    String key, {
    required DateTime date,
    bool includeDeletedPost = false,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  });

  Future<List<StatisticsData>> getTopPostStatisticsDataByKey(
    String key, {
    int top = 5,
    required DateTime date,
    bool includeDeletedPost = false,
  });
}
