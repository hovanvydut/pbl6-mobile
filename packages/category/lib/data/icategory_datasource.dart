import 'package:models/models.dart';

abstract class ICategoryDatasource {
  Future<List<HouseType>> getHouseType();
}
