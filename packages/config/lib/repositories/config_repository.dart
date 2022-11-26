import 'package:config/config.dart';
import 'package:models/models.dart';

class ConfigRepository {
  ConfigRepository({required IConfigDatasource configDatasource})
      : _configDatasource = configDatasource;

  final IConfigDatasource _configDatasource;

  Future<ConfigData> getConfigDataByKey({required String configKey}) =>
      _configDatasource.getConfigDataByKey(configKey: configKey);
}
