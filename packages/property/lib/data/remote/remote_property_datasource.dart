import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';
import 'package:property/data/iproperty_datasource.dart';

class RemotePropertyDatasource implements IPropertyDatasource {
  RemotePropertyDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<List<GroupProperty>> getGroupProperties() async {
    try {
      final rawData = await _httpHandler.get(
        ApiPath.property,
      ) as List;
      final groupProperties = rawData
          .map(
            (group) => GroupProperty.fromJson(group as Map<String, dynamic>),
          )
          .toList();
      return groupProperties;
    } on ServerErrorException {
      throw Exception();
    }
  }
}
