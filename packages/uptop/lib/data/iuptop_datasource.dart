import 'package:models/models.dart';

abstract class IUptopDatasource {
  Future<void> createUptopSession({
    required int postId,
    required int days,
    required DateTime startTime,
  });

  Future<UptopData> getUptopDataByPost(int postId);
}
