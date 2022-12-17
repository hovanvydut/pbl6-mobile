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

  Future<List<Post>> getAllPosts({
    int pageNumber = 1,
    int pageSize = 10,
  }) =>
      _postDatasource.getAllPosts(pageNumber: pageNumber, pageSize: pageSize);

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
  }) =>
      _postDatasource.updatePostByPostId(
        postId,
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

  Future<void> deletePost(int postId) => _postDatasource.deletePost(postId);

  Future<List<Post>> getUserPosts({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) =>
      _postDatasource.getUserPosts(
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchValue: searchValue,
      );

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
  }) =>
      _postDatasource.filterPosts(
        properties: properties,
        minPrice: minPrice,
        maxPrice: maxPrice,
        minArea: minArea,
        maxArea: maxArea,
        addressWardId: addressWardId,
        categoryId: categoryId,
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchValue: searchValue,
      );

  Future<Post> getDetailPostById(int postId) =>
      _postDatasource.getDetailPostById(postId);

  Future<List<Post>> getPostsByHostId(int hostId) =>
      _postDatasource.getPostsByHostId(hostId);

  Future<List<Post>> getRelatedPost({
    required int quantity,
    required int postId,
    required int addressWardId,
  }) =>
      _postDatasource.getRelatedPost(
        addressWardId: addressWardId,
        postId: postId,
        quantity: quantity,
      );
}
