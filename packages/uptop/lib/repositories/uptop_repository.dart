import 'package:uptop/uptop.dart';

class UptopRepository {
  UptopRepository({required IUptopDatasource uptopDatasource})
      : _uptopDatasource = uptopDatasource;

  final IUptopDatasource _uptopDatasource;
}
