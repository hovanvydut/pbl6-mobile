import 'package:category/category.dart';
import 'package:models/models.dart';

class CategoryRepository {
  CategoryRepository({
    required ICategoryDatasource categoryDatasource,
  }) : _categoryDatasource = categoryDatasource;

  final ICategoryDatasource _categoryDatasource;

  Future<List<HouseType>> getHouseTypes() => _categoryDatasource.getHouseType();
}
