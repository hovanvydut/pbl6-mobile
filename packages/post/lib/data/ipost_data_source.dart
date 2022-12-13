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

  Future<List<Post>> getAllPosts({
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<void> updatePostByPostId(
    int postId, {
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

  Future<void> deletePost(int postId);

  Future<List<Post>> getUserPosts({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  });

  Future<List<Post>> filterPosts({
    List<int>? properties,
    double? minPrice,
    double? maxPrice,
    double? minArea,
    double? maxArea,
    int? addressWardId,
    int? categoryId,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  });

  Future<Post> getDetailPostById(int postId);

  Future<List<Post>> getPostsByHostId(int hostId);

  Future<List<Post>> getRelatedPost({
    required int quantity,
    required int postId,
    required int addressWardId,
  });
}
