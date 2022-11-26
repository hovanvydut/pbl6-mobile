import 'package:models/models.dart';
import 'package:uptop/uptop.dart';

class UptopRepository {
  UptopRepository({required IUptopDatasource uptopDatasource})
      : _uptopDatasource = uptopDatasource;

  final IUptopDatasource _uptopDatasource;

  Future<void> createUptopSession({
    required int postId,
    required int days,
    required DateTime startTime,
  }) =>
      _uptopDatasource.createUptopSession(
        days: days,
        postId: postId,
        startTime: startTime,
      );

  Future<UptopData> getUptopDataByPost(int postId) =>
      _uptopDatasource.getUptopDataByPost(postId);
}
