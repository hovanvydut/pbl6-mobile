import 'package:models/models.dart';
import 'package:post/post.dart';

class PostRepository {
  PostRepository({
    required IPostDatasource postDatasource,
  }) : _postDatasource = postDatasource;
  final IPostDatasource _postDatasource;

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
  }) =>
      _postDatasource.createPost(
        title: title,
        description: description,
        address: address,
        area: area,
        houseTypeId: houseTypeId,
        limitTenant: limitTenant,
        prePaidPrice: prePaidPrice,
        price: price,
        properties: properties,
        wardId: wardId,
        medias: medias,
      );
}
