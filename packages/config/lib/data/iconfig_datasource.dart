import 'package:models/models.dart';

abstract class IConfigDatasource {
  Future<ConfigData> getConfigDataByKey({required String configKey});
}
