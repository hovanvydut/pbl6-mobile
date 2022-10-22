import 'package:category/data/icategory_datasource.dart';
import 'package:constant_helper/constant_helper.dart';
import 'package:http_client_handler/http_client_handler.dart';
import 'package:models/models.dart';

class RemoteCategoryDatasource implements ICategoryDatasource {
  RemoteCategoryDatasource({required HttpClientHandler httpHandler})
      : _httpHandler = httpHandler;

  final HttpClientHandler _httpHandler;

  @override
  Future<List<HouseType>> getHouseType() async {
    try {
      final httpResponse = await _httpHandler.get(
        ApiPath.categoryHouseType,
      );
      final houseTypeData = httpResponse.data as List;
      return houseTypeData
          .map((e) => HouseType.fromJson(e as Map<String, dynamic>))
          .toList();
    } on ServerErrorException {
      throw Exception();
    }
  }
}
