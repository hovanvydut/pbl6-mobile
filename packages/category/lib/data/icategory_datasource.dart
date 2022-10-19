// ignore_for_file: one_member_abstracts

import 'package:models/models.dart';

abstract class ICategoryDatasource {
  Future<List<HouseType>> getHouseType();
}
