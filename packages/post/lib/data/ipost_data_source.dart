import 'package:models/models.dart';

abstract class IPostDatasource {
  Future<void> createPost({
    required String title,
    required String description,
    required double area,
    required String address,
    required int wardId,
    required double price,
    required double prePaidPrice,
    required int houseTypeId,
    required int limitTenant,
    List<Media>? medias,
    required List<int> properties,
  });
}
