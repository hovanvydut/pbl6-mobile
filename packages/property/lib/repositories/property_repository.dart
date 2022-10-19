import 'package:constant_helper/constant_helper.dart';
import 'package:models/models.dart';
import 'package:property/data/iproperty_datasource.dart';

class PropertyRepository {
  PropertyRepository({
    required IPropertyDatasource propertyDatasource,
  }) : _propertyDatasource = propertyDatasource;

  final IPropertyDatasource _propertyDatasource;

  Future<Map<String, GroupProperty>> getGroupProperties() async {
    try {
      final groupProperties = await _propertyDatasource.getGroupProperties();
      return {
        PropertyType.nearby: groupProperties[0],
        PropertyType.util: groupProperties[1],
        PropertyType.rental: groupProperties[2],
      };
    } catch (e) {
      return {};
    }
  }
}
