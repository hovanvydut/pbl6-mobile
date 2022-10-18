import 'package:category/category.dart';
import 'package:models/models.dart';

class CategoryRepository {
  CategoryRepository({
    required CategoryDatasource categoryDatasource,
  }) : _categoryDatasource = categoryDatasource;

  final CategoryDatasource _categoryDatasource;

  Future<List<HouseType>> getHouseType() => _categoryDatasource.getHouseType();
}
